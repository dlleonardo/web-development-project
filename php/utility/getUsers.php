<?php
session_start();
require_once './dbManager.php';

$conn = openConnection();

if(isset($_GET['q'])){

	$str = $conn->real_escape_string($_GET['q']);
	
	if(strlen($str) === 0){
		$cond = "";
	}
	else{
		$cond = "AND username LIKE '%$str%'";
	}
	
	$selectUsers = "SELECT *
					FROM user
					WHERE role = 'user'
						  ".$cond."
					ORDER BY wallet DESC";
	$result = $conn->query($selectUsers);
	if(mysqli_num_rows($result) == 0){
		echo '<section id="cfd-section">
				<h3 style="font-family:arial;">No users found with this username.</h3>
			  </section>';
	}
	else{
			echo '<table id="cfd-table">
						<thead>
							<th></th>
							<th>Username</th>
							<th>Fullname</th>
							<th>Email</th>
							<th>Wallet</th>
							<th>Experience</th>
							<th>Registration Timestamp</th>
							<th>Banned</th>
							<th></th>
						</thead>
						<tbody>';
			while($row = $result->fetch_assoc()){
				if($row['_idrank'] == 1){
					$icon = '<img src="./../images/wood.png" width="32px" height="32px">';
				}
				else if($row['_idrank'] == 2){
					$icon = '<img src="./../images/bronze.png" width="32px" height="32px">';
				}
				else if($row['_idrank'] == 3){
					$icon = '<img src="./../images/silver.png" width="32px" height="32px">';
				}
				else{
					$icon = '<img src="./../images/gold.png" width="32px" height="32px">';
				}
				
				if($row['banned'] == 0){
					$banned = '<tr>';
					$txt = 'No';
				}
				else{
					$banned = '<tr style="background-color:#c6c6c6">';
					$txt = 'Yes';
				}
				
				echo ''.$banned.'
						<td style="text-align:center;">'.$icon.'</td>
						<td>'.$row['username'].'</td>
						<td>'.$row['name'].' '.$row['surname'].'</td>
						<td>'.$row['email'].'</td>
						<td>'.$row['wallet'].' &euro;</td>
						<td>'.$row['experience'].' EXP</td>
						<td>'.$row['timestamp'].'</td>
						<td>'.$txt.'</td>
						<td style="text-align:center;"><a href="./details.php?idUser='.$row['id'].'">Details</a></td>
					</tr>';
			}
			echo '</tbody>
				 </table>';		
		}

}

$conn->close();
?>