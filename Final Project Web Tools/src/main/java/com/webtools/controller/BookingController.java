package com.webtools.controller;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfWriter;
import com.webtools.Dao.BookingDAO;
import com.webtools.Dao.EventDAO;
import com.webtools.Dao.UserDAO;
import com.webtools.exception.BookingException;
import com.webtools.exception.EventException;
import com.webtools.pojo.Address;
import com.webtools.pojo.Booking;
import com.webtools.pojo.Event;
import com.webtools.pojo.User;
import com.webtools.validators.AddressValidator;
import com.webtools.view.PDFView;

@Controller
public class BookingController {

	@Autowired
	private EventDAO eventDao;

	@Autowired
	private BookingDAO bookingDao;

	@Autowired
	private UserDAO userDao;

	private AddressValidator addressValidator;

	@Autowired
	public BookingController(AddressValidator addressValidator) {
		this.addressValidator = addressValidator;
	}

	@RequestMapping(value = "/booking.htm", method = RequestMethod.GET)
	public ModelAndView booking(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("eventId") long id, @RequestParam("numberOfTickets") int numberOfTickets, ModelMap model,
			Address address) throws ServletException, IOException, EventException {
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		String authKey = request.getParameter("authKey");
		model.addAttribute("address", new Address());
		ModelAndView modelAndView = null;
		Event event = eventDao.getDetail(id);
		session.setAttribute("event", event);
		session.setAttribute("numberOfTickets", numberOfTickets);
		if (user == null) {
			session.setAttribute("authKey", authKey);
			modelAndView = new ModelAndView(new RedirectView("/app/login.htm"));
			modelAndView.addObject("user", new User());
		} else if (authKey != null) {
			modelAndView = new ModelAndView("paymentPage", "eventId", id);
		} else {
			modelAndView = new ModelAndView("errorPage");
		}
		return modelAndView;
	}

	@RequestMapping(value = "/booking.htm", method = RequestMethod.POST)
	public ModelAndView processSubmit(@ModelAttribute("address") Address address, HttpServletRequest request,
			BindingResult result, SessionStatus status, Booking booking) throws IOException, EmailException, BookingException {
		ModelAndView modelAndView = null;
		HttpSession session = request.getSession(false);
		addressValidator.validate(address, result);
		if (result.hasErrors()) {
			return new ModelAndView("paymentPage");
		} else {
			User user = (User) session.getAttribute("user");
			Event event = (Event) session.getAttribute("event");
			int numberOfTickets = (Integer) session.getAttribute("numberOfTickets");
			if (event != null) {
				booking.setUserId(user.getUserId());
				booking.setUserEmail(user.getUserEmail());
				booking.setEventId(event.getEventId());
				booking.setBookingDate(new Date());
				booking.setEventName(event.getEventName());
				booking.setBookingStatus("Confirmed");
				booking.setEventDate(event.getEventDate());
				booking.setNumberOfTickets(numberOfTickets);
				booking.setBillingAddress(address);
				bookingDao.confirmBooking(booking);
				modelAndView = new ModelAndView("bookingSuccess");
				sendEmail(booking, event);
				session.setAttribute("event", null);
				session.setAttribute("numberOfTickets", 0);
				session.removeAttribute("authKey");
			} else {
				modelAndView = new ModelAndView(new RedirectView("/app/eventsearch.htm"));
			}
		}
		return modelAndView;
	}

	private void sendEmail(Booking booking, Event event) throws EmailException {
		Email email = new SimpleEmail();
		email.setHostName("smtp.googlemail.com");
		email.setSmtpPort(465);
		email.setAuthenticator(new DefaultAuthenticator("user email", "password"));
		email.setSSLOnConnect(true);
		email.setFrom("no-reply@msis.neu.edu");
		email.setSubject("Booking Confirmation Receipt");
		email.setMsg("Thank you for booking, Please Find Below Booking Details : Event Name : " + booking.getEventName()
				+ ", Event Date : " + booking.getEventDate() + ", Event Location : " + event.getAddress() + ", "
				+ event.getCity() + ", " + event.getState() + ", " + event.getZipCode() + ", Number Of Tickets : "
				+ booking.getNumberOfTickets() + ", Booking Date : " + booking.getBookingDate() + ", Booking Status : "
				+ booking.getBookingStatus());
		email.addTo("barua.m@husky.neu.edu");
		email.send();
	}

	@RequestMapping(value = "/sendmail.htm", method = RequestMethod.GET)
	public ModelAndView sendEmailTOUser(HttpServletRequest request, @RequestParam("bookingId") long bookingId)
			throws EmailException, BookingException, EventException {
		Booking booking = bookingDao.getBookingDetails(bookingId);
		Event event = eventDao.getDetail(booking.getEventId());
		sendEmail(booking, event);
		ModelAndView modelAndView = new ModelAndView(new RedirectView("/app/userbooking.htm"));
		modelAndView.addObject("mailConfirmation", "Mail Send To Your Email ID");
		return modelAndView;
	}

	@RequestMapping(value = "/cancelbooking.htm", method = RequestMethod.GET)
	public ModelAndView cancelBooking(HttpServletRequest request, @RequestParam("bookingId") long bookingId) throws BookingException {
		ModelAndView modelAndView = null;
		bookingDao.cancelBooking(bookingId);
		modelAndView = new ModelAndView(new RedirectView("/app/userbooking.htm"));
		return modelAndView;
	}

	@RequestMapping(value = "/viewpdf", method = RequestMethod.GET)
	public ModelAndView viewPDF(HttpServletRequest request, @RequestParam("bookingId") long bookingId)
			throws EmailException {
		PDFView pdfView = new PDFView(bookingId);
		ModelAndView modelAndView = new ModelAndView(pdfView);
		return modelAndView;
	}

}
