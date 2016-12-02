<?php

date_default_timezone_set('America/Chicago');

$gender = $_POST['gender'];
$histology = $_POST['histology'];
$ecog = $_POST['ecog'];

$subcutaneous = $_POST['subcutaneous'];
if ($subcutaneous != 1) {
    $subcutaneous = 0;
}

$bone = $_POST['bone'];
if ($bone != 1) {
    $bone = 0;
}

$liver = $_POST['liver'];
if ($liver != 1) {
    $liver = 0;
}

$shoulder = $_POST['shoulder'];
if ($shoulder != 1) {
    $shoulder = 0;
}

$weightLoss = $_POST['weightLoss'];

if(!is_numeric($weightLoss) || $weightLoss < 0 || $weightLoss > 100) {
    $incorrectWeightLoss = 1;
}

if ($incorrectWeightLoss == 1) {
    echo "<script>location.href='finkelstein.php?incorrectWeightLoss=$incorrectWeightLoss'</script>";
    exit();
}

$parameters = $gender . "|" . 
    $histology . "|" . 
    $ecog . "|" . 
    $subcutaneous . "|" . 
    $bone . "|" . 
    $liver . "|" . 
    $shoulder . "|" . 
    $weightLoss;

include "../../dbincloc/nomogram.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select JOBID from Jobs where Parameters = ? and Software = 'nomogram' and Analysis = 'finkelstein' and Status = 2 and ResultImage is not null limit 1;")) {
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
        if ($result1 = $db->prepare("INSERT INTO Jobs (JOBID, Parameters, Software, Analysis, ResultPlot, ResultTable, ResultFile, CreateTime, FinishTime) VALUES (?, ?, 'nomogram', 'finkelstein', '', '', '', now(), ?);")
        ) {
            $result1->bind_param("sss", $JOBID, $parameters, $dateString);
            $result1->execute();
            $result1->close();
        }
    }

    echo "<script>location.href='finkelstein.php?jobid=" . $JOBID .
        "&gender=" . $gender .
        "&histology=" . $histology .
        "&ecog=" . $ecog .
        "&subcutaneous=" . $subcutaneous .
        "&bone=" . $bone .
        "&liver=" . $liver .
        "&shoulder=" . $shoulder .
        "&weightLoss=" . $weightLoss .
        "'</script>";
}

$db->close();

?>
