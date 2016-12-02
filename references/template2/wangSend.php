<?php

date_default_timezone_set('America/Chicago');

$gender = $_POST['gender'];
$histology = $_POST['histology'];
$ecog = $_POST['ecog'];
$skinMetastasis = $_POST['skinMetastasis'];
if ($skinMetastasis != 1) {
    $skinMetastasis = 0;
}

$liverMetastasis = $_POST['liverMetastasis'];
if ($liverMetastasis != 1) {
    $liverMetastasis = 0;
}

$peritoneumMetastasis = $_POST['peritoneumMetastasis'];
if ($peritoneumMetastasis != 1) {
    $peritoneumMetastasis = 0;
}

$hemoglobin = $_POST['hemoglobin'];
$whiteBloodCell = $_POST['whiteBloodCell'];
$lymphocyte = $_POST['lymphocyte'];

$incorrectHemoglobin = 0;
$incorrectWhiteBloodCell = 0;
$incorrectLymphocyte = 0;

if(!is_numeric($hemoglobin) || $hemoglobin < 0 || $hemoglobin > 50) {
    $incorrectHemoglobin = 1;
}

if(!is_numeric($whiteBloodCell) || $whiteBloodCell < 1 || $whiteBloodCell > 100) {
    $incorrectWhiteBloodCell = 1;
}

if(!is_numeric($lymphocyte) || $lymphocyte < 0 || $lymphocyte > 100) {
    $incorrectLymphocyte = 1;
}

if ($incorrectHemoglobin == 1 || $incorrectWhiteBloodCell == 1 || $incorrectLymphocyte == 1) {
    echo "<script>location.href='index.php?incorrectHemoglobin=$incorrectHemoglobin&incorrectWhiteBloodCell=$incorrectWhiteBloodCell&incorrectLymphocyte=$incorrectLymphocyte'</script>";
    exit();
}

$parameters = 
    $gender . "|" .
    $histology . "|" .
    $ecog . "|" .
    $peritoneumMetastasis . "|" .
    $skinMetastasis . "|" .
    $liverMetastasis . "|" .
    $hemoglobin . "|" .
    $whiteBloodCell . "|" .
    $lymphocyte;

include "../../dbincloc/nomogram.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select JOBID from Jobs where Parameters = ? and Software = 'nomogram' and Analysis = 'wang' and Status = 2 and ResultImage is not null limit 1;")) {
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
        if ($result1 = $db->prepare("INSERT INTO Jobs (JOBID, Parameters, Software, Analysis, ResultPlot, ResultTable, ResultFile, CreateTime, FinishTime) VALUES (?, ?, 'nomogram', 'wang', '', '', '', now(), ?);")
        ) {
            $result1->bind_param("sss", $JOBID, $parameters, $dateString);
            $result1->execute();
            $result1->close();
        }
    }

    echo "<script>location.href='index.php?jobid=" . $JOBID .
        "&gender=" . $gender .
        "&histology=" . $histology .
        "&ecog=" . $ecog .
        "&skinMetastasis=" . $skinMetastasis .
        "&liverMetastasis=" . $liverMetastasis .
        "&peritoneumMetastasis=" . $peritoneumMetastasis .
        "&hemoglobin=" . $hemoglobin .
        "&whiteBloodCell=" . $whiteBloodCell .
        "&lymphocyte=" . $lymphocyte .
        "'</script>";
}

$db->close();

?>
