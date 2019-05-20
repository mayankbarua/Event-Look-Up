package com.webtools.exception;

public class BookingException extends Exception {
	
	public BookingException(String message) {
		super("AdvertException-" + message);
	}

	public BookingException(String message, Throwable cause) {
		super("AdvertException-" + message, cause);
	}
}
