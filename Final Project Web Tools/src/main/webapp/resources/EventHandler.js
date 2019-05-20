/**
 * 
 */

// Admin Page Events
function addField() {
	let value = document.getElementById("criteria").value;
	let mainDiv = document.getElementById("mainDiv");
	if (value == "eventId" || value == "state" || value == "city"
			|| value == "eventName" || value == "organizerEmail"
			|| value == "zipCode") {
		mainDiv.innerHTML = "<input type='text' name='value' class='form-control' id='date' placeholder='Enter Text'>";
	}
	if (value == "eventCategory") {
		mainDiv.innerHTML = "<select name='value' class='form-control' id='sel1'>"
				+ "<option>Select Event Category</option>"
				+ "<option>Music</option>"
				+ "<option>Food and Drinks</option>"
				+ "<option>Spirituality</option>"
				+ "<option>Comedy</option>"
				+ "<option>Charity</option>"
				+ "<option>Education</option>"
				+ "<option>Film and Awards</option>"
				+ "<option>Science and Tech</option>"
				+ "<option>Fashion</option>"
				+ "<option>Health</option>"
				+ "<option>Sports</option>" + "</select>"
	}
	if (value == "eventStatus") {
		mainDiv.innerHTML = "<select name='value' class='form-control' id='sel1'>"
				+ "<option>Approved</option>"
				+ "<option>Created</option>"
				+ "</select>";
	}
	if (value == "eventType") {
		mainDiv.innerHTML = "<select name='value' class='form-control' id='sel1'>"
				+ "<option>Paid</option>"
				+ "<option>Free</option>"
				+ "</select>";
	}
	if (value == "eventDate") {
		mainDiv.innerHTML = "<input type='date' name='value' class='form-control' id='date' placeholder='Enter Text'>";
	}
	console.log(value);
}

// User Cancel Boooking Events
function cancelBooking(bookingId) {
	let btn = document.getElementById("cancel");
	btn.setAttribute("href", "/app/cancelbooking.htm?bookingId=" + bookingId);
	$("#myModal").modal();
}

// Function to clear fields of Create Event Page
function clearFields(){
	let elements = document.getElementsByClassName("form-control");
	for(let i=0;i<elements.length;i++){
		elements[i].value="";
	}
}
