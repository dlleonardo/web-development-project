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
		$cond = "AND (M.name LIKE '%$str%'
					  OR M.code LIKE '%$str%')";
	}
	
	$query = "SELECT M.icon AS marketIcon,
					 M.code AS marketCode,
					 M.name AS marketName,
					 C.name AS category,
					 T.price_buy AS priceBuy,
					 T.price_sell AS priceSell,
					 (T.price_sell - T.price_buy) AS profit,
					 T.timestamp_buy AS timestampBuy,
					 T.timestamp_sell AS timestampSell
			  FROM user U
				   INNER JOIN
				   transaction T
				   ON U.id = T._iduser
				   INNER JOIN
				   transaction_market TM
				   ON T.id = TM._idtransaction
				   INNER JOIN
				   market M
				   ON TM._idmarket = M.id
				   INNER JOIN 
				   category C
				   ON M._idcategory = C.id
			  WHERE T._iduser = ".$_SESSION['idUser']."
					AND T.state = 'closed'
					AND T.type = 'sell'
					".$cond."
			  ORDER BY T.timestamp_sell DESC";
	$result = $conn->query($query);
	
		if(mysqli_num_rows($result) == 0){
			echo '<section id="cfd-section">
					<h3 style="font-family:arial;">No transactions found with this name.</h3>
				  </section>';
		}
		else{
			echo '<table id="cfd-table">
						<thead>
							<th></th>
							<th>Name</th>
							<th>Category</th>
							<th>Price Buy</th>
							<th>Price Sell</th>
							<th>Profit</th>
						</thead>
						<tbody>';
			$i=0;
			while($row = $result->fetch_assoc()){
				if(floatval($row['profit']) < 0){
					$profit = '<td style="background:#FF4500;">'.$row['profit'].' &euro;</td>';
				}
				else if(floatval($row['profit']) > 0){
					$profit = '<td style="background:#BFFF00;">'.$row['profit'].' &euro;</td>';
				}
				else{
					$profit = '<td>'.$row['profit'].' &euro;</td>';
				}
			
				echo '<tr>
						<td style="text-align:center;"><img src="./../images/icons/'.$row['marketIcon'].'" width="32px" height="32px"></td>
						<td>'.$row['marketCode'].' - '.$row['marketName'].'</td>
						<td>'.$row['category'].'</td>
						<td>'.$row['priceBuy'].' &euro; on '.date("H:i:s d-m-Y" , strtotime($row['timestampBuy'])).'</td>
						<td>'.$row['priceSell'].' &euro; on '.date("H:i:s d-m-Y" , strtotime($row['timestampSell'])).'</td>
						'.$profit.'
					</tr>';
				$i++;
			}
			echo '</tbody>
				 </table>';
		}

}

$conn->close();
?>