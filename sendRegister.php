<?php

include "dbconf.inc";


$db=new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}
 
$uname = strip_tags($_POST['username']);
$realname = strip_tags($_POST['realname']);
$pass = strip_tags($_POST['password']);
$conpass = strip_tags($_POST['confirm-password']);
 
$uname = $db->real_escape_string($uname);
$realname = $db->real_escape_string($realname);
$pass = $db->real_escape_string($pass);
$conpass = $db->real_escape_string($conpass);


foreach ($_POST as $key => $value) {
    if(empty($_POST[$key])) {
        $error = true;
        $message = ucwords($key) . "field is required";
        break;
   }
}

if(strcmp($pass, $conpass) != 0) {
   $error = true;
   $message = 'Passwords should be same<br>';
}

$hashed_password = md5($pass); // this function works only in PHP 5.5 or latest version
 
$check_uname = $db->query("SELECT uname FROM User WHERE uname='$uname'");
$count=$check_uname->num_rows;
 
if($count != 0) {
    $error = true;
    $message = "sorry username already taken !<br>";
}

if(!$error) {
    if($result1 = $db->prepare("INSERT INTO User (uname, upassword, name) VALUES (?, ?, ?);")
        ) {
            $result1->bind_param("sss", $uname, $hashed_password, $realname);
            $result1->execute();
            $result1->close();
    }
    $msg = "Successfully registered !<br>";
    echo "<script>location.href=\"login.php?errMsg=" . urldecode($msg)."\"</script>";
    $db->close();
}
else {
    echo "<script>location.href=\"login.php?msg=".urldecode($message)."\"</script>";
}
?>