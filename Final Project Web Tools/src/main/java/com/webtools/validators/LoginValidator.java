package com.webtools.validators;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.webtools.pojo.User;

public class LoginValidator implements Validator{
	@Override
	public boolean supports(Class clazz) {
		return User.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEmail", "error.userEmail", "Email is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "error.password", "Password is required.");
	}
}
