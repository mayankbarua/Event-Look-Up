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
						<form action="/app/eventsearch.htm" method="post">
							<div class="row">
								<div class="col-md-6 col-lg-4">
									<div class="form-group">
										<input type="text" name="city" class="form-control" id="city"
											placeholder="City">
									</div>
								</div>
								<div class="col-md-6 col-lg-4">
									<div class="form-group">
										<select name="category" class="form-control" id="sel1">
											<option>Select Event Category</option>
											<option>Music</option>
											<option>Food and Drinks</option>
											<option>Spirituality</option>
											<option>Comedy</option>
											<option>Charity</option>
											<option>Education</option>
											<option>Film and Awards</option>
											<option>Science and Tech</option>
											<option>Fashion</option>
											<option>Health</option>
											<option>Sports</option>
										</select>
									</div>
								</div>
								<div class="col-lg-4">
									<div class="form-group">
										<input type="date" name="date" class="form-control" id="date"
											placeholder="Date">
									</div>
								</div>
							</div>
							<div align="center">
								<button type="submit" class="btn oneMusic-btn mt-30">Search</button>
							</div>
						</form>
						<br>
						<c:if test="${eventList.size() == 0 && eventList !=null}">
							<div class="alert alert-danger">
								<strong>Oops!</strong> No Event Happening at Selected City
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ##### Events Area Start ##### -->
	<c:if test="${eventList.size()!=0 && eventList != null }">
		<section class="events-area section-padding-100">
			<div class="container">
				<div class="row">
					<!-- Single Event Area -->
					<c:forEach var="event" items="${eventList}">
						<div class="col-12 col-md-6 col-lg-4">
							<div class="single-event-area mb-30">
								<div class="event-thumbnail">
									<img
										src="<c:url value="/event/images/${event.getImagePath()}"/>"
										alt="<c:url value="/event/images/1555353600825 a7.jpg"/>" />
								</div>
								<div class="event-text">
									<h4>${event.getEventName()}</h4>
									<div class="event-meta-data">
										<a href="#" class="event-place"><c:out
												value="${event.getEventDate()}"></c:out></a> <a href="#"
											class="event-date"><c:out value="${event.getAddress()}"></c:out></a>
									</div>
									<a
										href="/app/eventdetail.htm?eventId=<c:out value="${event.getEventId()}"/>"
										class="btn see-more-btn">See Event</a>
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

	<section class="events-area section-padding-100">
		<div class="container">
			<c:if test="${defaultEventList.size()!=0 }">
				<c:forEach var="eventMap" items="${defaultEventList}">
					<div class="row">
						<div class="col-12">
							<div class="load-more-btn text-center mt-70">
								<a href="#" class="btn oneMusic-btn"> ${eventMap.key} Events<i
									class="fa fa-angle-double-right"></i>
								</a>
							</div>
						</div>
					</div>
					<br>
					<br>
					<div class="row">
						<!-- Single Event Area -->
						<c:forEach var="event" items="${eventMap.value}">
							<div class="col-12 col-md-6 col-lg-4">
								<div class="single-event-area mb-30">
									<div class="event-thumbnail">
										<img
											src="<c:url value="/event/images/${event.getImagePath()}"/>"
											alt="<c:url value="/event/images/1555353600825 a7.jpg"/>">
									</div>
									<div class="event-text">
										<h4>${event.getEventName()}</h4>
										<div class="event-meta-data">
											<a href="#" class="event-place"><c:out
													value="${event.getEventDate()}"></c:out></a> <a href="#"
												class="event-date"><c:out value="${event.getAddress()}"></c:out></a>
										</div>
										<a
											href="/app/eventdetail.htm?eventId=<c:out value="${event.getEventId()}"/>"
											class="btn see-more-btn">See Event</a>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:forEach>
			</c:if>
	</section>

	<!-- ##### Events Area End ##### -->

	<!-- ##### Footer Area Start ##### -->
	<footer class="footer-area">
		<div class="container">
			<div class="row d-flex flex-wrap align-items-center">
				<div class="col-12 col-md-6">
					<a href="#"><img
						src="<c:url value="/resources/img/core-img/logo.png"/>" alt=""></a>
					<p class="copywrite-text">
						<a href="#"> <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy; <script>
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
							<li><a href="#">Albums</a></li>
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