<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$uid = $_SESSION['uid'];
$eid = $_POST['eid'];
$content = htmlspecialchars($_POST['rpcontent']);

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

$rpid = uniqid();

if ($result = $db->prepare("insert into report (id, uid, eid, content) values (?, ?, ?, ?);")) {
    $result->bind_param("siis", $rpid, $uid, $eid, $content);
    $result->execute();
    $result->close();
}

if (isset($_FILES['photo']['tmp_name'])) {
    $files = $_FILES['photo']['tmp_name'];
    for ($i = 0; $i < count($files); $i++) {
        if ($result = $db->prepare("insert into report_photo (rpid, photo) values (?, ?);")) {
            $null = NULL;
            $result->bind_param("sb", $rpid, $null);
            $result->send_long_data(1, file_get_contents($_FILES["photo"]["tmp_name"][$i]));
            $result->execute();
            $result->close();
        }
    }
}
$db->close();
echo "<script>location.href='individualEvent.php?eid=$eid'</script>";
exit();
?>