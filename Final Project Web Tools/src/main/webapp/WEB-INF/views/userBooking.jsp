<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

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


	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Cancel Booking</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">Please confirm if you want to Cancel
					Booking</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<a id="cancel" class="btn btn-secondary">Yes</a> &emsp;
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
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
									<li><a href="/app/">Home</a></li>
									<li><a href="eventsearch.htm">Events</a></li>
									<li><a href="createevent.htm">Create Event</a></li>
									<c:if test="${user!=null}">
										<li><a href="#">My Account</a>
											<ul class="dropdown">
												<li><a href="/app/userbooking.htm">My Booking</a></li>
												<li><a href="/app/updateprofile.htm">Update Profile</a></li>
											</ul></li>
										<li><a href="/app/logout.htm">log Out</a></li>
									</c:if>
								</ul>

								<!-- Login/Register & Cart Button -->
								<c:if test="${user==null}">
									<div
										class="login-register-cart-button d-flex align-items-center">
										<!-- Login/Register -->
										<div class="login-register-btn mr-50">
											<a href="login.htm" id="loginBtn">Login / Register</a>
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
			<h2>Your Booking</h2>
		</div>
		<c:if test="${mailConfirmation!=null}">
			<div class="alert alert-success">
				<strong>Success!</strong> ${mailConfirmation}
			</div>
		</c:if>
	</section>
	<!-- ##### Breadcumb Area End ##### -->

	<!-- ##### Events Area Start ##### -->
	<c:if test="${bookingSet.size()!=0 && bookingSet != null }">
		<section class="events-area section-padding-100">
			<div class="container">
				<div class="row">
					<!-- Single Event Area -->
					<c:forEach var="booking" items="${bookingSet}">
						<div class="col-12 col-md-6 col-lg-4">
							<div class="single-event-area mb-30">
								<div class="event-thumbnail">
									<img src="<c:url value="/resources/userImages/a9.jpg"/>"
										alt="<c:url value="/resources/userImages/1555353600825 a7.jpg"/>" />
								</div>
								<div class="event-text">
									<h4>${booking.getEventName()}</h4>
									<div class="event-meta-data">
										<a href="#" class="event-place">Event Date : <c:out
												value="${booking.getEventDate()}"></c:out></a>
									</div>
									<div class="event-meta-data">
										<a href="#" class="event-place">Booking Date : <c:out
												value="${booking.getBookingDate()}"></c:out></a>
									</div>
									<div class="event-meta-data">
										<a href="#" class="event-place"> Booking Status : <c:out
												value="${booking.getBookingStatus()}"></c:out></a>
									</div>
									<div class="event-meta-data">
										<a href="#" class="event-place"> Number Of Tickets : <c:out
												value="${booking.getNumberOfTickets()}"></c:out></a>
									</div>
									<c:if
										test="${booking.getEventDate() > now && booking.getBookingStatus().equals("Confirmed")}">
										<a onclick="cancelBooking(${booking.getBookingId()})"
											class="btn see-more-btn">Cancel Booking</a>
									</c:if>
									<br> <a
										href="/app/sendmail.htm?bookingId=${booking.getBookingId()}"
										class="btn see-more-btn">Send Details on Mail</a>
									<br> <a
										href="/app/viewpdf.htm?bookingId=${booking.getBookingId()}"
										class="btn see-more-btn">View PDF</a>	
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="load-more-btn text-center mt-70">
							<a href="#" class="btn oneMusic-btn">Load More <i
								class="fa fa-angle-double-right"></i></a>
						</div>
					</div>
				</div>
		</section>
	</c:if>

	<!-- ##### Events Area End ##### -->

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
	<!-- Events for Page -->
	<script src="<c:url value="/resources/EventHandler.js"/>"></script>
</body>

</html>