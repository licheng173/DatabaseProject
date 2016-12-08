<?php
include "../dbconf.inc";

//open the database connection
$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if (isset($_GET['photo_id'])) {
    $photo_id = $_GET['photo_id'];
}

header("Content-type: image/jpeg");

if (!empty($photo_id) && $result = $db->prepare("select photo from report_photo where id = ?;")) {
    $result->bind_param("i", $photo_id);
    $result->execute();
    $result->store_result();
    $result->bind_result($resultimage);
    $result->fetch();
    echo $resultimage;
    $result->close();
}
$db->close();
?>
