
<?php
$q = $_GET['q'];
$con = mysql_connect('localhost', 'root', '') or die('Error connecting to server');
 mysql_query("SET NAMES 'UTF8'");
mysql_select_db('db3', $con);

// write your SQL query here (you may use parameters from $_GET or $_POST if you need them)
//$query1 = mysql_query('SELECT * FROM table_keyuser WHERE rank = 1');
$query1 = mysql_query("SELECT * FROM table_keyuser WHERE rank = '".$q."'");
$row1 = mysql_fetch_array($query1);
$linkID = $row1['link'];

//$linkID = 'http://www.facebook.com/100000238900383';
$query = mysql_query("SELECT * FROM table_comment_history WHERE link = '".$linkID."'order by year desc,month desc");

$table = array();
$table['cols'] = array(
    array('label' => 'date', 'type' => 'string'),
	array('label' => 'comment', 'type' => 'number')
);

$rows = array();
while($r = mysql_fetch_assoc($query)) {
    $temp = array();
	// each column needs to have data inserted via the $temp array
	$temp[] = array('v' => $r['year'].'-'.$r['month']);
	$temp[] = array('v' => (int) $r['comment_count']); // typecast all numbers to the appropriate type (int or float) as needed - otherwise they are input as strings
	
	// insert the temp array into $rows
    $rows[] = array('c' => $temp);
}

// populate the table with rows of data
$table['rows'] = $rows;

// encode the table as JSON
$jsonTable = json_encode($table);

// set up header; first two prevent IE from caching queries
header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');

// return the JSON data
echo $jsonTable;
mysql_close($con);
?>