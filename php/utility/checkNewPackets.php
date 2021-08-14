<?php
require_once "./utility/dbManager.php";

$conn = openConnection();
	
function newPacket($idUser){
	global $conn;
		
	$checkNewPacket = "SELECT *
					   FROM user_packet
					   WHERE _iduser = $idUser
						     AND closed = 1";
	$result = $conn->query($checkNewPacket);
	if(mysqli_num_rows($result) > 0){
		echo '<span style="color:red; font-weight:600;">( ! )</span>';
	}
		
	$conn->close();
}
?>