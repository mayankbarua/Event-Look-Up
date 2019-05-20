package com.webtools.Dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.webtools.exception.BookingException;
import com.webtools.pojo.Booking;
import com.webtools.pojo.Event;

public class BookingDAO extends DAO {
	public boolean confirmBooking(Booking booking) throws BookingException {
		boolean flag = false;
		try {
			Session session = getSession();
			begin();
			Criteria criteria = session.createCriteria(Event.class);
			criteria.add(Restrictions.eq("eventId", booking.getEventId()));
			Event event = (Event) criteria.uniqueResult();
			commit();
			if (event.getNumberOfSeats() != 0) {
				begin();
				session.save(booking);
				Query query = session
						.createQuery("update Event set numberOfSeats = :numberOfSeats where eventId = :eventId");
				query.setParameter("numberOfSeats", event.getNumberOfSeats() - booking.getNumberOfTickets());
				query.setParameter("eventId", booking.getEventId());
				int result = query.executeUpdate();
				commit();
				flag = true;
			}
		} catch (HibernateException e) {
			rollback();
			throw new BookingException("Exception while confirming booking: " + e.getMessage());
		}
		return flag;
	}

	public Booking getBookingDetails(long bookingId) throws BookingException {
		Booking booking = null;
		try {
			Session session = getSession();
			begin();
			Criteria criteria = session.createCriteria(Booking.class);
			criteria.add(Restrictions.eq("bookingId", bookingId));
			booking = (Booking) criteria.uniqueResult();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new BookingException("Exception while Getting booking: " + e.getMessage());
		}
		return booking;
	}

	public void cancelBooking(long bookingId) throws BookingException {
		Session session = getSession();
		Booking booking = null;
		Event event = null;
		try {
			begin();
			Criteria criteria = session.createCriteria(Booking.class);
			criteria.add(Restrictions.eq("bookingId", bookingId));
			booking = (Booking) criteria.uniqueResult();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new BookingException("Exception while cancel booking: " + e.getMessage());
		}

		try {
			begin();
			Criteria eventCriteria = session.createCriteria(Event.class);
			eventCriteria.add(Restrictions.eq("eventId", booking.getEventId()));
			event = (Event) eventCriteria.uniqueResult();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new BookingException("Exception while cancel booking: " + e.getMessage());
		}
		try {
			begin();
			Query query = session.createQuery(
					"update Booking set bookingStatus = :bookingStatus, numberOfTickets = :numberOfTickets where bookingId = :bookingId");
			query.setParameter("numberOfTickets", 0);
			query.setParameter("bookingStatus", "Cancel");
			query.setParameter("bookingId", bookingId);
			int result = query.executeUpdate();
			Query eventQuery = session
					.createQuery("update Event set numberOfSeats = :numberOfSeats where eventId = :eventId");
			eventQuery.setParameter("numberOfSeats", event.getNumberOfSeats() + booking.getNumberOfTickets());
			eventQuery.setParameter("eventId", booking.getEventId());
			int EventResult = eventQuery.executeUpdate();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new BookingException("Exception while cancel booking: " + e.getMessage());
		}

	}

}
