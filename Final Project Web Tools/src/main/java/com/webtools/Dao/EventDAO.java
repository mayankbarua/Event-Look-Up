package com.webtools.Dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.webtools.exception.BookingException;
import com.webtools.exception.EventException;
import com.webtools.pojo.Event;

public class EventDAO extends DAO {
	public void createEvent(Event event) throws EventException {
		try {
			begin();
			getSession().save(event);
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event create: " + e.getMessage());
		}
	}

	public List<Event> search(String city, String category, String date) throws ParseException, EventException {
		try {
			List<Event> event = null;
			Session session = getSession();
			begin();
			if (category.equals("Select Event Category") && date.equals("")) {
				Criteria criteria = session.createCriteria(Event.class);
				criteria.add(Restrictions.eq("city", city));
				criteria.add(Restrictions.eq("eventStatus", "Approved"));
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date currentDate = new Date();
				criteria.add(Restrictions.ge("eventDate", currentDate));
				event = criteria.list();
			} else if (!category.equals("Select Event Category") && date.equals("")) {
				Criteria criteria = session.createCriteria(Event.class);
				criteria.add(Restrictions.eq("eventStatus", "Approved"));
				criteria.add(Restrictions.eq("city", city));
				criteria.add(Restrictions.eq("eventCategory", category));
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date currentDate = new Date();
				criteria.add(Restrictions.ge("eventDate", currentDate));
				event = criteria.list();
			} else if (category.equals("Select Event Category") && !date.equals("")) {
				Criteria criteria = session.createCriteria(Event.class);
				criteria.add(Restrictions.eq("city", city));
				criteria.add(Restrictions.eq("eventStatus", "Approved"));
				Date d = new SimpleDateFormat("yyyy-MM-dd").parse(date);
				criteria.add(Restrictions.eq("eventDate", d));
				event = criteria.list();
			} else {
				Criteria criteria = session.createCriteria(Event.class);
				criteria.add(Restrictions.eq("city", city));
				criteria.add(Restrictions.eq("eventStatus", "Approved"));
				criteria.add(Restrictions.eq("eventCategory", category));
				Date d = new SimpleDateFormat("yyyy-MM-dd").parse(date);
				criteria.add(Restrictions.eq("eventDate", d));
				event = criteria.list();
			}
			commit();
			return event;
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event search: " + e.getMessage());
		}
	}

	public Map<String, List<Event>> defaultEvents() throws EventException {
		Map<String, List<Event>> result = new HashMap<String, List<Event>>();
		try {
			Session session = getSession();
			begin();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date currentDate = new Date();
			Criteria criteriaMusic = session.createCriteria(Event.class);
			criteriaMusic.add(Restrictions.eq("eventCategory", "Music"));
			criteriaMusic.add(Restrictions.eq("eventStatus", "Approved"));
			criteriaMusic.setFirstResult(0);
			criteriaMusic.setMaxResults(3);
			criteriaMusic.add(Restrictions.ge("eventDate", currentDate));
			result.put("Music", criteriaMusic.list());
			commit();

			begin();
			Criteria criteriaSport = session.createCriteria(Event.class);
			criteriaSport.add(Restrictions.eq("eventCategory", "Sports"));
			criteriaSport.add(Restrictions.eq("eventStatus", "Approved"));
			criteriaSport.setFirstResult(0);
			criteriaSport.setMaxResults(3);
			criteriaSport.add(Restrictions.ge("eventDate", currentDate));
			result.put("Sports", criteriaSport.list());
			commit();

			begin();
			Criteria criteriaFoods = session.createCriteria(Event.class);
			criteriaFoods.add(Restrictions.eq("eventCategory", "Food and Drinks"));
			criteriaFoods.add(Restrictions.eq("eventStatus", "Approved"));
			criteriaFoods.setFirstResult(0);
			criteriaFoods.setMaxResults(3);
			criteriaFoods.add(Restrictions.ge("eventDate", currentDate));
			result.put("Food and Drinks", criteriaFoods.list());
			commit();
			return result;
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event default list: " + e.getMessage());
		}
	}

