<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$eid = $_GET['eid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from event where eid = ?;")) {
    $result->bind_param("i", $eid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='event.php'</script>";
exit();
?>