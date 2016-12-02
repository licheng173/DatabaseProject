<?php

date_default_timezone_set('America/Chicago');

$gender = $_POST['gender'];

$diseaseExtent = $_POST['diseaseExtent'];

$karnofskyPerformanceStatus = $_POST['karnofskyPerformanceStatus'];

$whitBloodCellCount = $_POST['whitBloodCellCount'];

$neutrophilCount = $_POST['neutrophilCount'];

$weightLoss = $_POST['weightLoss'];

$incorrectKarnofskyPerformanceStatus = 0;
$incorrectWeightLoss = 0;

if(!is_numeric($karnofskyPerformanceStatus) || $karnofskyPerformanceStatus < 0 || $karnofskyPerformanceStatus > 100) {
    $incorrectKarnofskyPerformanceStatus = 1;
}

if(!is_numeric($weightLoss) || $weightLoss < 0 || $weightLoss > 100) {
    $incorrectWeightLoss = 1;
}

if ($incorrectKarnofskyPerformanceStatus == 1 || $incorrectWeightLoss == 1) {
    echo "<script>location.href='paesmans.php?incorrectKarnofskyPerformanceStatus=$incorrectKarnofskyPerformanceStatus&incorrectWeightLoss=$incorrectWeightLoss'</script>";
    exit();
}

$parameters =
    $gender . "|" .
    $diseaseExtent . "|" .
    $karnofskyPerformanceStatus . "|" .
    $whitBloodCellCount . "|" .
    $neutrophilCount . "|" .
    $weightLoss;

include "../../dbincloc/nomogram.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select JOBID from Jobs where Parameters = ? and Software = 'nomogram' and Analysis = 'paesmans' and Status = 2 and ResultImage is not null limit 1;")) {
    $result->bind_param("s", $parameters);
    $result->execute();
    $result->bind_result($JOBID);
    $result->fetch();
    $result->close();

    if (empty($JOBID)) {
        $JOBID = uniqid("", TRUE);

        $date = new DateTime('0000-01-01 00:00:00');
        $dateString = $date->format('Y-m-d H:i:s');

        // set job status as 0. 0 means non-dealt, while 1 means dealt
        if ($result1 = $db->prepare("INSERT INTO Jobs (JOBID, Parameters, Software, Analysis, ResultPlot, ResultTable, ResultFile, CreateTime, FinishTime) VALUES (?, ?, 'nomogram', 'paesmans', '', '', '', now(), ?);")
        ) {
            $result1->bind_param("sss", $JOBID, $parameters, $dateString);
            $result1->execute();
            $result1->close();
        }
    }

    echo "<script>location.href='paesmans.php?jobid=" . $JOBID .
        "&gender=" . $gender .
        "&diseaseExtent=" . $diseaseExtent .
        "&karnofskyPerformanceStatus=" . $karnofskyPerformanceStatus .
        "&whitBloodCellCount=" . $whitBloodCellCount .
        "&neutrophilCount=" . $neutrophilCount .
        "&weightLoss=" . $weightLoss .
        "'</script>";
}

$db->close();

?>
