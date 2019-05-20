package com.webtools.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Set;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.webtools.Dao.EventDAO;
import com.webtools.Dao.UserDAO;
import com.webtools.exception.EventException;
import com.webtools.exception.UserException;
import com.webtools.pojo.Address;
import com.webtools.pojo.Booking;
import com.webtools.pojo.Event;
import com.webtools.pojo.User;
import com.webtools.validators.LoginValidator;
import com.webtools.validators.UserValidator;

@Controller
public class UserController {

	private UserValidator userValidator;
	private LoginValidator loginValidator;

	@Autowired
	private UserDAO userDao;

	@Autowired
	private EventDAO eventDao;

	@Autowired
	public UserController(UserValidator userValidator, LoginValidator loginValidator) {
		this.userValidator = userValidator;
		this.loginValidator = loginValidator;
	}

	@RequestMapping(value = "/registeruser.htm", method = RequestMethod.GET)
	public String initForm(ModelMap model) {
		User user = new User();
		model.addAttribute("user", user);
		return "registration";
	}

	@RequestMapping(value = "/registeruser.htm", method = RequestMethod.POST)
	public ModelAndView processSubmit(@ModelAttribute("user") User user, HttpServletRequest request,
			BindingResult result, SessionStatus status) throws IOException, UserException {
		ModelAndView modelAndView = null;
		String confirmEmail = request.getParameter("confirmEmail");
		String confirmPassword = request.getParameter("confirmPassword");
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return new ModelAndView("registration");
		} else {
			if (confirmEmail.equals(user.getUserEmail())) {
				if (confirmPassword.equals(user.getPassword())) {
					User fetchedUser = userDao.checkEmailId(user.getUserEmail());
					if (fetchedUser == null) {
						user.setRole("User");
						userDao.register(user);
						modelAndView = new ModelAndView("registration", "message", "message");
					} else {
						modelAndView = new ModelAndView("registration", "userExist",
								"Account is already created with this email.");
					}
				} else {
					modelAndView = new ModelAndView("registration", "passwordMatch",
							"Password and Confirm Password are not same");
				}
			} else {

				modelAndView = new ModelAndView("registration", "emailMatch", "Email and Confirm Email are not same");
			}
		}
		return modelAndView;
	}

	@RequestMapping(value = "/login.htm", method = RequestMethod.GET)
	public ModelAndView initFormLogin(ModelMap model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		ModelAndView modelAndView = null;
		User loggedUser = (User) session.getAttribute("user");
		if (loggedUser == null) {
			User user = new User();
			model.addAttribute("user", user);
			modelAndView = new ModelAndView("login");
			return modelAndView;
		}
		modelAndView = new ModelAndView(new RedirectView("/app/eventsearch.htm"));
		return modelAndView;
	}

	@RequestMapping(value = "/login.htm", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("user") User user, HttpServletRequest request, BindingResult result,
			SessionStatus status) throws UserException {

		ModelAndView modelAndView = null;
		HttpSession session = request.getSession(false);
		Event event = null;
		int numbetOfTicketsParameter = 0;
		if (session.getAttribute("event") != null && session.getAttribute("numberOfTickets") != null) {
			event = (Event) session.getAttribute("event");
			numbetOfTicketsParameter = (Integer) session.getAttribute("numberOfTickets");
		}

		User loggedUser = (User) session.getAttribute("user");

		if (loggedUser == null) {
			loginValidator.validate(user, result);
			if (result.hasErrors()) {
				return new ModelAndView("login");
			} else {
				User fetchedUser = userDao.authenticate(user);
				if (fetchedUser == null) {
					return new ModelAndView("login", "message", "Invalid User Email or Password");
				} else {
					if (fetchedUser.getRole().equals("Admin")) {
						session.setAttribute("user", fetchedUser);
						return new ModelAndView(new RedirectView("/app/admin/adminHomePage.htm?pageNumber=1"));
					} else {
						if (event != null && numbetOfTicketsParameter != 0) {
							session.setAttribute("user", fetchedUser);
							if (session.getAttribute("authKey") != null) {
								modelAndView = new ModelAndView("paymentPage", "address", new Address());
							} else {
								modelAndView = new ModelAndView("errorPage");
							}
							return modelAndView;
						} else {
							session.setAttribute("user", fetchedUser);
							return new ModelAndView(new RedirectView("/app/eventsearch.htm"));
						}
					}
				}
			}
		}
		return new ModelAndView(new RedirectView("eventsearch.htm"));
	}

	@RequestMapping(value = "/admin/adminHomePage.htm", method = RequestMethod.GET)
	public ModelAndView adminHomePage(HttpServletRequest request, @RequestParam("pageNumber") int pageNumber)
			throws EventException {
		ModelAndView modelAndView = null;
		ArrayList<Event> events = null;
		HttpSession session = request.getSession(false);
		User loggedUser = (User) session.getAttribute("user");
		if (loggedUser != null) {
			if (loggedUser.getRole().equals("Admin")) {
				if (session.getAttribute("numberOfPages") == null) {
					long count = eventDao.getNewcreatedEventCount();
					int numberOfPages = (int) ((count / 10) + 1);
					session.setAttribute("numberOfPages", numberOfPages);
				}
				if (pageNumber == 1) {
					events = (ArrayList<Event>) eventDao.getNewCreatedEvents(0, 10);
				} else {
					events = (ArrayList<Event>) eventDao.getNewCreatedEvents((pageNumber - 1) * 10, pageNumber * 10);
				}

				modelAndView = new ModelAndView("adminPage", "eventList", events);
				return modelAndView;
			}
		}
		return new ModelAndView("errorPage");
	}

	@RequestMapping(value = "/userbooking.htm", method = RequestMethod.GET)
	public ModelAndView getBooking(HttpServletRequest request) throws UserException {
		ModelAndView modelAndView = null;
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		if (user == null) {
			modelAndView = new ModelAndView(new RedirectView("/app/login.htm"));
		} else {
			User newUser = userDao.checkEmailId(((User) session.getAttribute("user")).getUserEmail());
			session.setAttribute("user", newUser);
			Set<Booking> bookingSet = newUser.getBooking();
			modelAndView = new ModelAndView("userBooking", "bookingSet", bookingSet);
		}
		return modelAndView;
	}

	@RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request) {
		ModelAndView modelAndView = null;
		HttpSession session = request.getSession(false);
		if(session !=null) {
			session.setAttribute("user", null);
			session.invalidate();
		}
		modelAndView = new ModelAndView(new RedirectView("/app/"));
		return modelAndView;
	}

	@RequestMapping(value = "/updateprofile.htm", method = RequestMethod.GET)
	public ModelAndView updateProfilePage(ModelMap model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			User user = new User();
			model.addAttribute("user", user);
			return new ModelAndView("updateProfile");
		}
		return new ModelAndView(new RedirectView("/app/login.htm"));
	}

	@RequestMapping(value = "/updateprofile.htm", method = RequestMethod.POST)
	public ModelAndView updateProfiel(@ModelAttribute("user") User user, HttpServletRequest request,
			BindingResult result, SessionStatus status) throws UserException {
		ModelAndView modelAndView = null;
		HttpSession session = request.getSession(false);
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return new ModelAndView("updateProfile");
		} else {
			String confirmPassword = request.getParameter("confirmPassword");
			if (!confirmPassword.equals(user.getPassword())) {
				return new ModelAndView("updateProfile", "passwordError", "Confirm Password And Password are not same");
			} else {
				long update = userDao.update(user);
				if (update != 0) {
					modelAndView = new ModelAndView("updateProfile", "message", "message");
					session.setAttribute("user", user);
				}
			}
		}
		return modelAndView;
	}

	@RequestMapping(value = "/admin/createadmin.htm", method = RequestMethod.GET)
	public String adminPageInit(ModelMap model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		User loggedUser = (User) session.getAttribute("user");
		if (loggedUser != null && loggedUser.getRole().equals("Admin")) {
			if (loggedUser.getRole().equals("Admin")) {
				User user = new User();
				model.addAttribute("user", user);
				return "createAdmin";
			}
		}
		return "errorPage";
	}

	@RequestMapping(value = "/admin/createadmin.htm", method = RequestMethod.POST)
	public ModelAndView createAdmin(@ModelAttribute("user") User user, HttpServletRequest request, BindingResult result,
			SessionStatus status) throws IOException, UserException {
		HttpSession session = request.getSession(false);
		User loggedUser = (User) session.getAttribute("user");
		if (loggedUser.getRole().equals("Admin")) {
			ModelAndView modelAndView = null;
			String confirmEmail = request.getParameter("confirmEmail");
			String confirmPassword = request.getParameter("confirmPassword");
			userValidator.validate(user, result);
			if (result.hasErrors()) {
				return new ModelAndView("createAdmin");
			} else {
				if (confirmEmail.equals(user.getUserEmail())) {
					if (confirmPassword.equals(user.getPassword())) {
						User fetchedUser = userDao.checkEmailId(user.getUserEmail());
						if (fetchedUser == null) {
							user.setRole("Admin");
							userDao.register(user);
							modelAndView = new ModelAndView("createAdmin", "message", "message");
						} else {
							modelAndView = new ModelAndView("createAdmin", "userExist",
									"Account is already created with this email.");
						}
					} else {
						modelAndView = new ModelAndView("createAdmin", "passwordMatch",
								"Password and Confirm Password are not same");
					}
				} else {

					modelAndView = new ModelAndView("createAdmin", "emailMatch",
							"Email and Confirm Email are not same");
				}
			}
			return modelAndView;
		}
		return new ModelAndView("errorPage");
	}

}
