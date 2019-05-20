# Event Look Up

## Project Summary :
* Event Look up is an event management system where user can search, and book event based on location, date and category. User can also create an event and any user can book that event. The user created event will only be available on portal after admin approval, once event is approved by admin, that event is ready for booking. 

## Functionalities:
*	User can search, and book event based on location, date and category.
*	User can create an account for event booking and managing.
*	User can create an event and can add a video URL to the event.
*	Event location will be displayed on Google Map.
*	User can cancel already booked event.
*	User can view his/her booking history.
*	User can download his/her booking ticket as PDF.
*	User can get his/her booked event details via email on single click.
*	User can manage his/her account.

## User roles and their tasks :
###	Admin
	* Whenever event is created, admin can approve and reject event
	* Admin can create new admin
	* Admin can update any events
	* Admin can search any event with any criteria like search based on event id, event location, event category, event type etc.

### User
	* User can search, and book event based on location, date and category.
	* User can create an account for event booking and managing.
	* User can cancel already booked event.
	* User can view his/her booking history.
	* User can download his/her booking ticket as PDF.
	* User can get his/her booked event details via email on single click.
	* User can manage his/her account.
	
### Event creator:
	* User can create an event
	
## Technologies :	
### Front end
	* HTML
	* CSS
	* JavaScript
	* Bootstrap
	* JSP
	
### Back End
	* Spring MVC
	* Hibernate

### Databas
	* MySQL
	
## Prerequisites
* Spring Tool Suit or Eclipse with Spring Suit
* MySQL 5.XX or above
* To enable google map navigate to eventDetail.jsp and add google Map key under axios.get method and script tag.
* To enable email sending navigate to BookingController.java under com.webtools.Controller package and add email and password in sendEmail method for email.setAuthenticator
* To enable image storing navigate to EventController.java under com.webtools.Controller and change localPath variable to location where you want to store image under processSubmit method.
* To enable image accessing add context path in web.xml of your apache, of where you have stored the images.  


