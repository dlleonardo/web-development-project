<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="Financial Trading">
		<meta name="keywords" content="stocks, markets, trading">
    	<link rel="icon" href = "./images/favicon.png" sizes="32x32" type="image/png">   		
		<link rel="stylesheet" href="./css/style.css" type="text/css" media="screen">
    	<title>Login</title>
	</head>
	<body>
		<main>
			<div>
				<ul id="menu">
					<li><a href="./index.html">Home</a></li>
					<li><a href="./trading.html">Trading</a></li>
					<li><a href="./markets.html">Markets</a></li>
					<li><a href="./faq.html">FAQ</a></li>
					<li class="active"><a href="./signin.php">Login</a></li>
					<li><a href="./signup.php">Sign Up</a></li>
				</ul>
			</div>
			<section id="login-container">
				<div>
					<header>
						<h3>Login</h3>
					</header>
					<form method="post" action="./php/login.php">
						<p><input name="username" class="input" type="text" placeholder="Usename" required /></p>
						<p><input name="password" class="input" type="password" placeholder="Password" required /></p>
						<p><input class="submit" type="submit" value="Sign In" /></p>
						<?php
							if(isset($_GET['errorMsg'])){
								echo '<div class="errorMsg">
										<span>' . $_GET['errorMsg'] . '</span>
									  </div>';
							}
						?>
					</form>
					<p>Don't have an account? <a class="link" href="./signup.php">Sign Up</a></p>
					<p>Before login you can check our <a style="color:black;" href="./user-guide.html" target="_blank">User Guide</a></p>
				</div>
			</section>
		</main>
		
		<footer style="position:fixed; bottom:0; width: 100%;">
			<p>&copy; Copyright 2020 - <a style="color:white;" href="./privacy.html" target="_blank">Privacy Policy</a>.</p>
		</footer>		
	</body>
</html>