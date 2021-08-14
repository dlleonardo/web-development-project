<?php
function insertUserGoals($userId, $conn){
	
	for($i=1; $i<=9; $i++){
	
		$insertGoal = "INSERT INTO user_goal(_iduser, _idgoal)
					   VALUES($userId, $i)";
		$conn->query($insertGoal);
	
	}
	
	$conn->close();
}
?>