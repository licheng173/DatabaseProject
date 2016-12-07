
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

                        <a ng-repeat="x in tag_records" href="tagSpecific.php?tid={{ x.tid }}">
                            <button type="button" class="btn btn-success">{{ x.ttitle }}</button>
                        </a>
                        </br></br>

                        <div class="panel panel-default">
                            <p><?php echo $rtitle ?></p>
                        </div>

                        <div class="panel panel-default">
                            <p>Serving: <?php echo $rserving ?></p>
                        </div>

                        <div class="panel panel-default">
                            <p><?php echo $rdescription ?></p>
                        </div>

                        <div class="panel panel-default" ng-repeat="x in ingredient_records">
                            <p>{{ x.iname }} {{ x.iquantity }} g</p>
                        </div>

                        <!-- images -->
                        <div class="row">
                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in records">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <img src="image.php?pid={{ x.pid }}" style="width: 100%;">
                                    </div>
                                </div>
                            </div>
                        </div><!--/row-->
                    </div>

                    <div class="full col-sm-9">

                        <h2>Reviews</h2>

                        <div class="panel panel-default" ng-repeat="x in review_records">
                            <div class="panel-body">
                                <p>{{ x.rvtitle }}</p>
                                <p>{{ x.rtext }}</p>
                                <img src="images/star{{ x.rrate }}.svg" style="height: 20px;">
                                <p>{{ x.r_uname }}</p>
                            </div>
                        </div>

                        <!--new review-->
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <h3>New Review</h3>
                                <hr>
                                <form role="form" method="post" name="review_form" action="sendReview.php"
                                      enctype="multipart/form-data">

                                    <input type="hidden" id="rid" name="rid" value="<?php echo $rid; ?>">
                                    <div class="form-group">
                                        <label for="rvtitle">Title</label>
                                        <input type="text" class="form-control" id="rvtitle" name="rvtitle"
                                               required>
                                    </div>

                                    <div class="form-group">
                                        <label for="rtext">Review Detail</label>
                                        <textarea class="form-control input-lg" id="rtext" name="rtext"
                                                  placeholder="What's your opinion?"></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="rrate">Rating</label>
                                        <select id="rrate" name="rrate">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="photos">Photo(s)</label>
                                        <div class="input_photos_wrap" id="photos">
                                            <div><input type="file" id="photo[]" name="photo[]"></div>
                                        </div>
                                        </br>
                                        <button class="add_photo_button btn btn-primary">Add More Photos
                                        </button>
                                    </div>

                                    <div class="form-group">
                                        <label for="suggestions">Suggestion(s)</label>
                                        <div class="input_suggestions_wrap" id="suggestions">
                                        </div>
                                        </br>
                                        <button class="add_suggestion_button btn btn-primary">Add More Suggestions
                                        </button>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
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

