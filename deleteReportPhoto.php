<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$rpid = $_GET['rpid'];
$photo_id = $_GET['photo_id'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from report_photo where id = ?;")) {
    $result->bind_param("i", $photo_id);
    $result->execute();
    $result->close();
}

$db->close();
echo "<script>location.href='report.php?id=$rpid'</script>";
exit();
?>