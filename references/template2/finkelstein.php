<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prognostic Model for Predicting Survival in Non Small Cell Lung Cancer Patients</title>

    <link rel="stylesheet" href="style/bootstrap.min.css"
          integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="style/bootstrap-theme.min.css"
          integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
    <link rel="stylesheet" href="style/style.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="style/jquery.dataTables.min.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#finkelstein').addClass('active');
            $('#myTable').DataTable({
                "paging": false,
                "bFilter": false
            });
        });

        function timedRefresh(timeoutPeriod) {
            setTimeout("location.reload();", timeoutPeriod);
        }
    </script>
</head>
<body>
<?php include "header.php"; ?>

<div class="col-xs-12 col-sm-6 col-md-3">
    <h3>Input parameters</h3>
    <form role="form" method="POST" name="finkelsteinForm" action="finkelsteinSend.php">
        <div class="form-group">
            <label for="gender">Gender</label>
            <select class="form-control" id="gender" name="gender">
                <option <?php if($_GET['gender'] == "Male") {echo "selected";}?>>Male</option>
                <option <?php if($_GET['gender'] == "Female") {echo "selected";}?>>Female</option>
            </select>
        </div>
        <div class="form-group">
            <label for="histology">Histology</label>
            <select class="form-control" id="histology" name="histology">
                <option <?php if($_GET['histology'] == "Large cell carcinoma") {echo "selected";}?>>Large cell carcinoma</option>
                <option <?php if($_GET['histology'] == "Adenocarcinoma or Squamous cell carcinoma") {echo "selected";}?>>Adenocarcinoma or Squamous cell carcinoma</option>

            </select>
        </div>
        <div class="form-group">
            <label for="ecog">Inital ECOG score</label>
            <select class="form-control" id="ecog" name="ecog">
                <option <?php if($_GET['ecog'] == 0) {echo "selected";}?>>0</option>
                <option <?php if($_GET['ecog'] == ">=1") {echo "selected";}?>>>=1</option>
            </select>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="subcutaneous" <?php if($_GET['subcutaneous'] == 1) {echo "checked";}?>>Subcutaneous metastasis</label>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="bone" <?php if($_GET['bone'] == 1) {echo "checked";}?>>Bone metastasis</label>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="liver" <?php if($_GET['liver'] == 1) {echo "checked";}?>>Liver metastasis</label>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="shoulder" <?php if($_GET['shoulder'] == 1) {echo "checked";}?>>Shoulder/Arm pain</label>
        </div>
        <div class="form-group">
            <label for="weightLoss">Prior weight loss (%)</label>
            <input type="text" class="form-control" id="weightLoss" name="weightLoss" <?php
            if ($_GET['incorrectWeightLoss'] == 1) {
                echo "placeholder=\"0 &le; value &le; 100\"";
            } else {
                if (isset($_GET['weightLoss'])) {
                    echo "value=\"" . $_GET['weightLoss'] . "\";";
                } else {
                    echo "value=\"0\";";
                }
            }
            ?>>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>

<div class="col-xs-12 col-sm-12 col-md-6">


    <?php
    # refresh webpage each 5 sec till the result is obtained from database.

    include "../../dbincloc/nomogram.inc";

    //open the database connection
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if (isset($_GET['jobid'])) {

        $jobid = mysqli_real_escape_string($db, $_GET['jobid']);

        $status = "0";
        $message = "";

        if (!empty($jobid)) {
            if ($result = $db->prepare("SELECT Status, ResultPlot FROM Jobs where JOBID = ?")) {
                $result->bind_param("s", $jobid);
                $result->execute();
                $result->store_result();
                $result->bind_result($status, $resultText);
                $result->fetch();

                if ($result->num_rows > 0) {
                    if ($status == "2") {
                        ?>
                        <img class="col-xs-12 col-sm-12 col-md-12"
                             src="imgShow.php?id=<?php echo $jobid ?>&resultName=ResultImage"/>

                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <h4><?php echo $resultText ?></h4>
                            <br/>
                        </div>
                        <div>
                            <br/>
                            <hr>
                            <p>This binary prognostic model from Finkelstein et al<span class="sup">4</span> gives a score to each positive prognostic factor. The scores are totaled and the calculated score is found using a formula provided in the appendix of the paper. The model predicts that the patient will survive for one year if the calculated value is above a certain threshold as represented by the red line.</p>
                            <br/>
                        </div>
                        <?php
                    } else if ($status == "3") { ?>
                        <h2>Job failed with unexpected reason.</h2>
                        <?php
                    } else { ?>
                        <img style="margin: 10% 35%;" src="img/Preloader_8.gif" onload="timedRefresh(2000)"/>
                    <?php }
                } else { ?>
                    <h2>No Job Found.</h2>
                    <?php
                }
                $result->close();
            } else { ?>
                <h2>DataBase Connection Failed.</h2>
            <?php }
        } else { ?>
            <h2>Job Submission Failed.</h2>
        <?php }
        $db->close();
    } else { ?>
        <div class="col-xs-12 col-sm-12 col-md-12">
            <hr>
            <h4>Please input parameters and press "Submit" button</h4>
            <br/>
        </div>
    <?php }
    ?>
</div>
<!-- Latest compiled and minified JavaScript -->
<script src="js/bootstrap.min.js"
        integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
        crossorigin="anonymous"></script>

</body>
</html>