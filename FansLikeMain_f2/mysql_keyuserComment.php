<meta charset="utf-8">
<?php
//mysql_keyuser
header('Content-type: text/html; charset=utf-8');
$q=$_GET["q"];

$con = mysql_connect('localhost', 'root', '');
if (!$con)
 {
 die('Could not connect: ' . mysql_error());
 }

mysql_select_db("db3", $con);
mysql_query("SET NAMES 'UTF8'");
//*/
$sql="SELECT * FROM table_keyuser WHERE rank = '".$q."' ";

$result = mysql_query($sql);

echo "<table id='keyuser'>
<tr>
<th>Name</th>
<th>Total like</th>
<th>Link</th>
</tr>";

while($row = mysql_fetch_array($result))
 {
	 echo "<tr>";
	 echo "<td>" . $row['name'] . "</td>";
	 echo "<td>" . $row['like_count'] . "</td>";
	 echo "<td>" . "<a href=http://www.facebook.com/" . $row['link'] . " target=_blank'> http://www.facebook.com/".$row['link']." </a>" . "</td>";
	 echo "</tr>";
 }
echo "</table>";
//*/

$first="SELECT * FROM table_keyuser order by rank limit 300";
$resultFirst = mysql_query($first);
echo "<option value=''>choice</option>";
while($rowFirst = mysql_fetch_array($resultFirst))
 {
echo "<option value='".$rowFirst['rank']."'>" . $rowFirst['rank'] ."\t".$rowFirst['name']. "</option>";
 }

mysql_close($con);
?>