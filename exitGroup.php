<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$uid = $_SESSION['uid'];
$gid = $_GET['gid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from join_group where uid = ? and gid = ?;")) {
    $result->bind_param("is", $uid, $gid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='group.php'</script>";
exit();
?>