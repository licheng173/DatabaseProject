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
    <!-- script references -->
    <script src="js/jquery-3.1.1.min.js"></script>
    <style type="text/css">
        input {
            margin-bottom: 4px;

        }
        .tag-div{
            font-family: Arial, Helvetica, sans-serif;
            font-size: 17px;
            font-weight: bold;
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
                            <!-- main col right -->
                            <div class="col-sm-12">
                                <br/>
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <form role="form" method="post" name="recipe_form" action="sendRecipe.php" enctype="multipart/form-data">
                                            <div class="form-group">
                                                <div class="tag-div" for="tag">Tag(s)</div>
                                                <span class="input_tags_wrap" id="tag" name="tag" ng-repeat="x in records">
                                                    <!-- <span class="checkbox"> -->
                                                        <label><input type="checkbox" value="{{ x.tid   }}" name="tag[] " > {{  x.ttitle }}</label>
                                                    <!-- </span> -->
                                                </span>
                                            </div>

                                            <div class="form-group">
                                                <label for="rtitle">Title</label>
                                                <input type="text" class="form-control" id="rtitle" name="rtitle"
                                                       required>
                                            </div>

                                            <div class="form-group">
                                                <label for="rserving">Serving</label>
                                                <input type="number" class="form-control" id="rserving" name="rserving"
                                                       required>
                                            </div>

                                            <div class="form-group">
                                                <label for="ingredient">Ingredient(s)</label>
                                                <div class="input_fields_wrap" id="ingredient" name="ingredient">
                                                    <div>
                                                        <input type="text" name="ingredients[]" required>
                                                        <label for="unit[]">Unit</label>
                                                        <select id="unit[]" name="unit[]">
                                                            <option ng-repeat="x in unit_records" value="{{ x.unit_name }}">{{ x.unit_name }}</option>
                                                        </select>
                                                        <label for="amount[]">Amount</label>
                                                        <input type="number" class="form-inline" id="amount[]" name="amount[]"
                                                               required>
                                                    </div>
                                                </div>
                                                <button class="add_field_button btn btn-primary">Add More Ingredients
                                                </button>
                                            </div>

                                            <div class="form-group">
                                                <label for="rdescription">Description</label>
                                                <textarea class="form-control input-lg" autofocus="" id="rdescription"
                                                          name="rdescription"
                                                          placeholder="What do you want to share?"></textarea>
                                            </div>

                                            <div class="form-group">
                                                <label for="photos">Photo(s)</label>
                                                <div class="input_photos_wrap" id="photos">
                                                    <div><input type="file" id="photo[]" name="photo[]"></div>
                                                </div>
                                                <button class="add_photo_button btn btn-primary">Add More Photos
                                                </button>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Submit</button>
                                        </form>

                                    </div>
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

<?php
include "../dbconf.inc";

$json = array();

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

//    $keyword = mysqli_real_escape_strings($db, $keyword);

if ($result = $db->prepare("select tid, ttitle from tag;")) {
    $result->execute();
    $result->bind_result($tid, $ttitle);

    while ($result->fetch()) {
        $json[$tid]["tid"] = $tid;
        $json[$tid]["ttitle"] = $ttitle;
    }
    $result->close();
}

$unit_json = array();

if ($result = $db->prepare("select unit_name from unit_conversion;")) {
    $result->execute();
    $result->bind_result($unit_name);

    while ($result->fetch()) {
        $unit_json[$unit_name]["unit_name"] = $unit_name;
    }
    $result->close();
}
$db->close();
?>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript" language="javascript" class="init">
    var app = angular.module("myApp", []);
    app.controller("myCtrl", function ($scope) {
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
        $scope.unit_records = <?php echo json_encode(array_values($unit_json)); ?>;
    });

    $(document).ready(function () {
        var wrapper = $(".input_fields_wrap"); //Fields wrapper
        var add_button = $(".add_field_button"); //Add button ID
        var unit_records = <?php echo json_encode(array_values($unit_json)); ?>;

        var s = '<div><input type="text" name="ingredients[]" required>\n<label for="unit">Unit</label>\n<select id="unit[]" name="unit[]">';
        for (var i = 0; i < unit_records.length; i++) {
            s += '<option value="'+ unit_records[i].unit_name + '">' + unit_records[i].unit_name + '</option>';
        }
        s += '</select>\n<label for="amount[]">Amount</label>\n<input type="number" class="form-inline" id="amount[]" name="amount[]" required><a href="#" class="remove_field">Remove</a></div>';

        $(add_button).click(function (e) { //on add input button click
            e.preventDefault();
            $(wrapper).append(s); //add input box
        });

        $(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
            e.preventDefault();
            $(this).parent('div').remove();
        });

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
    });

</script>
</body>
</html>