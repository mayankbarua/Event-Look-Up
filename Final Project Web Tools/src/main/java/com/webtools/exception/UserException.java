package com.webtools.exception;

public class UserException extends Exception {
	public UserException(String message) {
		super("AdvertException-" + message);
	}

	public UserException(String message, Throwable cause) {
		super("AdvertException-" + message, cause);
	}
}
