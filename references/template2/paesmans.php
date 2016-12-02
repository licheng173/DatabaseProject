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
            $('#paesmans').addClass('active');
            $('#myTable').DataTable({
                "paging": false,
                "bFilter": false
            });

            $('#myTable2').DataTable({
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

<div class="col-xs-12 col-sm-6 col-md-2">
    <h3>Input parameters</h3>
    <form role="form" method="POST" name="paesmansForm" action="paesmansSend.php">
        <div class="form-group">
            <label for="gender">Gender</label>
            <select class="form-control" id="gender" name="gender">
                <option <?php if ($_GET['gender'] == "Male") {
                    echo "selected";
                } ?>>Male
                </option>
                <option <?php if ($_GET['gender'] == "Female") {
                    echo "selected";
                } ?>>Female
                </option>
            </select>
        </div>
        <div class="form-group">
            <label for="diseaseExtent">Disease extent</label>
            <select class="form-control" id="diseaseExtent" name="diseaseExtent">
                <option <?php if ($_GET['diseaseExtent'] == "Limited") {
                    echo "selected";
                } ?>>Limited
                </option>
                <option <?php if ($_GET['diseaseExtent'] == "Disseminated") {
                    echo "selected";
                } ?>>Disseminated
                </option>
            </select>
        </div>
        <div class="form-group">
            <label for="karnofskyPerformanceStatus">Karnofsky performance status</label>
            <input type="text" class="form-control" id="karnofskyPerformanceStatus" name="karnofskyPerformanceStatus" <?php
            if ($_GET['incorrectKarnofskyPerformanceStatus'] == 1) {
                echo "placeholder=\"0 &le; value &le; 100\"";
            } else {
                if (isset($_GET['karnofskyPerformanceStatus'])) {
                    echo "value=\"" . $_GET['karnofskyPerformanceStatus'] . "\";";
                } else {
                    echo "value=\"80\";";
                }
            }
            ?>>
        </div>
        <div class="form-group">
            <label for="whitBloodCellCount">White blood cell count</label>
            <select class="form-control" id="whitBloodCellCount" name="whitBloodCellCount">
                <option <?php if ($_GET['whitBloodCellCount'] == "Normal") {
                    echo "selected";
                } ?>>Normal
                </option>
                <option <?php if ($_GET['whitBloodCellCount'] == "Abnormal") {
                    echo "selected";
                } ?>>Abnormal
                </option>
            </select>
        </div>
        <div class="form-group">
            <label for="neutrophilCount">Neutrophil count</label>
            <select class="form-control" id="neutrophilCount" name="neutrophilCount">
                <option <?php if ($_GET['neutrophilCount'] == "Normal") {
                    echo "selected";
                } ?>>Normal
                </option>
                <option <?php if ($_GET['neutrophilCount'] == "Abnormal") {
                    echo "selected";
                } ?>>Abnormal
                </option>
            </select>
        </div>
        <div class="form-group">
            <label for="weightLoss">Weight loss (%)</label>
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

<div class="col-xs-12 col-sm-12 col-md-8">

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
            if ($result = $db->prepare("SELECT Status, ResultTable, ResultPlot FROM Jobs where JOBID = ?")) {
                $result->bind_param("s", $jobid);
                $result->execute();
                $result->store_result();
                $result->bind_result($status, $resultTable, $resultPlot);
                $result->fetch();

                if ($result->num_rows > 0) {
                    if ($status == "2") {
                        $resultTable = trim($resultTable);
                        $lines = explode(PHP_EOL, $resultTable);
                        $resultTableArray = array();
                        foreach ($lines as $line) {
                            $resultTableArray[] = str_getcsv($line);
                        } ?>

                        <div class="container col-xs-12 col-sm-12 col-md-12">
                            <ul class="nav nav-tabs col-xs-12 col-sm-12 col-md-10">
                                <li class="active"><a data-toggle="pill" href="#plot">Survival Rate Plot</a></li>
                                <li><a data-toggle="pill" href="#diagram">Tree Diagram</a></li>
                            </ul>

                            <div class="tab-content col-xs-12 col-sm-12 col-md-12">
                                <div id="plot" class="tab-pane fade in active">
                                    <img class="col-xs-12 col-sm-12 col-md-10"
                                         src="imgShow.php?id=<?php echo $jobid ?>&resultName=ResultImage"/>

                                    <div class="col-xs-12 col-sm-12 col-md-10">
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
                                    <div class="col-xs-12 col-sm-12 col-md-11">
                                        <hr>
                                        <p>The survival curve and table values are estimated from Paesmans et al<span class="sup">2</span> Figure 3. To view how patient groups
                                            are organized, go to the Tree Diagram tab above.</p>
                                        <br/>
                                    </div>
                                </div>
                                <div id="diagram" class="tab-pane fade">
                                    <img class="col-xs-12 col-sm-12 col-md-12"
                                         src="imgShow.php?id=<?php echo $jobid ?>&resultName=ResultFile"/>
                                    <?php

                                    $resultPlot = trim($resultPlot);
                                    $lines2 = explode(PHP_EOL, $resultPlot);
                                    $resultTableArray2 = array();
                                    foreach ($lines2 as $line2) {
                                        $resultTableArray2[] = str_getcsv($line2);
                                    } ?>
                                    <div class="col-xs-12 col-sm-12 col-md-11">
                                        <div style="padding: 5%;">
                                            <table id="myTable2" class="display" cellspacing="0" width="100%">
                                                <thead>
                                                    <tr>
                                                        <th><?php echo $resultTableArray2[0][0] ?></th>
                                                        <th><?php echo $resultTableArray2[0][1] ?></th>
                                                        <th><?php echo $resultTableArray2[0][2] ?></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><?php echo $resultTableArray2[1][0] ?></td>
                                                        <td><?php echo $resultTableArray2[1][1] ?></td>
                                                        <td><?php echo $resultTableArray2[1][2] ?></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-11">
                                        <hr>
                                        <p>Tree diagram as replicated from Paesmans et al<span class="sup">2</span> manuscript for the entire population (Fig. 2). For specific survival rates at a certain time, go to Survival Rate Plot tab above.<br/>
                                        Abbreviations: WBC, white blood cell count; PS, ECOG performance status; NC, neutrophil count; WL, weight loss.</p>
                                        <br/>
                                    </div>
                                </div>
                            </div>
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
    <div class="col-xs-12 col-sm-12 col-md-11">
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