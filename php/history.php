<?php
	session_start();
	require "./utility/checkUserActions.php";	
	if(!isset($_SESSION['username']) || !isset($_SESSION['idUser']) || !isset($_SESSION['wallet']) || !isset($_SESSION['experience']) || !isset($_SESSION['rank'])){
		header("location: ./../signin.php");
		exit();
	}
	if(isset($_SESSION['idUser'])){
		if(isBanned($_SESSION['idUser'])){
			$msg = 'Your account is banned.';
			header("location: ./../signin.php?errorMsg=".$msg);
			exit();
		}
	}		
?>
<!DOCTYPE html>
<html lang="en"> 
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="Financial Trading">
		<meta name="keywords" content="stocks, markets, trading">
    	<link rel="icon" href = "./../images/favicon.png" sizes="32x32" type="image/png">   		
		<link rel="stylesheet" href="./../css/panel.css" type="text/css" media="screen">
		<script src="./../js/trading.js"></script>
		<script src="./../js/ajax.js"></script>
    	<title>History</title>
	</head>
	<body>
		<?php
			include "./panel/menu.php";
		?>
		<div id="container">
			<div style="text-align:center;">
				<h2>HISTORY</h2>
				<p style="font-size:18px;">In this section you can find the history of your transactions with the relative profit.</p>
				<div style="display:block;" id="search-bar">
					<input id="searchMarkets" type="text" placeholder="Search by market name ..." onkeyup="searchMarkets(this.value)" />
				</div>
			</div>
			<?php
				if(isset($_GET['message'])){
					echo '<div class="message">'.$_GET['message'].'</div>';
				}
			?>
			<!-- Show user history transactions -->
			<?php
				require "./panel/data.php";
				showHistory();
			?>
		</div>
	</body>
</html>