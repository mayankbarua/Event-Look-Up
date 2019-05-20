package com.webtools.validators;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.webtools.pojo.Event;

public class EventUpdateValidator implements Validator {

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
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "eventStatus", "error.eventStatus",
				"EventStatus is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "numberOfSeats", "error.numberOfSeats",
				"Number Of Seats is required.");

		Event event = (Event) target;
		if (event.getNumberOfSeats() == 0) {
			errors.rejectValue("numberOfSeats", "zeroNumberOfSeats", new Object[] { "'numberOfSeats'" },
					"Number of Seats can't be zero");
		}
	}

}
