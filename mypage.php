<?php
//session_start();
//
//if (!isset($_SESSION['uid'])) {
//    header("Location: login.php");
//}

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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <link href="css/styles.css" rel="stylesheet">
    <script type="text/javascript" src="js/angular.min.js"></script>
    <script type="text/javascript" language="javascript" class="init">
        $(document).ready(function() {
            var max_fields      = 10; //maximum input boxes allowed
            var wrapper         = $(".input_fields_wrap"); //Fields wrapper
            var add_button      = $(".add_field_button"); //Add button ID

            var x = 1; //initlal text box count
            $(add_button).click(function(e){ //on add input button click
                e.preventDefault();
                if(x < max_fields){ //max input box allowed
                    x++; //text box increment
                    $(wrapper).append('<div><input type="text" name="mytext[]"/><a href="#" class="remove_field">Remove</a></div>'); //add input box
                }
            });

            $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
                e.preventDefault(); $(this).parent('div').remove(); x--;
            })
        });
    </script>
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

                <div class="padding" >
                    <div class="full col-sm-9">
                        <!-- content -->
                        <div class="row" ng-app="myApp" ng-controller="myCtrl">
                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in records">
                                <div class="panel panel-default">
                                    <div class="panel-body" >
                                        <p>{{ x.rtitle }}</p>
                                        <p>{{ x.rserving }}</p>
                                        <p>{{ x.rdescription }}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <p><img src="images/714402.jpg"> <a href="#">The
                                                Bootstrap Playground</a></p>
                                        <div class="clearfix"></div>
                                        <hr>
                                        Design, build, test, and prototype using Bootstrap in real-time from your Web
                                        browser. Bootply combines the power of hand-coded HTML, CSS and JavaScript with
                                        the benefits of responsive design using Bootstrap. Find and showcase
                                        Bootstrap-ready snippets in the 100% free Bootply.com code repository.

                                        <div class="grid-col__ratings">
                                            <div class="rating-stars" data-scroll-to-anchor="reviews" data-ratingstars="3.85999989509583">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/empty-star.svg">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <p><img src="images/789272.jpg"> <a href="#">The
                                                Bootstrap Playground</a></p>
                                        <div class="clearfix"></div>
                                        <hr>
                                        Design, build, test, and prototype using Bootstrap in real-time from your Web
                                        browser. Bootply combines the power of hand-coded HTML, CSS and JavaScript with
                                        the benefits of responsive design using Bootstrap. Find and showcase
                                        Bootstrap-ready snippets in the 100% free Bootply.com code repository.

                                        <div class="grid-col__ratings">
                                            <div class="rating-stars" data-scroll-to-anchor="reviews" data-ratingstars="3.85999989509583">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/empty-star.svg">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div><!--/row-->

                        <div class="row" id="footer">
                            <div class="col-sm-6">

                            </div>
                            <div class="col-sm-6">
                                <p>
                                    <a href="#" class="pull-right">©Copyright 2013</a>
                                </p>
                            </div>
                        </div>

                        <hr>

                        <h4 class="text-center">
                            <a href="http://bootply.com/96266" target="ext">Download this Template @Bootply</a>
                        </h4>

                        <hr>


                    </div><!-- /col-9 -->
                </div><!-- /padding -->
            </div>
            <!-- /main -->

        </div>
    </div>
</div>



<?php

include "dbconf.inc";

$uid = 2;

$json = array();

if ($uid != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

//    $keyword = mysqli_real_escape_strings($db, $keyword);

    if ($result = $db->prepare("select rid, rtitle, rserving, rdescription from recipe where uid = ?;")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($rid, $rtitle, $rserving, $rdescription);

        while ($result->fetch()) {
            $json[$rid]["rid"] = $rid;
            $json[$rid]["rtitle"] = $rtitle;
            $json[$rid]["rserving"] = $rserving;
            $json[$rid]["rdescription"] = $rdescription;
        }
        $result->close();
    }
    $db->close();
}
?>

<!-- script references -->
<script src="js/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script src="js/scripts.js"></script>
<script type="text/javascript" language="javascript" class="init">
    var app = angular.module("myApp", []);
    app.controller("myCtrl", function ($scope) {
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
    });
</script>
</body>
</html>

