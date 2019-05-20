package com.webtools.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.webtools.Dao.EventDAO;
import com.webtools.exception.EventException;
import com.webtools.pojo.Event;
import com.webtools.pojo.User;
import com.webtools.validators.EventUpdateValidator;
import com.webtools.validators.EventValidator;

@Controller
public class EventController {

	private EventValidator eventValidator;
	private EventUpdateValidator eventUpdateValidator;

	@Autowired
	private EventDAO eventDao;

	@Autowired
	public EventController(EventValidator eventValidator, EventUpdateValidator eventUpdateValidator) {
		this.eventValidator = eventValidator;
		this.eventUpdateValidator = eventUpdateValidator;
	}

	@RequestMapping(value = "/createevent.htm", method = RequestMethod.GET)
	public String initForm(ModelMap model) {
		try {
			Event event = new Event();
			model.addAttribute("event", event);
			return "createEvent";
		} catch (Exception ex) {
			return "createEvent";
		}
	}

	@RequestMapping(value = "/createevent.htm", method = RequestMethod.POST)
	public ModelAndView processSubmit(@ModelAttribute("event") Event event, HttpServletRequest request,
			BindingResult result, SessionStatus status) throws IOException, EventException {

		String eventDate = request.getParameter("eventDate");
		if (eventDate.equals("")) {
			return new ModelAndView("createEvent", "dateError", "Please select a Date");
		} else {
			eventValidator.validate(event, result);
			if (result.hasErrors()) {
				return new ModelAndView("createEvent");
			} else {
				Event newEvent = event;
				String localPath = "Path where you want to store image";
				if (newEvent.getImage().getOriginalFilename().equals("")) {
					newEvent.setImagePath("1555357833441 e1.jpg");
					newEvent.setEventStatus("Created");
					status.setComplete();
					eventDao.createEvent(newEvent);
				} else {
					String photoNewName = generateFileNewName(newEvent.getImage());
					newEvent.setImagePath(photoNewName);
					event.getImage().transferTo(new File(localPath, photoNewName));
					newEvent.setEventStatus("Created");
					status.setComplete();
					eventDao.createEvent(newEvent);
				}
				return new ModelAndView("createEvent", "message", "success");
			}
		}
	}

	@RequestMapping(value = "/eventsearch.htm", method = RequestMethod.GET)
	public ModelAndView defaultEvents() throws UnsupportedEncodingException, EventException {
		ModelAndView modelAndView = null;
		HashMap<String, List<Event>> defaultEventList = (HashMap) eventDao.defaultEvents();
		modelAndView = new ModelAndView("event", "defaultEventList", defaultEventList);
		return modelAndView;
	}

	@RequestMapping(value = "/eventsearch.htm", method = RequestMethod.POST)
	public ModelAndView searchEvent(HttpServletRequest request)
			throws UnsupportedEncodingException, ParseException, EventException {
		ModelAndView modelAndView = null;
		String city = request.getParameter("city");
		String category = request.getParameter("category");
		String date = request.getParameter("date");
		ArrayList<Event> events = (ArrayList<Event>) eventDao.search(city, category, date);
		modelAndView = new ModelAndView("event");
		modelAndView.addObject("eventList", events);
		return modelAndView;
	}

	@RequestMapping(value = "/eventdetail.htm", method = RequestMethod.GET)
	public ModelAndView getEventDetail(HttpServletRequest request, @RequestParam("eventId") long id)
			throws UnsupportedEncodingException, EventException {
		ModelAndView modelAndView = null;
		Event event = eventDao.getDetail(id);
		modelAndView = new ModelAndView("eventDetail", "event", event);
		return modelAndView;
	}

	@RequestMapping(value = "/admin/approveevent.htm", method = RequestMethod.GET)
	public ModelAndView approveEvent(HttpServletRequest request, @RequestParam("eventId") long id)
			throws EventException {
		ModelAndView modelAndView = null;
		eventDao.approveEvent(id, "Approved");
		modelAndView = new ModelAndView(new RedirectView("/app/admin/adminHomePage.htm?pageNumber=1"));
		return modelAndView;
	}

	@RequestMapping(value = "/admin/cancelevent.htm", method = RequestMethod.GET)
	public ModelAndView cancelEvent(HttpServletRequest request, @RequestParam("eventId") long id)
			throws EventException {
		ModelAndView modelAndView = null;
		eventDao.approveEvent(id, "Cancel");
		modelAndView = new ModelAndView(new RedirectView("/app/admin/adminHomePage.htm?pageNumber=1"));
		return modelAndView;
	}

	private String generateFileNewName(MultipartFile multipart) {
		return new java.util.Date().getTime() + " " + multipart.getOriginalFilename().replace(" ", "-");
	}

	@RequestMapping(value = "/admin/eventsearch.htm", method = RequestMethod.GET)
	public ModelAndView adminSearchEvent(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		ModelAndView modelAndView = null;
		User loggedUser = (User) session.getAttribute("user");
		if (loggedUser != null && loggedUser.getRole().equals("Admin")) {
			modelAndView = new ModelAndView("adminEventSearch");
		} else {
			modelAndView = new ModelAndView("errorPage");
		}
		return modelAndView;
	}

	@RequestMapping(value = "/admin/eventsearch.htm", method = RequestMethod.POST)
	public ModelAndView adminSearchEventCriteria(HttpServletRequest request) throws ParseException, EventException {
		ModelAndView modelAndView = null;
		HttpSession session = request.getSession(false);
		User loggedUser = (User) session.getAttribute("user");
		if (loggedUser != null && loggedUser.getRole().equals("Admin")) {
			String searchKey = request.getParameter("criteria");
			String value = request.getParameter("value");
			ArrayList<Event> eventList = (ArrayList<Event>) eventDao.adminSearch(searchKey, value);
			modelAndView = new ModelAndView("adminEventSearch", "eventList", eventList);
		} else {
			modelAndView = new ModelAndView("errorPage");
		}
		return modelAndView;
	}

	@RequestMapping(value = "/admin/updateevent.htm", method = RequestMethod.GET)
	public ModelAndView updateEvent(HttpServletRequest request, @RequestParam("eventId") long id)
			throws EventException {
		ModelAndView modelAndView = null;
		HttpSession session = request.getSession(false);
		if (session != null) {
			User loggedUser = (User) session.getAttribute("user");
			if (loggedUser == null) {
				modelAndView = new ModelAndView(new RedirectView("/app/login.htm"));
			} else {
				if (loggedUser.getRole().equals("Admin")) {
					Event event = eventDao.getDetail(id);
					modelAndView = new ModelAndView("updateEvent", "event", event);
				} else {
					modelAndView = new ModelAndView("errorPage");
				}
			}
		} else {
			modelAndView = new ModelAndView(new RedirectView("/app/login.htm"));
		}
		return modelAndView;
	}

	@RequestMapping(value = "/admin/updateevent.htm", method = RequestMethod.POST)
	public ModelAndView updateEventToDB(@ModelAttribute("event") Event event, HttpServletRequest request,
			BindingResult result, SessionStatus status) throws EventException {
		ModelAndView modelAndView = null;
		long id = Long.parseLong(request.getParameter("eventId"));
		int update = eventDao.updateEvent(event, id);
		if (update != 0) {
			modelAndView = new ModelAndView("updateEvent", "message", "success");
			modelAndView.addObject("event", event);
		}
		return modelAndView;
	}
}
