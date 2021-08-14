<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="Financial Trading">
		<meta name="keywords" content="stocks, markets, trading">
    	<link rel="icon" href = "./images/favicon.png" sizes="32x32" type="image/png">   		
		<link rel="stylesheet" href="./css/style.css" type="text/css" media="screen">
    	<title>Sign Up</title>
	</head>
	<body>
		<main>
			<div>
				<ul id="menu">
					<li><a href="./index.html">Home</a></li>
					<li><a href="./trading.html">Trading</a></li>
					<li><a href="./markets.html">Markets</a></li>
					<li><a href="./faq.html">FAQ</a></li>
					<li><a href="./signin.php">Login</a></li>
					<li class="active"><a href="./signup.php">Sign Up</a></li>
				</ul>
			</div>
			<section id="signup-container">
				<div>
					<header>
						<h3>Create an account</h3>
						<em>All the fields are required.</em>
					</header>
					<form method="post" action="./php/registration.php">
						<p><input name="username" class="input" type="text" placeholder="Usename" 
								  pattern="^[A-Za-z0-9]+" minlength="4" maxlength="100" 
								  title="From four to one hundred characters, only letters and numbers are allowed" required /></p>
						<p><input name="password" class="input" type="password" placeholder="Password" 
								  minlength="6" maxlength="255" title="At least six or more characters" required /></p>
						<p><input name="confirmPassword" class="input" type="password" placeholder="Confirm Password" 
								  minlength="6" maxlength="255" title="At least six or more characters" required /></p>
						<p><input name="email" class="input" type="email" placeholder="Email" required /></p>
						<p><input name="firstName" class="input" type="text" placeholder="First name" 
								  pattern="^[A-Za-z\s]+" minlength="1" maxlength="100" title="Only letters are allowed" required /></p>
						<p><input name="surname" class="input" type="text" placeholder="Surname" 
								  pattern="^[A-Za-z\s]+" minlength="1" maxlength="100" title="Only letters are allowed" required /></p>
						<p><input type="checkbox" name="termsOfUse" required />I agree to have read and i accept the <a style="color:black;" href="./terms.html" target="_blank">Terms of Use</a>.</p>
						<p><input class="submit" type="submit" value="Sign Up" /></p>
						<?php
							if(isset($_GET['errorMsg'])){
								echo '<div class="errorMsg">
										<span>'.$_GET['errorMsg'].'</span>
									  </div>';
							}
						?>
					</form>
					<p>Have an account? <a class="link" href="./signin.php">Login</a></p>
				</div>
			</section>
		</main>
		
		<footer style="position:fixed; bottom:0; width: 100%;">
			<p>&copy; Copyright 2020 - <a style="color:white;" href="./privacy.html" target="_blank">Privacy Policy</a>.</p>
		</footer>		
	</body>
</html>