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
    <!-- serarch -->
    <!-- <link rel="stylesheet" type="text/css" href="css/default.css" /> -->
    <!-- <link rel="stylesheet" type="text/css" href="css/component.css" /> -->
    <script src="js/modernizr.custom.js"></script>
    <link href="css/styles.css" rel="stylesheet">


    <script type="text/javascript" src="js/angular.min.js"></script>
    <style type="text/css">
        .serve-p {
            font-family: fantasy;
            font-size: 16px;
        }

        .im {
            margin-right: 30px;
        }

        .description-p {
            color: #7f7f7f;
            padding-top: .5rem;
            clear: both;
            text-align: justify;
        }

        ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-section {

        }

        .sb-search {
            position: relative;
            margin-top: 10px;
            width: 0%;
            min-width: 60px;
            height: 60px;
            float: right;
            overflow: hidden;

            -webkit-transition: width 0.3s;
            -moz-transition: width 0.3s;
            transition: width 0.3s;

            -webkit-backface-visibility: hidden;
        }

        .sb-search-input {
            position: absolute;
            top: 0;
            right: 0;
            border: none;
            outline: none;
            background: #fff;
            width: 100%;
            height: 60px;
            margin: 0;
            z-index: 10;
            padding: 20px 65px 20px 20px;
            font-family: inherit;
            font-size: 20px;
            color: #2c3e50;
        }

        input[type="search"].sb-search-input {
            -webkit-appearance: none;
            -webkit-border-radius: 0px;
        }

        .sb-search-input::-webkit-input-placeholder {
            color: #efb480;
        }

        .sb-search-input:-moz-placeholder {
            color: #efb480;
        }

        .sb-search-input::-moz-placeholder {
            color: #efb480;
        }

        .sb-search-input:-ms-input-placeholder {
            color: #efb480;
        }

        .sb-icon-search,
        .sb-search-submit {
            width: 60px;
            height: 60px;
            display: block;
            position: absolute;
            right: 0;
            top: 0;
            padding: 0;
            margin: 0;
            line-height: 60px;
            text-align: center;
            cursor: pointer;
        }

        .sb-search-submit {
            background: #fff; /* IE needs this */
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)"; /* IE 8 */
            filter: alpha(opacity=0); /* IE 5-7 */
            opacity: 0;
            color: transparent;
            border: none;
            outline: none;
            z-index: -1;
        }

        .sb-icon-search {
            color: #fff;
            background: #e67e22;
            z-index: 90;
            font-size: 22px;
            font-family: 'icomoon';
            speak: none;
            font-style: normal;
            font-weight: normal;
            font-variant: normal;
            text-transform: none;
            -webkit-font-smoothing: antialiased;
        }

        .sb-icon-search:before {
            content: "\e000";
        }

        @font-face {
            font-family: 'icomoon';
            src: url('../fonts/icomoon/icomoon.eot');
            src: url('../fonts/icomoon/icomoon.eot?#iefix') format('embedded-opentype'),
            url('../fonts/icomoon/icomoon.woff') format('woff'),
            url('../fonts/icomoon/icomoon.ttf') format('truetype'),
            url('../fonts/icomoon/icomoon.svg#icomoon') format('svg');
            font-weight: normal;
            font-style: normal;
        }

        .sb-search.sb-search-open,
        .no-js .sb-search {
            width: 100%;
        }

        .sb-search.sb-search-open .sb-icon-search,
        .no-js .sb-search .sb-icon-search {
            background: #da6d0d;
            color: #fff;
            z-index: 11;
        }

        .sb-search.sb-search-open .sb-search-submit,
        .no-js .sb-search .sb-search-submit {
            z-index: 90;
        }
    </style>
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
                            <div>

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

                            </div>
                            <!-- </ul> -->
                            <!--search-->

                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in records">
                                <a href="recipe.php?rid={{ x.rid }}">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <img src="imgShow.php?rid={{ x.rid }}" style="width: 100%; height: 200px;">
                                            <div class="panel-heading">
                                                <h5>{{ x.rtitle }}</h5>
                                            </div>
                                            <div class="panel-body">
                                                <div>
                                                    <img class="im" src="images/star{{ x.rank }}.svg"
                                                         style="height: 20px;">
                                                    <span class="serve-p"> Serving:{{x.rserving }}</span>
                                                </div>

<!--                                                <div class="description-p">{{ x.rdescription }}</div>-->
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

$sql = "select r.rid, r.rtitle, r.rserving, r.rdescription, sum(rv.rrate)/ count(r.rid) as rank from recipe r left join review rv on r.rid = rv.rid group by r.rid;";
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

<script src="js/classie.js"></script>
<script src="js/uisearch.js"></script>
<script>
    new UISearch(document.getElementById('sb-search'));
</script>

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

