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
</head>
<body ng-app="myApp" ng-controller="myCtrl">
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
                        <div class="row">

                            <!-- main col right -->
                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3>Keyword</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p ng-repeat="x in search_records">{{ x.stime }} &nbsp;&nbsp;&nbsp; <a
                                                href="search.php?keyword={{ x.keyword }}">{{ x.keyword }}</a>
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3>Tag</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p ng-repeat="x in tag_records">{{ x.tctime }} &nbsp;&nbsp;&nbsp; <a
                                                href="search.php?tag={{ x.tid }}">{{ x.ttitle }}</a>
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3>Recipe</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p ng-repeat="x in recipe_records">{{ x.vtime }} &nbsp;&nbsp;&nbsp; <a
                                                href="recipe.php?rid={{ x.rid }}">{{ x.rtitle }}</a>
                                        </p>
                                    </div>
                                </div>
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

$uid = $_SESSION['uid'];

include "../dbconf.inc";

$keyword_json = array();
$tag_json = array();
$recipe_json = array();

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select id, keyword, stime from search where uid = ? order by stime desc;")) {
    $result->bind_param("i", $uid);
    $result->execute();
    $result->bind_result($sid, $keyword, $stime);

    while ($result->fetch()) {
        $search_json[$sid]["keyword"] = $keyword;
        $search_json[$sid]["stime"] = $stime;
    }
    $result->close();
}

if ($result = $db->prepare("select id, tid, ttitle, tctime from tag_search natural join tag where uid = ? order by tctime desc;")) {
    $result->bind_param("i", $uid);
    $result->execute();
    $result->bind_result($t_id, $tid, $ttitle, $tctime);

    while ($result->fetch()) {
        $tag_json[$t_id]["tid"] = $tid;
        $tag_json[$t_id]["ttitle"] = $ttitle;
        $tag_json[$t_id]["tctime"] = $tctime;
    }
    $result->close();
}

if ($result = $db->prepare("select id, rid, vtime, rtitle from recipe_view natural join recipe where uid = ? order by vtime desc;")) {
    $result->bind_param("i", $uid);
    $result->execute();
    $result->bind_result($rvid, $rid, $vtime, $rtitle);

    while ($result->fetch()) {
        $recipe_json[$rvid]["rid"] = $rid;
        $recipe_json[$rvid]["vtime"] = $vtime;
        $recipe_json[$rvid]["rtitle"] = $rtitle;
    }
    $result->close();
}
$db->close();
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
        $scope.search_records = <?php echo json_encode(array_values($keyword_json)); ?>;
        $scope.tag_records = <?php echo json_encode(array_values($tag_json)); ?>;
        $scope.recipe_records = <?php echo json_encode(array_values($recipe_json)); ?>;
    });
</script>
</body>
</html>

