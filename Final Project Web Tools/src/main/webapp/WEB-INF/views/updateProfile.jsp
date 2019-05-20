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
<link rel="stylesheet" href="<c:url value="/resources/style.css"/>">
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
			<h2>Update Account</h2>
		</div>
	</section>
	<!-- ##### Breadcumb Area End ##### -->

	<!-- ##### Login Area Start ##### -->
	<section class="login-area section-padding-100">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12 col-lg-8">
					<div class="login-content">
						<c:if test="${message !=null}">
							<div class="alert alert-success">
								<strong>Success!</strong> Account Updated Successfully.
							</div>
						</c:if>
						<br>
						<h3>Welcome</h3>
						<!-- Login Form -->
						<div class="login-form">
							<form:form action="/app/updateprofile.htm" method="post"
								commandName="user">
								<div class="form-group">
									<label for="exampleInputEmail1">First Name</label>
									<form:input type="text" path="firstName" class="form-control" value="${sessionScope.user.getFirstName()}"
										id="exampleInputEmail1" aria-describedby="emailHelp"
										placeholder="Enter First Name" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="firstName" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Last Name</label>
									<form:input type="text" path="lastName" class="form-control" value="${sessionScope.user.getLastName()}"
										id="exampleInputEmail1" aria-describedby="emailHelp"
										placeholder="Enter Last Name" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="lastName" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Email address</label>
									<form:input type="email" path="userEmail" class="form-control" value="${sessionScope.user.getUserEmail()}"
										id="exampleInputEmail1" aria-describedby="emailHelp"
										placeholder="Enter E-mail" readonly="true"/>
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="userEmail" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">New Password</label>
									<form:input type="password" path="password"
										class="form-control" id="exampleInputPassword1"
										placeholder="Password" />
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i> <form:errors path="password" /></small>
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">Confirm New Password</label> <input
										type="password" class="form-control" name="confirmPassword"
										id="exampleInputPassword1" placeholder="Confirm Password">
									<small id="emailHelp" class="form-text text-muted"><i
										class="fa fa-lock mr-2"></i>${passwordError}</small>
								</div>
								<button type="submit" class="btn oneMusic-btn mt-30">Update
									Profile</button>
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
							Copyright &copy;<script>document.write(new Date().getFullYear());</script>
							All rights reserved | This template is made with <i
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