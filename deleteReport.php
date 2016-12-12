<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: index.php");
}

$rpid = $_GET['rpid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select eid from report where id = ?;")) {
    $result->bind_param("s", $rpid);
    $result->execute();
    $result->bind_result($eid);
    $result->fetch();
    $result->close();
}

if ($result = $db->prepare("delete from report where id = ?;")) {
    $result->bind_param("s", $rpid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='individualEvent.php?eid=$eid'</script>";
exit();
?>