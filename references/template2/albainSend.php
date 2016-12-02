<?php

date_default_timezone_set('America/Chicago');

$ecogPerformanceScore = $_POST['ecogPerformanceScore'];
$ldhLevel = $_POST['ldhLevel'];
$hemoglobinValue = $_POST['hemoglobinValue'];
$age = $_POST['age'];

$incorrectHemoglobinValue = 0;
$incorrectAge = 0;

if(!is_numeric($hemoglobinValue) || $hemoglobinValue < 0 || $hemoglobinValue > 50) {
    $incorrectHemoglobinValue = 1;
}

if(!is_numeric($age) || $age < 0 || $age > 100) {
    $incorrectAge = 1;
}

if ($incorrectHemoglobinValue == 1 || $incorrectAge == 1) {
    echo "<script>location.href='albain.php?incorrectHemoglobinValue=$incorrectHemoglobinValue&incorrectAge=$incorrectAge'</script>";
    exit();
}

$parameters =
    $age . "|" .
    $ecogPerformanceScore . "|" .
    $ldhLevel . "|" .
    $hemoglobinValue;

include "../../dbincloc/nomogram.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select JOBID from Jobs where Parameters = ? and Software = 'nomogram' and Analysis = 'albain' and Status = 2 and ResultImage is not null limit 1;")) {
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
        if ($result1 = $db->prepare("INSERT INTO Jobs (JOBID, Parameters, Software, Analysis, ResultPlot, ResultTable, ResultFile, CreateTime, FinishTime) VALUES (?, ?, 'nomogram', 'albain', '', '', '', now(), ?);")
        ) {
            $result1->bind_param("sss", $JOBID, $parameters, $dateString);
            $result1->execute();
            $result1->close();
        }
    }

    echo "<script>location.href='albain.php?jobid=" . $JOBID .
        "&ecogPerformanceScore=" . $ecogPerformanceScore .
        "&ldhLevel=" . $ldhLevel .
        "&hemoglobinValue=" . $hemoglobinValue .
        "&age=" . $age .
        "'</script>";
}

$db->close();

?>
