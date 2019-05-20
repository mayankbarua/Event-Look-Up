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

<style>
#map {
	height: 400px;
	width: 100%;
}
</style>

<!-- Favicon -->
<link rel="icon"
	href="<c:url value="/resources/img/core-img/favicon.ico"/>">

<script src="<c:url value="https://unpkg.com/axios/dist/axios.min.js"/>"></script>

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

	<!-- ##### Breadcumb Area Start ##### -->
	<section class="breadcumb-area bg-img bg-overlay"
		style="background-image: url(<c:url value="/resources/img/bg-img/breadcumb3.jpg"/>);">
		<div class="bradcumbContent">
			<p>See what’s new</p>
			<h2>Event Detail</h2>
		</div>
	</section>
	<!-- ##### Breadcumb Area End ##### -->

	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Select Number Of Tickets</h4>
				</div>
				<form action="/app/booking.htm" method="get">
					<div class="modal-body">
						<div class="form-group">
							<input type="hidden" name="authKey"
								value="${event.getEventId()}+${event.getEventName()}" /> <input
								type="hidden" name="eventId"
								value="<c:out value="${event.getEventId()}"/>"> <label
								for="sel1">Select Number Of Tickets</label> <select
								name="numberOfTickets" path="eventCategory" class="form-control"
								id="sel1">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select> <small id="emailHelp" class="form-text text-muted"><i
								class="fa fa-lock mr-2"></i></small>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-default">Book
							Tickets</button>
						&emsp;
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</form>
			</div>

		</div>
	</div>

	<!-- ##### Blog Area Start ##### -->
	<div class="blog-area section-padding-100">
		<div class="container">
			<div class="row">
				<div class="col-12 col-lg-9">
					<!-- Single Post Start -->
					<div class="single-blog-post mb-100 wow fadeInUp"
						data-wow-delay="100ms">
						<!-- Post Thumb -->
						<div class="blog-post-thumb mt-30">
							<img src="<c:url value="/event/images/${event.getImagePath()}"/>"
								alt="" />
							<!-- Post Date -->
							<div class="post-date">
								<span>Date</span> <span>${event.getEventDate()}</span>
							</div>
						</div>

						<!-- Blog Content -->
						<div class="blog-content">
							<!-- Post Title -->
							<a href="#" class="post-title">${event.getEventName()}</a>
							<!-- Post Meta -->
							<div class="post-meta d-flex mb-30">
								<p class="post-author">Organizer :
									${event.getOrganizerName()}</p>
								<p class="tags">Address : ${event.getAddress()}</p>
								<p class="tags">${event.getCity()},${event.getState()},
									${event.getZipCode()}</p>
							</div>
							<!-- Post Excerpt -->
							<p>${event.getDescription()}</p>
							<br>
							<div class="row">
								<c:if test="${event.getNumberOfSeats()!=0}">
									<div class="col-12">
										<div class="load-more-btn text-center mt-70">
											<a class="btn oneMusic-btn" data-toggle="modal"
												data-target="#myModal">Book Ticket <i
												class="fa fa-angle-double-right"></i></a>
										</div>
									</div>
								</c:if>
								<c:if test="${event.getNumberOfSeats()==0}">
									<div class="alert alert-danger" align="center">
										<strong>Opps!</strong> All Tickets Sold Out
									</div>
								</c:if>
							</div>
							<br> <br>
							<h2>Google Map Location</h2>
							<br>
							<div id="map"></div>
							<div class="container">
								<br> <br>
								<div class="container">
									<h2>Event Video</h2>
									<div class="embed-responsive embed-responsive-16by9">
										<iframe class="embed-responsive-item"
											src="${event.getVideoUrl()}"></iframe>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- ##### Blog Area End ##### -->

	<!-- ##### Footer Area Start ##### -->
	<footer class="footer-area">
		<div class="container">
			<div class="row d-flex flex-wrap align-items-center">
				<div class="col-12 col-md-6">
					<a href="#"><img
						src="<c:url value="/resources/img/core-img/logo.png"/>" alt="" /></a>
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

	<script>
    function initMap(){
      
	  var latVariable;
	  var langVariable;
	  var location = "${event.getAddress()}";
	  axios.get('https://maps.googleapis.com/maps/api/geocode/json',{
        params:{
          address:location,
          key:'Google Map Key'
        }
      })
      .then(function(response){

        latVariable = response.data.results[0].geometry.location.lat;
        langVariable = response.data.results[0].geometry.location.lng;
		console.log(latVariable+" "+langVariable)
		
		   var options = {
        zoom:14	,
        center:{lat:latVariable,lng:langVariable}
      }

      // New map
      var map = new google.maps.Map(document.getElementById('map'), options);
	      
      // Add marker
      var marker = new google.maps.Marker({
        position:{lat:latVariable,lng: langVariable},
        map:map,
        icon:'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'
      });

      var infoWindow = new google.maps.InfoWindow({
        content:'<h1>'+location+'</h1>'
      });

      marker.addListener('click', function(){
        infoWindow.open(map, marker);
      });
      
	  addMarker(marker);

      // Add Marker Function
		
      })
      .catch(function(error){
        console.log(error);
      });
	
	function addMarker(props){
        var marker = new google.maps.Marker({
          position:props.coords,
          map:map,
          //icon:props.iconImage
        });

        // Check for customicon
        if(props.iconImage){
          // Set icon image
          marker.setIcon(props.iconImage);
        }

        // Check content
        if(props.content){
          var infoWindow = new google.maps.InfoWindow({
            content:props.content
          });

          marker.addListener('click', function(){
            infoWindow.open(map, marker);
          });
        }
      }
	  
    }
  </script>

	<script async defer
		src="<c:url value="https://maps.googleapis.com/maps/api/js?key=Google Map Key&callback=initMap"/>" />
	</script>

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