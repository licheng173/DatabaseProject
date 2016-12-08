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

$uid = $_SESSION['uid'];

if ($uid != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select uname, name, uprofile from user where uid = ?;")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($uname, $name, $uprofile);
        $result->fetch();
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
                            <div class="panel-body">
                                <form role="form" method="post" name="profile_form" action="sendProfile.php"
                                      enctype="multipart/form-data">

                                    <input type="hidden" id="rid" name="uid" value="<?php echo $uid; ?>">

                                    <div class="form-group">
                                        <label for="username">Username</label>
                                        <input type="text" class="form-control" id="username" name="username"
                                               required value="<?php echo $uname; ?>">
                                    </div>

                                    <div class="form-group">
                                        <label for="realname">Real Name</label>
                                        <input type="text" class="form-control" id="realname" name="realname"
                                               required value="<?php echo $name; ?>">
                                    </div>

                                    <div class="form-group">
                                        <label for="uprofile">Profile</label>
                                        <textarea class="form-control input-lg" id="uprofile" name="uprofile"><?php echo $uprofile; ?></textarea>
                                    </div>

                                    <div class="form-group">
                                        <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" name="confirm-password" id="confirm-password" class="form-control" placeholder="Confirm Password" required>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Update</button>
                                    </br></br>
                                </form>
                            </div>
                        </div>
                        </br></br>
                    </div><!-- /col-9 -->
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
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
        $scope.ingredient_records = <?php echo json_encode(array_values($ingredient_json)); ?>;
        $scope.tag_records = <?php echo json_encode(array_values($tag_json)); ?>;
        $scope.review_records = <?php echo json_encode(array_values($review_json)); ?>;
        $scope.link_records = <?php echo json_encode(array_values($links_json)); ?>;
    });


    $(document).ready(function () {
        var photo_wrapper = $(".input_photos_wrap"); //Fields wrapper
        var add_photo_button = $(".add_photo_button"); //Add button ID

        $(add_photo_button).click(function (e) { //on add input button click
            e.preventDefault();
            $(photo_wrapper).append('<div><input type="file" id="photo[]" name="photo[]"><a href="#" class="remove_field">Remove</a></div>'); //add input box
        });

        $(photo_wrapper).on("click", ".remove_field", function (e) { //user click on remove text
            e.preventDefault();
            $(this).parent('div').remove();
        });

        var suggestion_wrapper = $(".input_suggestions_wrap"); //Fields wrapper
        var add_suggestion_button = $(".add_suggestion_button"); //Add button ID

        $(add_suggestion_button).click(function (e) { //on add input button click
            e.preventDefault();
            $(suggestion_wrapper).append('<div><textarea class="form-control input-lg" id="suggestion[]" name="suggestion[]"></textarea><a href="#" class="remove_field">Remove</a></div>'); //add input box
        });

        $(suggestion_wrapper).on("click", ".remove_field", function (e) { //user click on remove text
            e.preventDefault();
            $(this).parent('div').remove();
        });
    });
</script>
</body>
</html>


