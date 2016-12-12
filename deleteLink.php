<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$rid = $_GET['rid'];
$link_rid = $_GET['link_rid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from link_recipe where rid = ? and rid_link = ?;")) {
    $result->bind_param("ss", $rid, $link_rid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='editRicpe.php?rid=$rid'</script>";
exit();
?>