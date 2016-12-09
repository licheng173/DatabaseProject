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

                            <!--search-->
                            <form role="form" method="get" name="tag_form" action="search.php"
                                  enctype="multipart/form-data">

                                <label for="keyword">Keyword</label>
                                <input type="text" id="keyword" name="keyword">
                                &nbsp;&nbsp;

                                <label for="tag">Tag</label>
                                <select id="tag" name="tag">
                                    <option value="0">all</option>
                                    <option ng-repeat="x in tag_records" value="{{ x.tid }}">{{ x.ttitle }}
                                    </option>
                                </select>
                                &nbsp;&nbsp;

                                <label for="rating">Rating</label>
                                <select id="rating" name="rating">
                                    <option value=0>all</option>
                                    <option value=1>1</option>
                                    <option value=2>2</option>
                                    <option value=3>3</option>
                                    <option value=4>4</option>
                                    <option value=5>5</option>
                                </select>
                                &nbsp;&nbsp;

                                <button type="submit" class="btn btn-primary">Search</button>
                            </form>
                            </br></br>
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
                                                <p>Serving: {{ x.rserving }}</p>
                                                <p>{{ x.rdescription }}</p>
                                                <img src="images/star{{ x.rank }}.svg" style="height: 20px;">
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

$json = array();

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

$sql = "select rid, rtitle, rserving, rdescription, sum(rrate)/ count(rid) as rank from recipe natural left join review group by rid;";
$result = $db->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $rid = $row["rid"];
        $json[$rid]["rid"] = $row["rid"];
        $json[$rid]["rtitle"] = $row["rtitle"];
        $json[$rid]["rserving"] = $row["rserving"];
        $json[$rid]["rdescription"] = $row["rdescription"];
        $json[$rid]["rank"] = (int)($row["rank"]);
    }
}
$result->close();

$tag_json = array();

if ($result = $db->prepare("select tid, ttitle from tag;")) {
    $result->execute();
    $result->bind_result($tid, $ttitle);

    while ($result->fetch()) {
        $tag_json[$tid]["tid"] = $tid;
        $tag_json[$tid]["ttitle"] = $ttitle;
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
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
        $scope.tag_records = <?php echo json_encode(array_values($tag_json)); ?>;
    });
</script>
</body>
</html>

