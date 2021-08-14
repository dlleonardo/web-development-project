<?php
	session_start();
	if(!isset($_SESSION['username']) || !isset($_SESSION['idUser'])){
		header("location: ./../signin.php");
		exit();
	}
	
	if(isset($_GET['idUser'])){
		$idUser = $_GET['idUser'];
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
    	<title>User Details</title>
	</head>
	<body>
		<?php
			require "./utility/checkUserActions.php";
			require "./panel/data.php";
			include "./panel/adminMenu.php";
			
			if(isset($idUser) && isset($_GET['action'])){
				$action = $_GET['action'];
				sendAdminAction($idUser, $action);
			}			
		?>
		<div id="container">
			<!-- Admin actions bar -->
			<div id="search-bar">
				<div style="width:10%; text-align:left; display:block;">
					<a class="btnAdmin" href="./admin.php">Back</a>
				</div>
				<div style="width:90%;">
					<?php
						if(isset($idUser)){
							if(isBanned($idUser)){
								$btn = '<div style="float:right; margin-right:32px;">
											<a class="btnAdmin" style="background:#32CD32;" href="./details.php?idUser='.$idUser.'&action=cancel">Cancel Ban</a>
										 </div>';
							}
							else{
								$btn = '<div style="float:right; margin-right:32px;">
											<a class="btnAdmin" style="background:red;" href="./details.php?idUser='.$idUser.'&action=ban">Ban</a>
										 </div>';
							}
							echo $btn.'<div style="float:right; margin-right:56px;">
										 <a class="btnAdmin" href="./details.php?idUser='.$idUser.'&action=packet">Send Packet</a>			
									   </div>';
						}
					?>
				</div>
			</div>
			<?php
				if(isset($_GET['message'])){
					echo '<div class="message">'.$_GET['message'].'</div>';
				}
			?>
			<!-- Show user details -->
			<div>
			<?php
				if(isset($idUser)){
					showUserDetails($idUser);
				}
			?>
			</div>
			
			<!-- Admin footer -->
			<?php
				showHistoryProfit($idUser);
			?>
		</div>
	</body>
</html>