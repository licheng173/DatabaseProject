<?php

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

$username = strip_tags($_POST['username']);
$pass = strip_tags($_POST['password']);
$username = $db->real_escape_string($username);
$pass = $db->real_escape_string($pass);

$hashed_password = md5($pass);


session_start();
if(isset($_POST['login-submit'])) {

if(!empty($_POST['username']))
{
	if ($result = $db->prepare("select uid from User where uname = ? and upassword = ?;"))
	{
    	$result->bind_param("ss", $username, $hashed_password);
    	$result->execute();
    	$result->bind_result($uid);
    	$result->fetch();
    	$result->close();
    	if(!empty($uid)) {
			$_SESSION['uid'] = $uid;
			$_SESSION['uname'] = $username;
			echo "<script>location.href='mypage.php'</script>";
		}
		else 
		{
			echo "<script>location.href='login.php?er=1'</script>";
		}
	}
}
else {
	echo "<script>location.href='login.php?er=1'</script>";
}
}
$db->close();
?>
