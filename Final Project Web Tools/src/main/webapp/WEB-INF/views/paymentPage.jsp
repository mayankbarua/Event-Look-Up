
<!doctype html>
<html lang="en">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon"
	href="<c:url value="/resources/img/core-img/favicon.ico"/>">

<title>Event Look Up</title>

<link rel="canonical"
	href="<c:url value="https://getbootstrap.com/docs/4.0/examples/checkout/"/>">

<!-- Bootstrap core CSS -->
<link href="<c:url value="resources/css/bootstrap.min.css"/>"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="<c:url value="resources/css/form-validation.css"/> rel="stylesheet">
</head>

<body class="bg-light">

	<div class="container">
		<div class="py-5 text-center">
			<img class="d-block mx-auto mb-4"
				src="<c:url value="/resources/img/core-img/favicon.ico"/>" alt=""
				width="72" height="72">
			<h2>Checkout form</h2>
			<p class="lead">Event Details And Booking</p>
		</div>

		<div class="blog-area section-padding-100">
			<div class="container">
				<div class="row">
					<div class="col-12 col-lg-9">
						<!-- Single Post Start -->
						<div class="single-blog-post mb-100 wow fadeInUp"
							data-wow-delay="100ms">
							<!-- Post Thumb -->
							<!-- Blog Content -->
							<div class="blog-content">
								<!-- Post Title -->
								<h1 class="display-3">${event.getEventName()}</h1>
								<!-- Post Meta -->
								<div class="post-meta d-flex mb-30">
									 <h2> Organizer : 
									  <small>	${event.getOrganizerName()} </small></h2><br>
								</div>
								<div class="post-meta d-flex mb-30">
									 <h2> Event Date : 
									  <small>	${event.getEventDate()} </small></h2><br>
								</div>
								<div class="post-meta d-flex mb-30">
								<h2> Address : <small>${event.getAddress()}, ${event.getCity()}, ${event.getState()},
										, ${event.getZipCode()}</small></h2></div>
								<!-- Post Excerpt -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br>
		<br>
		<div class="row">
			<div class="col-md-4 order-md-2 mb-4">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span>Your cart</span> 
				</h4>
				<ul class="list-group mb-3">
					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0">${event.getEventName()}</h6>
							<small class="">Event Name</small>
						</div> <span class="">Price : $${event.getTicketPrice()}</span>
					</li>
					<li
						class="list-group-item d-flex justify-content-between lh-condensed">
						<div>
							<h6 class="my-0">Quantity</h6>
							<small class="">Number Of Tickets</small>
						</div> <span class="">${numberOfTickets}</span>
					</li>

					<li class="list-group-item d-flex justify-content-between bg-light">
						<div class="text-success">
							<h6 class="my-0">Promo code</h6>
							<small>Discount</small>
						</div> <span class="text-success">-$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Total
							(USD)</span> <strong>${event.getTicketPrice()*numberOfTickets}</strong></li>
				</ul>

				<form class="card p-2">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Promo code">
						<div class="input-group-append">
							<button type="submit" class="btn btn-secondary">Redeem</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-8 order-md-1">
				<h4 class="mb-3">Billing address</h4>
				<form:form class="needs-validation" path="address" action="/app/booking.htm" method="POST" commandName="address">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="firstName">First name</label> <input type="text"
								class="form-control" id="firstName"
								value="${sessionScope.user.getFirstName()}" placeholder="" readonly="readonly" required>
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="lastName">Last name</label> <input type="text" readonly="readonly"
								class="form-control" id="lastName" placeholder=""
								value="${sessionScope.user.getLastName()}" required>
							<div class="invalid-feedback">Valid last name is required.
							</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="username">Username</label>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">@</span>
							</div>
							<input type="text" class="form-control" id="username" readonly="readonly"
								value="${sessionScope.user.getUserEmail()}" placeholder="Username" required>
							<div class="invalid-feedback" style="width: 100%;">Your
								username is required.</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="email">Email <span class=""></span></label> <input
							type="email" class="form-control" id="email" readonly="readonly"
							value="${sessionScope.user.getUserEmail()}" placeholder="you@example.com">
						<div class="invalid-feedback">Please enter a valid email
							address for shipping updates.</div>
					</div>

					<div class="mb-3">
						<label for="address">Address</label> <form:input type="text" path="address"
							class="form-control" id="address" placeholder="1234 Main St"
							/>
						<div class="invalid-feedback"><form:errors path="address"/></div>
					</div>
					
					<div class="row">
						<div class="col-md-5 mb-3">
							<label for="country">Country</label> <form:select path="country"
								class="custom-select d-block w-100" id="country">
								<option value="">Choose...</option>
								<option>United States</option>
							</form:select>
							<div class="invalid-feedback"><form:errors path="country"/></div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="state">State</label> <form:select path="state"
								class="custom-select d-block w-100" id="state" >
								<option value="">Choose...</option>
								<option>California</option>
							</form:select>
							<div class="invalid-feedback">Please provide a valid state.
							</div>
						</div>
						<div class="col-md-3 mb-3">
							<label for="zip">City</label> <form:input type="text" path="city"
								class="form-control" id="zip" placeholder="" />
							<div class="invalid-feedback"><form:errors path="city"/></div>
						</div>
						<div class="col-md-2 mb-3">
							<label for="zip">Zip</label> <form:input type="text" path="zipCode"
								class="form-control" id="zip" placeholder=""/>
							<div class="invalid-feedback"><form:errors path="zipCode"/></div>
						</div>
					</div>
					<hr class="mb-4">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input"
							id="same-address"> <label class="custom-control-label"
							for="same-address">Shipping address is the same as my
							billing address</label>
					</div>
					
					<hr class="mb-4">

					<h4 class="mb-3">Payment</h4>

					<div class="d-block my-3">
						<div class="custom-control custom-radio">
							<input id="credit" name="paymentMethod" type="radio"
								class="custom-control-input" checked required> <label
								class="custom-control-label" for="credit">Credit card</label>
						</div>
						<div class="custom-control custom-radio">
							<input id="debit" name="paymentMethod" type="radio"
								class="custom-control-input" required> <label
								class="custom-control-label" for="debit">Debit card</label>
						</div>
						<div class="custom-control custom-radio">
							<input id="paypal" name="paymentMethod" type="radio"
								class="custom-control-input" required> <label
								class="custom-control-label" for="paypal">Paypal</label>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="cc-name">Name on card</label> <input type="text"
								class="form-control" id="cc-name" placeholder="" required>
							<small class="">Full name as displayed on card</small>
							<div class="invalid-feedback">Name on card is required</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="cc-number">Credit card number</label> <input
								type="text" class="form-control" id="cc-number" placeholder=""
								required>
							<div class="invalid-feedback">Credit card number is
								required</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-3 mb-3">
							<label for="cc-expiration">Expiration</label> <input type="text"
								class="form-control" id="cc-expiration" placeholder="" required>
							<div class="invalid-feedback">Expiration date required</div>
						</div>
						<div class="col-md-3 mb-3">
							<label for="cc-expiration">CVV</label> <input type="text"
								class="form-control" id="cc-cvv" placeholder="" required>
							<div class="invalid-feedback">Security code required</div>
						</div>
					</div>
					<hr class="mb-4">
					<button class="btn btn-primary btn-lg btn-block" type="submit">Continue
						to checkout</button>
				</form:form>
			</div>
		</div>

		<footer class="my-5 pt-5 text-muted text-center text-small">
			<ul class="list-inline">
				<li class="list-inline-item"><a href="#">Privacy</a></li>
				<li class="list-inline-item"><a href="#">Terms</a></li>
				<li class="list-inline-item"><a href="#">Support</a></li>
			</ul>
		</footer>
	</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="<c:url value="https://code.jquery.com/jquery-3.2.1.slim.min.js"/>"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>

	<!-- ##### All Javascript Script ##### -->
	<!-- jQuery-2.2.4 js -->
	<script src="<c:url value="/resources/js/jquery/jquery-2.2.4.min.js"/>"></script>
	<!-- Popper js -->
	<script src="<c:url value="/resources/js/bootstrap/popper.min.js"/>"></script>
	<!-- Bootstrap js -->
	<script src="<c:url value="/resources/js/bootstrap/bootstrap.min.js"/>"></script>
	<!-- Active js -->
	<script src="<c:url value="/resources/js/vendor/holder.min.js"/>"></script>
	<!-- All Plugins js -->
	<script src="<c:url value="/resources/js/plugins/plugins.js"/>"></script>
	<!-- Active js -->
	<script src="<c:url value="/resources/js/active.js"/>"></script>

	<script>
		// Example starter JavaScript for disabling form submissions if there are invalid fields
		(function() {
			'use strict';

			window.addEventListener('load',
					function() {
						// Fetch all the forms we want to apply custom Bootstrap validation styles to
						var forms = document
								.getElementsByClassName('needs-validation');

						// Loop over them and prevent submission
						var validation = Array.prototype.filter.call(forms,
								function(form) {
									form.addEventListener('submit', function(
											event) {
										if (form.checkValidity() === false) {
											event.preventDefault();
											event.stopPropagation();
										}
										form.classList.add('was-validated');
									}, false);
								});
					}, false);
		})();
	</script>
</body>
</html>