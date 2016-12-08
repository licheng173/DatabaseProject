<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$uid = $_SESSION['uid'];

$rid = $_POST['rid'];
$myrid = $_POST['myrid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("insert into link_recipe (rid, rid_link) values (?, ?);")) {
    $result->bind_param("ss", $myrid, $rid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='recipe.php?rid=$rid'</script>";
exit();
?>