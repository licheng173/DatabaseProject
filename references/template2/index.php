<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prognostic Model for Predicting Survival in Non Small Cell Lung Cancer Patients</title>
    <meta name="description" content="Online tool to predict the survival rate in non-small cell lung cancer patients"/>
    <meta name="keywords" content="tool, bioinformatics, prognostic, prediction, cancer, computational, model, survival, non-small, lung, patient"/>
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
            $('#wang').addClass('active');
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
    <form role="form" method="POST" name="wangForm" action="wangSend.php">
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
            <label for="ecog">ECOG score</label>
            <select class="form-control" id="ecog" name="ecog">
                <option <?php if($_GET['ecog'] == 0) {echo "selected";}?>>0</option>
                <option <?php if($_GET['ecog'] == 1) {echo "selected";}?>>1</option>
                <option <?php if($_GET['ecog'] == 2) {echo "selected";}?>>2</option>
                <option <?php if($_GET['ecog'] == ">=3") {echo "selected";}?>>>=3</option>
            </select>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="skinMetastasis" <?php if($_GET['skinMetastasis'] == 1) {echo "checked";}?>>Skin metastasis</label>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="liverMetastasis" <?php if($_GET['liverMetastasis'] == 1) {echo "checked";}?>>Liver metastasis</label>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="peritoneumMetastasis" <?php if($_GET['peritoneumMetastasis'] == 1) {echo "checked";}?>>Peritoneum metastasis</label>
        </div>
        <div class="form-group">
            <label for="hemoglobin">Hemoglobin test (g/dL)</label>
            <input type="text" class="form-control" id="hemoglobin" name="hemoglobin" <?php
            if ($_GET['incorrectHemoglobin'] == 1) {
                echo "placeholder=\"0 &le; value &le; 50\"";
            } else {
                if (isset($_GET['hemoglobin'])) {
                    echo "value=\"" . $_GET['hemoglobin'] . "\";";
                } else {
                    echo "value=\"0\";";
                }
            }
            ?> >
        </div>
        <div class="form-group">
            <label for="whiteBloodCell">White blood cell (million/mL)</label>
            <input type="text" class="form-control" id="whiteBloodCell" name="whiteBloodCell" <?php
            if ($_GET['incorrectWhiteBloodCell'] == 1) {
                echo "placeholder=\"1 &le; value &le; 100\"";
            } else {
                if (isset($_GET['whiteBloodCell'])) {
                    echo "value=\"" . $_GET['whiteBloodCell'] . "\";";
                } else {
                    echo "value=\"1\";";
                }
            }
            ?>>
        </div>
        <div class="form-group">
            <label for="lymphocyte">Lymphocyte percentage (%)</label>
            <input type="text" class="form-control" id="lymphocyte" name="lymphocyte" <?php
            if ($_GET['incorrectLymphocyte'] == 1) {
                echo "placeholder=\"0 &le; value &le; 100\"";
            } else {
                if (isset($_GET['lymphocyte'])) {
                    echo "value=\"" . $_GET['lymphocyte'] . "\";";
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
            if ($result = $db->prepare("SELECT Status, ResultTable FROM Jobs where JOBID = ?")) {
                $result->bind_param("s", $jobid);
                $result->execute();
                $result->store_result();
                $result->bind_result($status, $resultTable);
                $result->fetch();

                if ($result->num_rows > 0) {
                    if ($status == "2") {

                        $resultTable = trim($resultTable);
                        $lines = explode(PHP_EOL, $resultTable);
                        $resultTableArray = array();
                        foreach ($lines as $line) {
                            $resultTableArray[] = str_getcsv($line);
                        } ?>
                        <img class="col-xs-12 col-sm-12 col-md-12"
                             src="imgShow.php?id=<?php echo $jobid ?>&resultName=ResultImage"/>

                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <div style="padding: 5%;">
                                <table id="myTable" class="display" cellspacing="0" width="100%">
                                    <thead>
                                    <tr>
                                        <th><?php echo $resultTableArray[0][0] ?></th>
                                        <th><?php echo $resultTableArray[0][1] ?></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php foreach ($resultTableArray as $k => $v) {
                                        if ($k < 1) continue;
                                        ?>
                                        <tr>
                                            <td><?php echo $v[0] ?></td>
                                            <td><?php echo $v[1] ?></td>
                                        </tr>
                                        <?php
                                    } ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div>
                            <br/>
                            <hr>
                            <p>This nomogram was built by Cox proportional hazard model based on the variables: gender, cell histology, ECOG
                                performance status, metastasis to the skin, liver, and peritoneum, hemoglobin level, white blood cell
                                concentration, and lymphocyte percentage. A risk score is generated by each patient, the higher of which
                                represents higher chance of worse prognosis. The graph represents predicted survival probability over
                                time.</p>
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