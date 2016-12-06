<?php

$username = $_POST['username'];
$password = $_POST['password'];
$cryptPassword = crypt($password);

include "dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

session_start();

if(!empty($_POST['username']))
{
	if ($result = $db->prepare("select uname from User where uname = ? and upassword = ?;")) 
	{
    	$result->bind_param("ss", $username, $password);
    	$result->execute();
    	$result->bind_result($uname);
    	$result->fetch();
    	$result->close();
    	if(!empty($uname)) {
			$_SESSION['uname'] = $uname;
			echo "<script>location.href='mypage.php'</script>";
		}
		else 
		{
			echo "<script>location.href='login.php?er=1&sdfg='</script>";
		}
	}
}
$db->close();
?>
