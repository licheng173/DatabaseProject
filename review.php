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

$r_id = -1;

if (isset($_GET['r_id'])) {
    $r_id = $_GET['r_id'];
}


$uid = $_SESSION['uid'];

$photo_json = array();
$suggestion_json = array();

if ($r_id != -1) {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select rvtitle, rrate, rtext, uname, uid from review natural join user where r_id = ?;")) {
        $result->bind_param("s", $r_id);
        $result->execute();
        $result->bind_result($rvtitle, $rrate, $rtext, $uname, $review_uid);
        $result->fetch();
        $result->close();
    }

    if ($result = $db->prepare("select p_id, photo from review_photo where r_id = ?;")) {
        $result->bind_param("s", $r_id);
        $result->execute();
        $result->bind_result($pid, $photo);
        while ($result->fetch()) {
            $photo_json[$pid]["pid"] = $pid;
        }
        $result->close();
    }

    if ($result = $db->prepare("select sid, content from review_suggestion where r_id = ?;")) {
        $result->bind_param("s", $r_id);
        $result->execute();
        $result->bind_result($sid, $scontent);
        while ($result->fetch()) {
            $suggestion_json[$sid]["sid"] = $sid;
            $suggestion_json[$sid]["scontent"] = $scontent;
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

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4><?php echo $rvtitle; ?></h4>
                            </div>
                            <div class="panel-body">
                                <p><?php echo $rtext; ?></p>
                                <img src="images/star<?php echo $rrate; ?>.svg" style="height: 20px;">
                                </br></br>
                                <p>Posted by: <?php echo $uname; ?></p>
                            </div>
                        </div>

                        <h3>Suggestions</h3>
                        <div class="panel panel-default">
                            <div class="panel-body" ng-repeat="x in suggestion_records">
                                <p>{{ x.scontent }} </p>
                            </div>
                        </div>

                        <!-- images -->
                        <div class="row">
                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in photo_records">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <img src="reviewPhoto.php?rpid={{ x.pid }}" style="width: 100%;">
                                    </div>
                                </div>
                            </div>
                        </div><!--/row-->

                        </br>
                        <?php
                        if ($review_uid == $uid) {
                            ?>
                            <a href="deleteReview.php?r_id=<?php echo $r_id; ?>">
                                <button type="submit" class="btn btn-primary">Delete review</button>
                            </a>
                            <?php
                        };
                        ?>
                        </br></br></br></br></br>
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
        $scope.suggestion_records = <?php echo json_encode(array_values($suggestion_json)); ?>;
    });
</script>
</body>
</html>


