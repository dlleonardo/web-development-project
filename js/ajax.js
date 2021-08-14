function searchMarkets(str){
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function(){
		if(this.readyState == 4 && this.status == 200){
			var table = document.getElementById("cfd-table");
			if(table){
				table.innerHTML = this.responseText;
			}
		}
	};
	xhttp.open("GET", "./../php/utility/getMarkets.php?q="+str, true);
	xhttp.send();
}

function searchUsers(str){
	var xhttp;
	xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function(){
		if(this.readyState == 4 && this.status == 200){
			var table = document.getElementById("cfd-table");
			if(table){
				table.innerHTML = this.responseText;
			}
		}
	};
	xhttp.open("GET", "./../php/utility/getUsers.php?q="+str, true);
	xhttp.send();
}