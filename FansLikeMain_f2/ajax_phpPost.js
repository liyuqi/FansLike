function showArticle(postID) {
	var xmlhttp;
	if (postID == "") {
		document.getElementById("txtHint").innerHTML = "";
		return;
	}
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else { // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("txtHint").innerHTML = xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET", "mysql_post_test.php?q=" + postID, true);
	xmlhttp.send();
}
function showPostID() {
	var xmlhttp;

	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else { // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("article").innerHTML = xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET", "mysql_post_test.php", true);
	xmlhttp.send();
}

function showArticle(postID) {
	var xmlhttp;
	if (postID == "") {
		document.getElementById("txtHint").innerHTML = "";
		return;
	}
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else { // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("txtHint").innerHTML = xmlhttp.responseText;
			google.load('visualization', '1.0', {'packages' : ['corechart']});
			drawChartPie(postID);
			//drawChartHistory(postID);
		}
	}
	xmlhttp.open("GET", "mysql_post_test.php?q=" + postID, true);
	xmlhttp.send();
}
		
function drawChartPie(q) {
	var jsonData = $.ajax({
			url : "./mysql_post_sex.php?q=" + q,
			dataType : "json",
			async : false
		}).responseText;
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);

	// Set chart options
	var options = {
		'title' : 'Sex Ratio',
		'width' : 600,
		'height' : 200
	};

	var chart = new google.visualization.BarChart(document.getElementById('chart_div2'));
	chart.draw(data, options);
}

window.onload = showPostID;