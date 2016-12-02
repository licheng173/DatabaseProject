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
    <link rel="stylesheet" href="style/jquery.dataTables.min.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="style/style.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#hoang').addClass('active');
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
    <form role="form" method="POST" name="hoangForm" action="hoangSend.php">
        <div class="form-group">
            <label for="numberOfMetastaticSites">Number of metastatic sites</label>
            <select class="form-control" id="numberOfMetastaticSites" name="numberOfMetastaticSites">
                <option <?php if($_GET['numberOfMetastaticSites'] == 0) {echo "selected";}?>>0</option>
                <option <?php if($_GET['numberOfMetastaticSites'] == 1) {echo "selected";}?>>1</option>
                <option <?php if($_GET['numberOfMetastaticSites'] == 2) {echo "selected";}?>>2</option>
                <option <?php if($_GET['numberOfMetastaticSites'] == 3) {echo "selected";}?>>3</option>
                <option <?php if($_GET['numberOfMetastaticSites'] == ">=4") {echo "selected";}?>>>=4</option>
            </select>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="subcutaneousMetastasis" <?php if($_GET['subcutaneousMetastasis'] == 1) {echo "checked";}?>>Subcutaneous metastasis</label>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="liverMetastasis" <?php if($_GET['liverMetastasis'] == 1) {echo "checked";}?>>Liver metastasis</label>
        </div>
        <div class="form-group">
            <label for="ecog">ECOG score</label>
            <select class="form-control" id="ecog" name="ecog">
                <option <?php if($_GET['ecog'] == 0) {echo "selected";}?>>0</option>
                <option <?php if($_GET['ecog'] == 1) {echo "selected";}?>>1</option>
                <option <?php if($_GET['ecog'] == ">=2") {echo "selected";}?>>>=2</option>
            </select>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="lossOfAppetite" <?php if($_GET['lossOfAppetite'] == 1) {echo "checked";}?>>Loss of appetite</label>
        </div>
        <div class="checkbox">
            <label><input type="checkbox" value=1 name="noPreviousLungSurgery" <?php if($_GET['noPreviousLungSurgery'] == 1) {echo "checked";}?>>No previous lung surgery</label>
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
                                        <th><?php echo $resultTableArray[0][2] ?></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td><?php echo $resultTableArray[1][0] ?></td>
                                        <td><?php echo $resultTableArray[1][1] ?></td>
                                        <td><?php echo $resultTableArray[1][2] ?></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div>
                            <br/>
                            <hr>
                            <p>The total points represents the sum of the 6 independent poor prognostic factors from the Hoang et al<span class="sup">1</span> multivariate analysis. The paper provided a nomogram for estimating one-year and two-year survival rates, which was fitted in a polynomial regression model to create the plot above.<br/><br/>
                                Each factor is given a point value to use for the nomogram: Subcutaneous metastasis - 66, lower performance status (ECOG 1 or 2) - 43, loss of appetite - 38, liver metastasis - 35, ≥ four metastatic sites - 19, no previous lung surgery - 15. The higher total points, the less likely the patient will survive.</p>
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