	public Event getDetail(long id) throws EventException {
		Event event = null;
		try {
			begin();
			Session session = getSession();
			Criteria criteria = session.createCriteria(Event.class);
			criteria.add(Restrictions.eq("eventId", id));
			event = (Event) criteria.uniqueResult();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event detail: " + e.getMessage());
		}
		return event;
	}

	public List<Event> getNewCreatedEvents(int from, int to) throws EventException {
		List<Event> events = null;
		Session session = getSession();
		try {
			begin();
			Criteria criteria = session.createCriteria(Event.class);
			criteria.add(Restrictions.eq("eventStatus", "Created"));
			criteria.setFirstResult(from);
			criteria.setMaxResults(to);
			criteria.addOrder(Order.asc("eventDate"));
			events = criteria.list();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event get new created: " + e.getMessage());
		}
		return events;
	}

	public void approveEvent(long id, String status) throws EventException {
		try {
			Session session = getSession();
			begin();
			Query query = session.createQuery("update Event set eventStatus = :eventStatus where eventId = :eventId");
			query.setParameter("eventStatus", status);
			query.setParameter("eventId", id);
			int result = query.executeUpdate();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event approve: " + e.getMessage());
		}
	}

	public long getNewcreatedEventCount() throws EventException {
		long count = 0;
		try {
			Session session = getSession();
			begin();
			Criteria criteria = session.createCriteria(Event.class);
			criteria.add(Restrictions.eq("eventStatus", "Created"));
			criteria.setProjection(Projections.rowCount());
			count = (Long) criteria.uniqueResult();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event get new created count: " + e.getMessage());
		}
		return count;
	}

	public List adminSearch(String searchKey, String value) throws ParseException, EventException {
		List<Event> events = null;
		Session session = getSession();
		try {
			begin();
			if (searchKey.equals("eventId")) {
				Criteria criteria = session.createCriteria(Event.class);
				criteria.add(Restrictions.eq(searchKey, Long.parseLong(value)));
				events = criteria.list();
			} else if (searchKey.equals("eventDate")) {
				Criteria criteria = session.createCriteria(Event.class);
				Date d = new SimpleDateFormat("yyyy-MM-dd").parse(value);
				criteria.add(Restrictions.eq(searchKey, d));
				events = criteria.list();
			} else {
				Criteria criteria = session.createCriteria(Event.class);
				criteria.add(Restrictions.eq(searchKey, value));
				events = criteria.list();
			}
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event admin search: " + e.getMessage());
		}
		return events;
	}

	public int updateEvent(Event event, long eventId) throws EventException {
		int result = 0;
		try {
			Session session = getSession();
			begin();
			Query query = session.createQuery(
					"update Event set eventName = :eventName, organizerName =:organizerName, organizerEmail = :organizerEmail, organizerContactNumber = :organizerContactNumber, address = :address, state = :state, city = :city, zipCode = :zipCode, eventDate = :eventDate, description = :description, videoUrl = :videoUrl, numberOfSeats = :numberOfSeats where eventId = :eventId");
			query.setParameter("eventName", event.getEventName());
			query.setParameter("organizerName", event.getOrganizerName());
			query.setParameter("organizerEmail", event.getOrganizerEmail());
			query.setParameter("organizerContactNumber", event.getOrganizerContactNumber());
			query.setParameter("address", event.getAddress());
			query.setParameter("state", event.getState());
			query.setParameter("city", event.getCity());
			query.setParameter("zipCode", event.getZipCode());
			query.setParameter("eventDate", event.getEventDate());
			query.setParameter("description", event.getDescription());
			query.setParameter("videoUrl", event.getVideoUrl());
			query.setParameter("numberOfSeats", event.getNumberOfSeats());
			query.setParameter("eventId", eventId);
			result = query.executeUpdate();
			commit();
		} catch (HibernateException e) {
			rollback();
			throw new EventException("Exception while event update: " + e.getMessage());
		}
		return result;
	}
}
