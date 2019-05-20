<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title -->
<title>Event Look Up</title>

<!-- Favicon -->
<link rel="icon"
	href="<c:url value="/resources/img/core-img/favicon.ico"/>">

<!-- Stylesheet -->
<link rel="stylesheet" href="<c:url value="/resources/style.css" />">


</head>

<body>
	<!-- Preloader -->
	<div class="preloader d-flex align-items-center justify-content-center">
		<div class="lds-ellipsis">
			<div></div>
			<div></div>
			<div></div>
			<div></div>
		</div>
	</div>

	<!-- ##### Header Area Start ##### -->
	<header class="header-area">
		<!-- Navbar Area -->
		<div class="oneMusic-main-menu">
			<div class="classy-nav-container breakpoint-off">
				<div class="container">
					<!-- Menu -->
					<nav class="classy-navbar justify-content-between" id="oneMusicNav">

						<!-- Nav brand -->
						<a href="index.html" class="nav-brand"><img
							src="<c:url value="/resources/img/core-img/logo.png"/>" alt=""></a>

						<!-- Navbar Toggler -->
						<div class="classy-navbar-toggler">
							<span class="navbarToggler"><span></span><span></span><span></span></span>
						</div>

						<!-- Menu -->
						<div class="classy-menu">

							<!-- Close Button -->
							<div class="classycloseIcon">
								<div class="cross-wrap">
									<span class="top"></span><span class="bottom"></span>
								</div>
							</div>

							<!-- Nav Start -->
							<div class="classynav">
								<ul>
									<li><a href="/app/admin/adminHomePage.htm?pageNumber=1">Home</a></li>
									<li><a href="/app/admin/createadmin.htm">Add New Admin</a></li>
									<li><a href="/app/admin/eventsearch.htm">Search Event</a></li>
									<li><a href="/app/logout.htm">log Out</a></li>
								</ul>

								<!-- Login/Register & Cart Button -->
								<div
									class="login-register-cart-button d-flex align-items-center">
									<!-- Login/Register -->
									<c:if test="${user==null}">
										<div
											class="login-register-cart-button d-flex align-items-center">
											<!-- Login/Register -->
											<div class="login-register-btn mr-50">
												<a href="login.htm" id="loginBtn">Login / Register</a>
											</div>
										</div>
									</c:if>
								</div>
							</div>
							<!-- Nav End -->
						</div>
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- ##### Header Area End ##### -->

	<!-- ##### Breadcumb Area Start ##### -->
	<section class="breadcumb-area bg-img bg-overlay"
		style="background-image: url(<c:url value="/resources/img/bg-img/breadcumb3.jpg"/>);">
		<div class="bradcumbContent">
			<p>See what’s new</p>
			<h2>Events</h2>
		</div>
	</section>
	<!-- ##### Breadcumb Area End ##### -->

	<section class="contact-area section-padding-0-100">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="section-heading">
						<p></p>
						<h2></h2>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-12">
					<!-- Contact Form Area -->
					<div class="contact-form-area">
						<form action="/app/admin/eventsearch.htm" method="post">
							<div class="row">
								<div class="col-md-6 col-lg-4">
									<div class="form-group">
										<select id="criteria" name="criteria" class="form-control"
											id="sel1" onclick="addField()">
											<option>Select Event Criteria</option>
											<option>eventId</option>
											<option>eventDate</option>
											<option>state</option>
											<option>city</option>
											<option>eventCategory</option>
											<option>eventName</option>
											<option>eventStatus</option>
											<option>eventType</option>
											<option>organizerEmail</option>
											<option>zipCode</option>
										</select>
									</div>
								</div>

								<div class="col-lg-4">
									<div class="form-group" id="mainDiv"></div>
								</div>
							</div>
							<div align="center">
								<button type="submit" class="btn oneMusic-btn mt-30">Search</button>
							</div>
						</form>
						<br>
						<c:if test="${eventList.size() == 0 && eventList !=null}">
							<div class="alert alert-danger">
								<strong>Oops!</strong> No Event For Specific Criteria
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<section class="events-area section-padding-100">
			<div class="container">

				<table class="table table-striped">
					<thead>
						<tr>
							<th>Event Name</th>
							<th>Organizer Name</th>
							<th>Organizer Email</th>
							<th>Organizer Contact Number</th>
							<th>Event Date</th>
							<th>Address</th>
							<th>State</th>
							<th>City</th>
							<th>Event Category</th>
							<th>Event Type</th>
							<th>Ticket Price</th>
							<th>Number Of Seats</th>
							<th>Event Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="event" items="${eventList}">
							<tr>
								<td>${event.getEventName()}</td>
								<td>${event.getOrganizerName()}</td>
								<td>${event.getOrganizerEmail()}</td>
								<td>${event.getOrganizerContactNumber()}</td>
								<td>${event.getEventDate()}</td>
								<td>${event.getAddress()}</td>
								<td>${event.getState()}</td>
								<td>${event.getCity()}</td>
								<td>${event.getEventCategory()}</td>
								<td>${event.getEventType()}</td>
								<td>${event.getTicketPrice()}</td>
								<td>${event.getNumberOfSeats()}</td>
								<td>${event.getEventStatus()}</td>
								<td><a
									href="/app/admin/updateevent.htm?eventId=${event.getEventId()}"
									class="btn see-more-btn">Update Event</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<c:if test="${numberOfPages>1}">
				<div class="row">

					<div class="col-12">
						<div class="load-more-btn text-center mt-70">
							<c:forEach var="i" begin="1" end="${numberOfPages}">
								<a href="/app/admin/adminHomePage.htm?pageNumber=${i}">&nbsp;${i}&nbsp;
									<i class="fa fa-angle-double-right"></i>
								</a>
							</c:forEach>
						</div>
					</div>

				</div>
			</c:if>
		</section>

	</section>

	<!-- ##### Events Area Start ##### -->

	<!-- ##### Events Area End ##### -->

	<!-- ##### All Javascript Script ##### -->

	<!-- jQuery-2.2.4 js -->
	<script src="<c:url value="/resources/js/jquery/jquery-2.2.4.min.js"/>"></script>
	<!-- Popper js -->
	<script src="<c:url value="/resources/js/bootstrap/popper.min.js"/>"></script>
	<!-- Bootstrap js -->
	<script src="<c:url value="/resources/js/bootstrap/bootstrap.min.js"/>"></script>
	<!-- All Plugins js -->
	<script src="<c:url value="/resources/js/plugins/plugins.js"/>"></script>
	<!-- Active js -->
	<script src="<c:url value="/resources/js/active.js"/>"></script>
	<!-- Events for Page -->
	<script src="<c:url value="/resources/EventHandler.js"/>"></script>
</body>

</html>