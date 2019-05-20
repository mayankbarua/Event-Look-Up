package com.webtools.validators;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.hibernate.criterion.Restrictions;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.webtools.pojo.Event;

public class EventValidator implements Validator {

	@Override
	public boolean supports(Class clazz) {
		return Event.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "eventName", "error.eventName", "Event Name is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "organizerName", "error.organizerName",
				"Organizer Name is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "organizerEmail", "error.organizerEmail",
				"Organizer Email is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "organizerContactNumber", "error.organizerContactNumber",
				"Organizer Contact Number is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address", "error.address", "Address is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "city", "error.city", "City is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "state", "error.state", "State is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "zipCode", "error.zipCode", "Zip Code is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "eventCategory", "error.eventCateogry",
				"Event Category is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "error.description",
				"Description is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "eventType", "error.eventType", "Event Type is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ticketPrice", "error.ticketPrice",
				"Ticket Price is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "numberOfSeats", "error.numberOfSeats",
				"Number Of Seats is required.");

		Event event = (Event) target;
		if (event.getEventCategory().equals("Select Event Category")) {
			errors.rejectValue("eventCategory", "notSelectionCategory", new Object[] { "'eventCategory'" },
					"Please select correct event category");
		}
		if (event.getEventType().equals("Select Event Type")) {
			errors.rejectValue("eventType", "notSelectionType", new Object[] { "'eventType'" },
					"Please select event type");
		}
		if(event.getEventType().equals("Paid") && event.getTicketPrice() == 0) {
			errors.rejectValue("ticketPrice", "zeroTicketPrice", new Object[] { "'ticketPrice'" },
					"Ticket Price can't be zero if event type is paid");
		}
		if (event.getNumberOfSeats() == 0) {
			errors.rejectValue("numberOfSeats", "zeroNumberOfSeats", new Object[] { "'numberOfSeats'" },
					"Number of Seats can't be zero");
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Date();
		if(event.getEventDate().compareTo(currentDate)<0) {
			errors.rejectValue("eventDate", "oldDate", new Object[] { "'eventDate'" },
					"Event date is before current Date");
		}
	}

}
