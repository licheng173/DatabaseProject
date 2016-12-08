<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$uid = $_SESSION['uid'];
$gname = $_POST['gname'];
$gdescription = $_POST['gdescription'];
$gid = uniqid();

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("insert into ggroup (gid, gname, cuid, gdescription) values (?, ?, ?, ?);")) {
    $result->bind_param("ssis", $gid, $gname, $uid, $gdescription);
    $result->execute();
    $result->close();
}

if ($result = $db->prepare("insert into join_group (uid, gid) values (?, ?);")) {
    $result->bind_param("is", $uid, $gid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='group.php'</script>";
exit();
?>