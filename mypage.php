<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}
?>

<!DOCTYPE html>
<html lang="en">
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
    <style>
        .serve-p {
            font-family:fantasy;
            font-size: 16px;
        }
        .im {
            margin-right: 30px;
        }
        .description-p {
            color: #7f7f7f;
            padding-top: .5rem;
            clear:both;
            text-align: justify;
        }
    </style>
</head>
<body>
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
                        <!-- content -->
                        <div class="row" ng-app="myApp" ng-controller="myCtrl">
                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in records">
                                <a href="recipe.php?rid={{ x.rid }}">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <img src="imgShow.php?rid={{ x.rid }}" style="width: 100%;">
                                            <div class="panel-heading">
                                                <h4>{{ x.rtitle }}</h4>
                                            </div>
                                            <div class="panel-body">
                                                <div>
                                                    <img class="im" src="images/star{{ x.rank }}.svg" style="height: 20px;">
                                                    <span class="serve-p"> Serving:&nbsp;{{x.rserving }}</span>
                                                </div>
                                                
                                                <div class="description-p">{{ x.rdescription }}</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div><!--/row-->
                    </div><!-- /col-9 -->
                </div><!-- /padding -->
            </div>
            <!-- /main -->

        </div>
    </div>
</div>

<?php

include "../dbconf.inc";

$uid = $_SESSION['uid'];

$json = array();

if ($uid != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select rid, rtitle, rserving, rdescription, sum(rrate)/ count(rid) as rank from recipe natural left join review where uid = ? group by rid;")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($rid, $rtitle, $rserving, $rdescription, $rank);

        while ($result->fetch()) {
            $json[$rid]["rid"] = $rid;
            $json[$rid]["rtitle"] = $rtitle;
            $json[$rid]["rserving"] = $rserving;
            $json[$rid]["rdescription"] = $rdescription;
            $json[$rid]["rank"] = (int)($rank);
        }
        $result->close();
    }
    $db->close();
}
?>

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
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
    });
</script>
</body>
</html>

