<!DOCTYPE html>
<html lang="en">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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

	<!-- ##### Hero Area Start ##### -->
	<section class="hero-area">
		<div class="hero-slides owl-carousel">
			<!-- Single Hero Slide -->
			<div
				class="single-hero-slide d-flex align-items-center justify-content-center">
				<!-- Slide Img -->
				<div class="slide-img bg-img"
					style="background-image: url(<c:url value="/resources/img/bg-img/bg-1.jpg)"/>;"></div>
				<!-- Slide Content -->
				<div class="container">
					<div class="row">
						<div class="col-12">
							<div class="hero-slides-content text-center">
								<h6 data-animation="fadeInUp" data-delay="100ms">Latest
									Event on a Click</h6>
								<h2 data-animation="fadeInUp" data-delay="300ms">
									Event Look up <span>Event Look up</span>
								</h2>
								<a data-animation="fadeInUp" data-delay="500ms" href="#"
									class="btn oneMusic-btn mt-50">Find Fun Around You <i
									class="fa fa-angle-double-right"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Single Hero Slide -->
			<div
				class="single-hero-slide d-flex align-items-center justify-content-center">
				<!-- Slide Img -->
				<div class="slide-img bg-img"
					style="background-image:  url(<c:url value="/resources/img/bg-img/bg-2.jpg)"/>;"></div>
				<!-- Slide Content -->
				<div class="container">
					<div class="row">
						<div class="col-12">
							<div class="hero-slides-content text-center">
								<h6 data-animation="fadeInUp" data-delay="100ms">Latest
									Event on a Click</h6>
								<h2 data-animation="fadeInUp" data-delay="300ms">
									Event Look up <span>Event Look up</span>
								</h2>
								<a data-animation="fadeInUp" data-delay="500ms" href="#"
									class="btn oneMusic-btn mt-50">Find Fun Around You <i
									class="fa fa-angle-double-right"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ##### Hero Area End ##### -->

	<!-- ##### Latest Albums Area Start ##### -->
	<section class="latest-albums-area section-padding-100">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="section-heading style-2">
						<p>See what’s new</p>
						<h2>Latest Event</h2>
					</div>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-12 col-lg-9">
					<div class="ablums-text text-center mb-70">
						<p>Nam tristique ex vel magna tincidunt, ut porta nisl
							finibus. Vivamus eu dolor eu quam varius rutrum. Fusce nec justo
							id sem aliquam fringilla nec non lacus. Suspendisse eget lobortis
							nisi, ac cursus odio. Vivamus nibh velit, rutrum at ipsum ac,
							dignissim iaculis ante. Donec in velit non elit pulvinar
							pellentesque et non eros.</p>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-12">
					<div class="albums-slideshow owl-carousel">
						<!-- Single Album -->
						<div class="single-album">
							<img src="<c:url value="/resources/img/bg-img/a1.jpg"/>" alt="">
							<div class="album-info">
								<a href="#">
									<h5>The Cure</h5>
								</a>
								<p>Second Song</p>
							</div>
						</div>

						<!-- Single Album -->
						<div class="single-album">
							<img src="<c:url value="/resources/img/bg-img/a2.jpg"/>" alt="">
							<div class="album-info">
								<a href="#">
									<h5>Sam Smith</h5>
								</a>
								<p>Underground</p>
							</div>
						</div>

						<!-- Single Album -->
						<div class="single-album">
							<img src="<c:url value="/resources/img/bg-img/a3.jpg"/>" alt="">
							<div class="album-info">
								<a href="#">
									<h5>Will I am</h5>
								</a>
								<p>First</p>
							</div>
						</div>

						<!-- Single Album -->
						<div class="single-album">
							<img src="<c:url value="/resources/img/bg-img/a4.jpg"/>" alt="">
							<div class="album-info">
								<a href="#">
									<h5>The Cure</h5>
								</a>
								<p>Second Song</p>
							</div>
						</div>

						<!-- Single Album -->
						<div class="single-album">
							<img src="<c:url value="/resources/img/bg-img/a5.jpg"/>" alt="">
							<div class="album-info">
								<a href="#">
									<h5>DJ SMITH</h5>
								</a>
								<p>The Album</p>
							</div>
						</div>

						<!-- Single Album -->
						<div class="single-album">
							<img src="<c:url value="/resources/img/bg-img/a6.jpg"/>" alt="">
							<div class="album-info">
								<a href="#">
									<h5>The Ustopable</h5>
								</a>
								<p>Unplugged</p>
							</div>
						</div>

						<!-- Single Album -->
						<div class="single-album">
							<img src="<c:url value="/resources/img/bg-img/a7.jpg"/>" alt="">
							<div class="album-info">
								<a href="#">
									<h5>Beyonce</h5>
								</a>
								<p>Songs</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ##### Latest Albums Area End ##### -->

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
							</script>
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