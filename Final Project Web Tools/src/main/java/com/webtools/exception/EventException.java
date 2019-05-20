package com.webtools.exception;

public class EventException extends Exception {
	
	public EventException(String message) {
		super("AdvertException-" + message);
	}

	public EventException(String message, Throwable cause) {
		super("AdvertException-" + message, cause);
	}
}
