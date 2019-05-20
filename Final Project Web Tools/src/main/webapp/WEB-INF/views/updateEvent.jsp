<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
			<h2>Update Event</h2>
		</div>
	</section>
	<!-- ##### Breadcumb Area End ##### -->

	<!-- ##### Login Area Start ##### -->
	<section class="login-area section-padding-100">
		<div class="container">
			<br>
			<div class="row justify-content-center">
				<div class="col-12 col-lg-8">
					<div class="login-content">
						<c:if test="${message !=null}">
							<div class="alert alert-success">
								<strong>Success!</strong> Event Created Successfully.
							</div>
						</c:if>
						<br>
						<h3>Welcome Back</h3>
						<!-- Login Form -->
						<div class="login-form">
							<form:form action="/app/admin/updateevent.htm" method="post"
								commandName="event" enctype="multipart/form-data">
								<input type="hidden" name="eventId"
									value="${event.getEventId()}" />
								<div class="form-group">
									<label for="exampleInputEmail1">Event Name</label>
									<form:input path="eventName" type="text" class="form-control"
										value="${event.getEventName()}" id="exampleInputEmail1"
										aria-describedby="emailHelp" placeholder="Enter Event Name" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="eventName" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Organizer Name</label>
									<form:input path="organizerName" type="text"
										value="${event.getOrganizerName()}" class="form-control"
										id="exampleInputEmail1" placeholder="Organizer Name" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="organizerName" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Organizer Email ID</label>
									<form:input path="organizerEmail" type="email"
										value="${event.getOrganizerEmail()}" class="form-control"
										id="exampleInputEmail1" placeholder="Organizer Email ID" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors
											path="organizerEmail" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Organizer Contact
										Number </label>
									<form:input type="text" path="organizerContactNumber"
										value="${event.getOrganizerContactNumber()}"
										class="form-control" id="exampleInputEmail1"
										placeholder="Organizer Contact Number" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors
											path="organizerContactNumber" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Full Address</label>
									<form:input path="address" type="text" class="form-control"
										value="${event.getAddress()}" id="exampleInputEmail1"
										placeholder="Full Address" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="address" /></small>

								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">State</label>
									<form:input path="state" type="text" class="form-control"
										value="${event.getState()}" id="exampleInputEmail1"
										placeholder="State" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="state" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">City</label>
									<form:input path="city" type="text" class="form-control"
										value="${event.getCity()}" id="exampleInputEmail1"
										placeholder="City" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="city" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">ZipCode</label>
									<form:input path="zipCode" type="text" class="form-control"
										id="exampleInputEmail1" placeholder="ZipCode" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="zipCode" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Event Date</label>
									<form:input path="eventDate" type="date" class="form-control"
										name="eventDate" value="${event.getEventDate()}"
										id="exampleInputEmail1" placeholder="Event Date" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i>${dateError}</small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Event Status</label>
									<form:input path="eventStatus" type="text" class="form-control"
										name="eventStatus" value="${event.getEventStatus()}"
										id="exampleInputEmail1" placeholder="Event Date" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i>
									<form:errors path="eventStatus" /></small>
								</div>
								<div class="form-group">
									<label for="comment">Description:</label>
									<form:textarea path="description" class="form-control" rows="5"
										value="${event.getDescription()}" id="comment"></form:textarea>
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="description" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Video URL For Event</label>
									<form:input path="videoUrl" type="text" class="form-control"
										value="${event.getVideoUrl()}" id="exampleInputEmail1"
										placeholder="Video URL for Event" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i>Optional</small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Number Of Seats</label>
									<form:input path="numberOfSeats" type="text"
										value="${event.getNumberOfSeats()}" class="form-control"
										id="exampleInputEmail1" placeholder="Event Ticket Price" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="numberOfSeats" /></small>
								</div>
								<button type="submit" class="btn oneMusic-btn mt-30">Update
									Event</button>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ##### Login Area End ##### -->

	<!-- ##### Footer Area Start ##### -->
	<footer class="footer-area">
		<div class="container">
			<div class="row d-flex flex-wrap align-items-center">
				<div class="col-12 col-md-6">
					<a href="#"><img
						src="<c:url value="/resources/img/core-img/logo.png"/>" alt=""></a>
					<p class="copywrite-text">
						<a href="#"> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;<script>
								document.write(new Date().getFullYear());
							</script> All rights reserved | This template is made with <i
							class="fa fa-heart-o" aria-hidden="true"></i> by <a
							href="https://colorlib.com" target="_blank">Colorlib</a> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</p>
				</div>

				<div class="col-12 col-md-6">
					<div class="footer-nav">
						<ul>
							<li><a href="#">Home</a></li>
							<li><a href="#">Events</a></li>
							<li><a href="#">News</a></li>
							<li><a href="#">Contact</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- ##### Footer Area Start ##### -->
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
</body>

</html>