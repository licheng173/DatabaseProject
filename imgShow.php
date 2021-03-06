<?php
include "../dbconf.inc";

//open the database connection
$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if (isset($_GET['rid'])) {
    $rid = mysqli_real_escape_string($db, $_GET['rid']);
}

header("Content-type: image/jpeg");

if (!empty($rid) && $result = $db->prepare("select content from recipe_picture where rid = ? limit 1;")) {
    $result->bind_param("s", $rid);
    $result->execute();
    $result->store_result();
    $result->bind_result($resultimage);
    $result->fetch();
    echo $resultimage;
    $result->close();
}
$db->close();
?>
