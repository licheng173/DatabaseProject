<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}
?>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>CookZilla</title>
    <meta name="generator" content="Bootply"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <link href="css/styles.css" rel="stylesheet">
    <script type="text/javascript" src="js/angular.min.js"></script>
</head>
<body ng-app="myApp" ng-controller="myCtrl">

<?php

include "../dbconf.inc";

$rpid = -1;

if (isset($_GET['id'])) {
    $rpid = $_GET['id'];
}


$uid = $_SESSION['uid'];

$photo_json = array();

if ($rpid != -1) {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select id, uid, uname, content from report natural join user where id = ?;")) {
        $result->bind_param("s", $rpid);
        $result->execute();
        $result->bind_result($rpid, $rpuid, $rpuname, $content);
        $result->fetch();
        $result->close();
    }

    if ($result = $db->prepare("select id from report_photo where rpid = ?;")) {
        $result->bind_param("s", $rpid);
        $result->execute();
        $result->bind_result($photo_id);
        while ($result->fetch()) {
            $photo_json[$photo_id]["photo_id"] = $photo_id;
        }
        $result->close();
    }

    $db->close();
}
?>
<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">

            <!-- sidebar -->
            <?php
            include "sidebar.php";
            ?>
            <!-- /sidebar -->

            <!-- main right col -->
            <div class="column col-sm-10 col-xs-11" id="main">

                <!-- top nav -->
                <?php
                include "topnav.php";
                ?>

                <div class="padding">
                    <div class="full col-sm-9">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <p><?php echo $content; ?></p>
                                        <p>Posted by: <?php echo $rpuname; ?></p>
                                        <?php
                                        if ($rpuid == $uid) {
                                            ?>
                                            <a href="deleteReport.php?rpid=<?php echo $rpid; ?>">
                                                <button type="submit" class="btn btn-primary">Delete report</button>
                                            </a>
                                            <?php
                                        };
                                        ?>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- images -->
                        <div class="row">
                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in photo_records">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <img src="reportPhoto.php?photo_id={{ x.photo_id }}" style="width: 100%;">
                                        </br></br>
                                        <?php
                                        if ($rpuid == $uid) {
                                            ?>
                                            <a href="deleteReportPhoto.php?rpid=<?php echo $rpid; ?>&photo_id=<?php echo $photo_id; ?>">
                                                <button type="submit" class="btn btn-primary">Delete photo</button>
                                            </a>
                                            <?php
                                        };
                                        ?>
                                    </div>
                                </div>
                            </div>
                        </div><!--/row-->
                    </div>
                </div><!-- /padding -->
            </div>
            <!-- /main -->
        </div>
    </div>
</div>

<!-- script references -->
<script src="js/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>

<script src="js/scripts.js"></script>
<script type="text/javascript" language="javascript" class="init">
    var app = angular.module("myApp", []);
    app.controller("myCtrl", function ($scope) {
        $scope.photo_records = <?php echo json_encode(array_values($photo_json)); ?>;
    });
</script>
</body>
</html>


