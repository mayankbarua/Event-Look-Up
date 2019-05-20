package com.webtools.validators;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.webtools.pojo.Address;

public class AddressValidator implements Validator {
	@Override
	public boolean supports(Class clazz) {
		return Address.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address", "error.address", "Address is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "country", "error.country", "Country is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "state", "error.state", "State is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "city", "error.city", "City is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "zipCode", "error.zipCode", "Zip Code is required.");
	}

}
