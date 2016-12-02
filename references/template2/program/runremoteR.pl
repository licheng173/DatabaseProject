#! /usr/bin/perl -w

use warnings;
use DBI;
use strict;
use Cwd;

# declare subroutines
sub trim;
sub createsaparams;
sub createcoeaparams;
sub createcomaparams;
sub createiaparams;
sub creategaparams;

#declare path
my $path = cwd();

# get db config
my $db_host;
my $db_username;
my $db_password;
open(IN_DATABASE, "dbconfig.inc") || die("The file dbconfig.inc is required. \n");
while(my $line = <IN_DATABASE>)
{
	chomp($line);

	if(lc(substr($line, 0, 4)) eq "host")
	{
		$db_host = trim(substr($line, 5));
		next;
	}

	if(lc(substr($line, 0, 8)) eq "username")
	{
		$db_username = trim(substr($line, 9));
		next;
	}

	if(lc(substr($line, 0, 8)) eq "password")
	{
		$db_password = trim(substr($line, 9));
	}
}
close(IN_DATABASE);

# connect to database
my $dbh = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
	           or die "Can't connect: " . DBI->errstr();

# Get jobid which has not been dealt with
my $sth1 = $dbh->prepare("SELECT JOBID, Analysis, Parameters, Software FROM Jobs where status = 0 order by CreateTime desc limit 1")
			or die("Prepare of SQL failed" . $dbh->errstr());
$sth1->execute();
my @result1 = $sth1->fetchrow_array();

$sth1->finish();
$dbh->disconnect();

# if no available job id is found in database, the perl code will stop
if($#result1 eq -1)
{
	die "No new job id is found in database!\n"
}

my $jobid = $result1[0];
my $analysis = $result1[1];
my $parameters = $result1[2];
my $software = $result1[3];

print "analysis is " . $analysis . "\n";
print "Software is " . $software . "\n";

if($analysis eq "survivalanalysis" && $software eq "lungcancerportal")
{
	my $saparams = createsaparams($parameters);

	print "Parameters are " . $saparams . "\n";

	my $plotxy = "[]";
	my $summaryinfo = "";
	my $image;
	
	if($saparams ne "")
	{
		system("Rscript runlcpsurvivalanalysis.R \"" . $saparams . "\"");

		#test number
		my $testnumber = 0;
 
		#test 2 times
		while((! -e "image.jpg") && $testnumber < 2)
		{
			sleep 6;
			$testnumber++;
		}	

		# read image
		open IMAGE, "image.jpg";
		#assume is a jpeg...
		my $buff;
		while(read IMAGE, $buff, 1024) {
	    		$image .= $buff;
		}
		close IMAGE;

		#read plot xy
		open PLOT, "plotxy.csv";
		$plotxy = "[";
		while(my $line = <PLOT>)
		{
			chomp($line);

			$plotxy .= "[";
			$plotxy .= $line;
			$plotxy .= "], "
		}
		$plotxy .= "]";
		close PLOT;

		# read summary
		open SUMMARY, "summary.csv";
		$summaryinfo = <SUMMARY>;
		$summaryinfo .= "|";
		$summaryinfo .= <SUMMARY>;
		close SUMMARY;
	}

	my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
	           or die "Can't connect: " . DBI->errstr();

	my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultPlot = '" . $plotxy . "', ResultTable = '" . $summaryinfo . "', Status = 1, FinishTime = now() where JOBID = '" . $jobid . "';");
	$stm->bind_param(1, $image, DBI::SQL_BLOB);
	$stm->execute();
	$stm->finish();
	$dbh1->disconnect();



	system("rm -rf image.jpg");
	system("rm -rf summary.csv");
	system("rm -rf plotxy.csv");
}


if($analysis eq "coexpanalysis" && $software eq "lungcancerportal")
{
	my $coeaparams = createcoeaparams($parameters);

	print "Parameters are " . $coeaparams . "\n";

	my $summaryinfo = "";
	my $image;
	
	if($coeaparams ne "")
	{
		system("Rscript runlcpcoexpanalysis.R " . $coeaparams);

		#test number
		my $testnumber = 0;

		#test 2 times
		while((! -e "image.jpg") && $testnumber < 2)
		{
			sleep 6;
			$testnumber++;
		}	

		# read image
		open IMAGE, "image.jpg";
		#assume is a jpeg...
		my $buff;
		while(read IMAGE, $buff, 1024) {
	    		$image .= $buff;
		}
		close IMAGE;

		# read summary
		open SUMMARY, "summary.csv";
		my $firstline = <SUMMARY>;
		chomp($firstline);
		$summaryinfo = $firstline;
		while(my $line = <SUMMARY>)
		{
			chomp($line);
			$summaryinfo .= "\n";
			$summaryinfo .= $line;
		}
		close SUMMARY;
	}

	my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
	           or die "Can't connect: " . DBI->errstr();

	my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultTable = '" . $summaryinfo . "', Status = 1, FinishTime = now() where JOBID = '" . $jobid . "';");
	$stm->bind_param(1, $image, DBI::SQL_BLOB);
	$stm->execute();
	$stm->finish();
	$dbh1->disconnect();

	system("rm -rf image.jpg");
	system("rm -rf summary.csv");
	system("rm -rf plotxy.csv");
}

if($analysis eq "comparativeanalysis" && $software eq "lungcancerportal")
{
	my $comaparams = createcomaparams($parameters);

	print "Parameters are " . $comaparams . "\n";

	my $summaryinfo = "";
	my $image;
	
	if($comaparams ne "")
	{
		system("Rscript runlcpcomparativeanalysis.R \"" . $comaparams . "\"");

		#test number
		my $testnumber = 0;

		#test 2 times
		while((! -e "image.jpg") && $testnumber < 2)
		{
			sleep 6;
			$testnumber++;
		}	

		# read image
		open IMAGE, "image.jpg";
		#assume is a jpeg...
		my $buff;
		while(read IMAGE, $buff, 1024) {
	    		$image .= $buff;
		}
		close IMAGE;

		# read summary
		open SUMMARY, "summary.csv";
		my $firstline = <SUMMARY>;
		chomp($firstline);
		$summaryinfo = "p-value|" . $firstline;
		close SUMMARY;
	}

	my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
	           or die "Can't connect: " . DBI->errstr();

	my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultTable = '" . $summaryinfo . "', Status = 1, FinishTime = now() where JOBID = '" . $jobid . "';");
	$stm->bind_param(1, $image, DBI::SQL_BLOB);
	$stm->execute();
	$stm->finish();
	$dbh1->disconnect();

	system("rm -rf image.jpg");
	system("rm -rf summary.csv");
}

if($analysis eq "integritedanalysis" && $software eq "lungcancerportal")
{
	my $iaparams = createiaparams($parameters);

	print "Parameters are " . $iaparams . "\n";

	my $image;
	
	if($iaparams ne "")
	{
		system("Rscript runlcpintegritedanalysis.R \"" . $iaparams . "\"");

		#test number
		my $testnumber = 0;

		#test 2 times
		while((! -e "image.jpg") && $testnumber < 2)
		{
			sleep 6;
			$testnumber++;
		}	

		# read image
		open IMAGE, "image.jpg";
		#assume is a jpeg...
		my $buff;
		while(read IMAGE, $buff, 1024) {
	    		$image .= $buff;
		}
		close IMAGE;
	}

	my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
	           or die "Can't connect: " . DBI->errstr();

	my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?,  Status = 1, FinishTime = now() where JOBID = '" . $jobid . "';");
	$stm->bind_param(1, $image, DBI::SQL_BLOB);
	$stm->execute();
	$stm->finish();
	$dbh1->disconnect();

	system("rm -rf image.jpg");
}


if($analysis eq "genomecomparative"  && $software eq "lungcancerportal")
{
	my $gaparams = creategaparams($parameters);

	print "Parameters are " . $gaparams . "\n";

	my $image;
	
	if($gaparams ne "")
	{
		system("Rscript runlcpgenomecomparative.R \"" . $gaparams . "\"");

		#test number
		my $testnumber = 0;

		#test 2 times
		while((! -e "image.jpg") && $testnumber < 2)
		{
			sleep 6;
			$testnumber++;
		}	

		# read image
		open IMAGE, "image.jpg";
		#assume is a jpeg...
		my $buff;
		while(read IMAGE, $buff, 1024) {
	    		$image .= $buff;
		}
		close IMAGE;	


		# read top
		open LIMMA, "limma.csv";

		my $maxi_input_one_time = 1000;
		my $sql_input = "";
		my $count_input = 0;

		while(my $line = <LIMMA>)
		{
			chomp($line);

			my @arr = split /,/, $line;
		
			if (index($line, "logFC") != -1) 
			{
	   			next;
			}

			if($count_input == 0)
			{
				$sql_input = "INSERT INTO GenomeComparison(JobID, EntrezID, LogFC, AveExpr, TValue, PValue, AdjPValue, BValue, Group1Avg, Group2Avg) VALUES ";
				$sql_input = $sql_input . "(\"" . $jobid . "\", \"" . $arr[0] . "\", \"" . $arr[1] . "\", \"" . $arr[2] . "\", \"" . $arr[3] . "\", \"" . $arr[4] . "\", \"" . $arr[5] . "\", \"" . $arr[6] . "\", \"" . $arr[7] . "\", \"" . $arr[8] . "\")";
	   			
				$count_input++;
				next;
			}

			if($count_input == $maxi_input_one_time)
			{
				$sql_input = $sql_input . ", (\"" . $jobid . "\", \"" . $arr[0] . "\", \"" . $arr[1] . "\", \"" . $arr[2] . "\", \"" . $arr[3] . "\", \"" . $arr[4] . "\", \"" . $arr[5] . "\", \"" . $arr[6] . "\", \"" . $arr[7] . "\", \"" . $arr[8] . "\")";

				my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
			   		or die "Can't connect: " . DBI->errstr();

				my $stm = $dbh1->prepare( $sql_input . ";");
				$stm->execute();
				$stm->finish();
				$dbh1->disconnect();

				$count_input = 0;
				$sql_input = "";
			}
			else
			{
				$sql_input = $sql_input . ", (\"" . $jobid . "\", \"" . $arr[0] . "\", \"" . $arr[1] . "\", \"" . $arr[2] . "\", \"" . $arr[3] . "\", \"" . $arr[4] . "\", \"" . $arr[5] . "\", \"" . $arr[6] . "\", \"" . $arr[7] . "\", \"" . $arr[8] . "\")";

				$count_input++;
			}
		}

		if($sql_input ne "")
		{
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
			   	or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare( $sql_input . ";");
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();
		}

		close LIMMA;
	}

	my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
	           or die "Can't connect: " . DBI->errstr();

	my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, Status = 1, FinishTime = now() where JOBID = '" . $jobid . "';");
	$stm->bind_param(1, $image, DBI::SQL_BLOB);
	$stm->execute();
	$stm->finish();
	$dbh1->disconnect();

	system("rm -rf limma.csv");
	system("rm -rf image.jpg");
}



# software: nomogram   ------ start -------
if($software eq "nomogram") {

	if($analysis eq 'wang')
	{
		my @arr = split /\|/, $parameters;	
		# --------------------------------  run program  --------------------------------------
		system("Rscript Wang.R \"" . $arr[0] . "\" \"" . $arr[1] . "\" \"" . $arr[2] . "\" " . $arr[3] . " " . $arr[4] . " " . $arr[5] . " " . $arr[6] . " " . $arr[7] . " " . $arr[8] . " \"" . $path . "/results/resultImage" . $jobid . ".jpg" . "\" \"" . $path . "/results/resultTable" . $jobid . ".csv\"");

		my $resultImage;
		my $resultTable;

		#test number
		my $testnumber = 0;
		#test 5 times
		while((! -e $path . "/results/resultTable" . $jobid . ".csv") && $testnumber < 5)
		{
			sleep 3;
			$testnumber++;
		}

		if ($testnumber == 5) {
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
		           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set Status = 3, FinishTime = now() where JOBID = '" . $jobid . "';");
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();
		} else {
			# read HEATMAP
			open RESULTIMAGE, $path . "/results/resultImage" . $jobid . ".jpg";
			#assume is a jpeg...
			my $buff;
			while(read RESULTIMAGE, $buff, 1024) {
					$resultImage .= $buff;
			}
			close RESULTIMAGE;

			# read RANK
			open RESULTTABLE, $path . "/results/resultTable" . $jobid . ".csv";
			#assume is a jpeg...
			my $buff1;
			while(read RESULTTABLE, $buff1, 1024) {
					$resultTable .= $buff1;
			}
			close RESULTTABLE;

			# update database with result

			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
			           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultTable = ?, Status = 2, FinishTime = now() where JOBID = ?;");
			$stm->bind_param(1, $resultImage, DBI::SQL_BLOB);
			$stm->bind_param(2, $resultTable, DBI::SQL_BLOB);
			$stm->bind_param(3, $jobid);
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();	
		}

		# remove temporary file   	
		system("rm -f " . $path . "/results/resultImage" . $jobid . ".jpg");
		system("rm -f " . $path . "/results/resultTable" . $jobid . ".csv");

	}


	if($analysis eq 'hoang')
	{
		my @arr = split /\|/, $parameters;	
		# --------------------------------  run program  --------------------------------------
		system("Rscript Hoang.R \"" . $arr[0] . "\" " . $arr[1] . " " . $arr[2] . " \"" . $arr[3] . "\" " . $arr[4] . " " . $arr[5] . " \"" . $path . "/results/resultImage" . $jobid . ".jpg" . "\" \"" . $path . "/results/resultTable" . $jobid . ".csv\"");

		my $resultImage;
		my $resultTable;

		#test number
		my $testnumber = 0;
		#test 5 times
		while((! -e $path . "/results/resultTable" . $jobid . ".csv") && $testnumber < 5)
		{
			sleep 3;
			$testnumber++;
		}

		if ($testnumber == 5) {
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
		           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set Status = 3, FinishTime = now() where JOBID = '" . $jobid . "';");
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();
		} else {
			# read HEATMAP
			open RESULTIMAGE, $path . "/results/resultImage" . $jobid . ".jpg";
			#assume is a jpeg...
			my $buff;
			while(read RESULTIMAGE, $buff, 1024) {
					$resultImage .= $buff;
			}
			close RESULTIMAGE;

			# read RANK
			open RESULTTABLE, $path . "/results/resultTable" . $jobid . ".csv";
			#assume is a jpeg...
			my $buff1;
			while(read RESULTTABLE, $buff1, 1024) {
					$resultTable .= $buff1;
			}
			close RESULTTABLE;

			# update database with result

			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
			           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultTable = ?, Status = 2, FinishTime = now() where JOBID = ?;");
			$stm->bind_param(1, $resultImage, DBI::SQL_BLOB);
			$stm->bind_param(2, $resultTable, DBI::SQL_BLOB);
			$stm->bind_param(3, $jobid);
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();	
		}

		# remove temporary file   	
		system("rm -f " . $path . "/results/resultImage" . $jobid . ".jpg");
		system("rm -f " . $path . "/results/resultTable" . $jobid . ".csv");

	}

	if($analysis eq 'paesmans')
	{
		my @arr = split /\|/, $parameters;	
		# --------------------------------  run program  --------------------------------------
		system("Rscript Paesmans.R \"" . $arr[0] . "\" \"" . $arr[1] . "\" " . $arr[2] . " \"" . $arr[3] . "\" \"" . $arr[4] . "\" " . $arr[5] . " \"" . $path . "/results/resultImage" . $jobid . ".jpg\" \"" . $path . "/results/resultTable" . $jobid . ".csv\" \"" . $path . "/results/resultFile" . $jobid . ".jpg\" \"" . $path . "/results/resultPlot" . $jobid . ".csv\"");

		my $resultImage;
		my $resultTable;
		my $resultFile;
		my $resultPlot;

		#test number
		my $testnumber = 0;
		#test 5 times
		while((! -e $path . "/results/resultTable" . $jobid . ".csv") && $testnumber < 5)
		{
			sleep 3;
			$testnumber++;
		}

		if ($testnumber == 5) {
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
		           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set Status = 3, FinishTime = now() where JOBID = '" . $jobid . "';");
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();
		} else {
			# read resultImage
			open RESULTIMAGE, $path . "/results/resultImage" . $jobid . ".jpg";
			#assume is a jpeg...
			my $buff;
			while(read RESULTIMAGE, $buff, 1024) {
					$resultImage .= $buff;
			}
			close RESULTIMAGE;

			# read resultTable
			open RESULTTABLE, $path . "/results/resultTable" . $jobid . ".csv";
			#assume is a jpeg...
			my $buff1;
			while(read RESULTTABLE, $buff1, 1024) {
					$resultTable .= $buff1;
			}
			close RESULTTABLE;

			# read resultFile
			open RESULTFILE, $path . "/results/resultFile" . $jobid . ".jpg";
			#assume is a jpeg...
			my $buff2;
			while(read RESULTFILE, $buff2, 1024) {
					$resultFile .= $buff2;
			}
			close RESULTFILE;

			# read resultPlot
			open RESULTPLOT, $path . "/results/resultPlot" . $jobid . ".csv";
			#assume is a jpeg...
			my $buff3;
			while(read RESULTPLOT, $buff3, 1024) {
					$resultPlot .= $buff3;
			}
			close RESULTPLOT;


			# update database with result
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
			           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultTable = ?, ResultFile = ?, ResultPlot = ?, Status = 2, FinishTime = now() where JOBID = ?;");
			$stm->bind_param(1, $resultImage, DBI::SQL_BLOB);
			$stm->bind_param(2, $resultTable, DBI::SQL_BLOB);
			$stm->bind_param(3, $resultFile, DBI::SQL_BLOB);
			$stm->bind_param(4, $resultPlot, DBI::SQL_BLOB);
			$stm->bind_param(5, $jobid);
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();	
		}

		# remove temporary file   	
		system("rm -f " . $path . "/results/resultImage" . $jobid . ".jpg");
		system("rm -f " . $path . "/results/resultTable" . $jobid . ".csv");
		system("rm -f " . $path . "/results/resultFile" . $jobid . ".jpg");
		system("rm -f " . $path . "/results/resultPlot" . $jobid . ".csv");

	}

	if($analysis eq 'albain')
	{
		my @arr = split /\|/, $parameters;	
		# --------------------------------  run program  --------------------------------------
		system("Rscript Albain.R \"" . $arr[0] . "\" \"" . $arr[1] . "\" " . $arr[2] . " " . $arr[3] . " \"" . $path . "/results/resultImage" . $jobid . ".jpg\" \"" . $path . "/results/resultTable" . $jobid . ".csv\"");

		my $resultImage;
		my $resultTable;

		#test number
		my $testnumber = 0;
		#test 5 times
		while((! -e $path . "/results/resultTable" . $jobid . ".csv") && $testnumber < 5)
		{
			sleep 3;
			$testnumber++;
		}

		if ($testnumber == 5) {
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
		           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set Status = 3, FinishTime = now() where JOBID = '" . $jobid . "';");
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();
		} else {

			# read resultImage
			open RESULTIMAGE, $path . "/results/resultImage" . $jobid . ".jpg";
			#assume is a jpeg...
			my $buff;
			while(read RESULTIMAGE, $buff, 1024) {
					$resultImage .= $buff;
			}
			close RESULTIMAGE;
			
			# read resultTable
			open RESULTTABLE, $path . "/results/resultTable" . $jobid . ".csv";
			#assume is a jpeg...
			my $buff1;
			while(read RESULTTABLE, $buff1, 1024) {
					$resultTable .= $buff1;
			}
			close RESULTTABLE;

			# update database with result
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
			           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultTable = ?, Status = 2, FinishTime = now() where JOBID = ?;");
			$stm->bind_param(1, $resultImage, DBI::SQL_BLOB);
			$stm->bind_param(2, $resultTable, DBI::SQL_BLOB);
			$stm->bind_param(3, $jobid);
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();	
		}

		# remove temporary file   	
		system("rm -f " . $path . "/results/resultImage" . $jobid . ".jpg");
		system("rm -f " . $path . "/results/resultTable" . $jobid . ".csv");
	}


	if($analysis eq 'finkelstein')
	{
		my @arr = split /\|/, $parameters;	
		# --------------------------------  run program  --------------------------------------
		system("Rscript Finkelstein.R \"" 
			. $arr[0] . "\" \"" 
			. $arr[1] . "\" \"" 
			. $arr[2] . "\" " 
			. $arr[3] . " " 
			. $arr[4] . " " 
			. $arr[5] . " " 
			. $arr[6] . " \"" 
			. $arr[7] . "\" \"" 
			. $path . "/results/resultImage" . $jobid . ".jpg\" \"" 
			. $path . "/results/resultPlot" . $jobid . ".txt\"");

		my $resultImage;
		my $resultPlot;

		#test number
		my $testnumber = 0;
		#test 5 times
		while((! -e $path . "/results/resultPlot" . $jobid . ".txt") && $testnumber < 5)
		{
			sleep 3;
			$testnumber++;
		}

		if ($testnumber == 5) {
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
		           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set Status = 3, FinishTime = now() where JOBID = '" . $jobid . "';");
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();
		} else {

			# read resultFile
			open RESULTIMAGE, $path . "/results/resultImage" . $jobid . ".jpg";
			#assume is a jpeg...
			my $buff;
			while(read RESULTIMAGE, $buff, 1024) {
					$resultImage .= $buff;
			}
			close RESULTIMAGE;
			
			# read resultPlot
			open RESULTPLOT, $path . "/results/resultPlot" . $jobid . ".txt";
	  		my $resultPlot = <RESULTPLOT>;
			close RESULTPLOT;

			# update database with result
			my $dbh1 = DBI->connect('DBI:mysql:RemoteR;host=' . $db_host, $db_username, $db_password)
			           or die "Can't connect: " . DBI->errstr();

			my $stm = $dbh1->prepare("update RemoteR.Jobs set ResultImage = ?, ResultPlot = ?, Status = 2, FinishTime = now() where JOBID = ?;");
			$stm->bind_param(1, $resultImage, DBI::SQL_BLOB);
			$stm->bind_param(2, $resultPlot);
			$stm->bind_param(3, $jobid);
			$stm->execute();
			$stm->finish();
			$dbh1->disconnect();	
		}

		# remove temporary file   	
		system("rm -f " . $path . "/results/resultImage" . $jobid . ".jpg");
		system("rm -f " . $path . "/results/resultPlot" . $jobid . ".txt");
	}

}

# software: nomogram   ------ end -------







# Perl trim function to remove whitespace from the start and end of the string
sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

# Create the sql query condition for survival analysis
sub createsaparams
{
	my($parameters);
	($parameters) = @_;

	if($parameters eq "")
	{
		return "";
	}

	my @arr = split /\|/, $parameters;

	# check legal parameters - first check
	if($#arr != 3 || $arr[0] !~ /^\d+$/ || $arr[1] !~ /^\d+$/)
	{
		return "";
	}
	# end check legal parameters

	# check the third parameter - second check
	my @arr1 = split /:/, $arr[2];
	if($#arr1 != 1)
	{
		return "";
	}
	my $condition = "";

	if($arr1[0] eq "all")
	{
		$condition = "1=1";
	}
	elsif($arr1[0] eq "age")
	{
		my @arr2 = split /-/, $arr1[1];
		if($arr2[0] !~ /^\d+$/ || $arr2[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition = "A.Pat_Age > " . $arr2[0] . " and A.Pat_Age < " . $arr2[1];
		}
	}
	elsif($arr1[0] eq "gender")
	{
		if($arr1[1] ne "M" && $arr1[1] ne "F")
		{
			return "";
		}
		else
		{
			$condition = "A.Pat_Gender='" . $arr1[1] . "'";
		}
	}
	elsif($arr1[0] eq "race")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition = "A.Pat_Race=" . $arr1[1];
		}
	}
	elsif($arr1[0] eq "smoke")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition = "A.Pat_Smoking_Status=" . $arr1[1];
		}
	}
	elsif($arr1[0] eq "histology")
	{
		if($arr1[1] eq "others")
		{
			$condition = "A.Pat_Histology != 2120 and A.Pat_Histology != 2110";
		}
		elsif($arr1[1] =~ /^\d+$/)
		{
			$condition = "A.Pat_Histology=" . $arr1[1];
		}
		else
		{
			return "";
		}
	}
	else
	{
		return "";
	}
	# end check the third parameter

	# check the fourth parameter - third check
	if($arr[3] ne "median" && $arr[3] ne "mean" && $arr[3] ne "cluster" && $arr[3] !~ /^-?\d+\.?\d*$/)
	{
		return "";
	}
	# end check the fourth parameter

	if($condition eq "")
	{
		return "";
	}
	else
	{
		return $arr[0] . "|" . $arr[1] . "|" . $condition . "|" . $arr[3];
	}
}

# Create the sql query condition for correlation analysis
sub createcoeaparams
{
	my($parameters);
	($parameters) = @_;

	if($parameters eq "")
	{
		return "";
	}

	my @arr = split /\s/, $parameters;

	# check legal parameters - first check
	if($#arr != 2 || $arr[2] !~ /^\d+$/)
	{
		return "";
	}
	# end check legal parameters

	# check first parameter - second check
	if (index($arr[0], ";") != -1)
	{
    		return "";
	}
	# end check first parameter

	# check second parameter - third check
	my @arr1 = split /,/, $arr[1];

	foreach(my $i = 0; $i<=$#arr1; $i++)
	{
		if($arr1[$i] !~ /^\d+$/)
		{
			return "";
		}
	}
	# end check second parameter

	return $arr[0] . " " . $arr[1] . " " . $arr[2]; 
}


# Create the sql query condition for comparative analysis
sub createcomaparams
{
	my($parameters);
	($parameters) = @_;

	if($parameters eq "")
	{
		return "";
	}

	my @arr = split /\|/, $parameters;

	# check legal parameters - first check
	if($#arr != 4 || $arr[0] !~ /^\d+$/ || $arr[1] !~ /^\d+$/ || $arr[3] !~ /^\d+$/)
	{
		return "";
	}
	# end check legal parameters

	# check the third parameter - second check
	my @arr1 = split /:/, $arr[2];
	if($#arr1 != 1)
	{
		return "";
	}
	my $condition1 = "";

	if($arr1[0] eq "all")
	{
		$condition1 = "1=1";
	}
	elsif($arr1[0] eq "age")
	{
		my @arr2 = split /-/, $arr1[1];
		if($arr2[0] !~ /^\d+$/ || $arr2[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition1 = "Pat_Age > " . $arr2[0] . " and Pat_Age < " . $arr2[1];
		}
	}
	elsif($arr1[0] eq "gender")
	{
		if($arr1[1] ne "M" && $arr1[1] ne "F")
		{
			return "";
		}
		else
		{
			$condition1 = "Pat_Gender='" . $arr1[1] . "'";
		}
	}
	elsif($arr1[0] eq "race")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition1 = "Pat_Race=" . $arr1[1];
		}
	}
	elsif($arr1[0] eq "smoke")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition1 = "Pat_Smoking_Status=" . $arr1[1];
		}
	}
	elsif($arr1[0] eq "histology")
	{
		if($arr1[1] eq "others")
		{
			$condition1 = "Pat_Histology != 2120 and Pat_Histology != 2110";
		}
		elsif($arr1[1] =~ /^\d+$/)
		{
			$condition1 = "Pat_Histology=" . $arr1[1];
		}
		else
		{
			return "";
		}
	}
	else
	{
		return "";
	}
	# end check the third parameter

	# check the fifth parameter - third check
	@arr1 = split /:/, $arr[4];
	if($#arr1 != 1)
	{
		return "";
	}
	my $condition2 = "";

	if($arr1[0] eq "all")
	{
		$condition2 = "1=1";
	}
	elsif($arr1[0] eq "age")
	{
		my @arr2 = split /-/, $arr1[1];
		if($arr2[0] !~ /^\d+$/ || $arr2[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition2 = "Pat_Age > " . $arr2[0] . " and Pat_Age < " . $arr2[1];
		}
	}
	elsif($arr1[0] eq "gender")
	{
		if($arr1[1] ne "M" && $arr1[1] ne "F")
		{
			return "";
		}
		else
		{
			$condition2 = "Pat_Gender='" . $arr1[1] . "'";
		}
	}
	elsif($arr1[0] eq "race")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition2 = "Pat_Race=" . $arr1[1];
		}
	}
	elsif($arr1[0] eq "smoke")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition2 = "Pat_Smoking_Status=" . $arr1[1];
		}
	}
	elsif($arr1[0] eq "histology")
	{
		if($arr1[1] eq "others")
		{
			$condition2 = "Pat_Histology != 2120 and Pat_Histology != 2110";
		}
		elsif($arr1[1] =~ /^\d+$/)
		{
			$condition2 = "Pat_Histology=" . $arr1[1];
		}
		else
		{
			return "";
		}
	}
	else
	{
		return "";
	}
	# end check the fifth parameter

	if($condition1 eq "" || $condition2 eq "")
	{
		return "";
	}
	else
	{
		return $arr[0] . "|" . $arr[1] . "|" . $condition1 . "|" . $arr[3] . "|" . $condition2 ;
	}
}


# Create the sql query condition for correlation analysis
sub createiaparams
{
	my($parameters);
	($parameters) = @_;

	if($parameters eq "")
	{
		return "";
	}

	my @arr = split /\|/, $parameters;

	# check legal parameters - first check
	if($#arr != 1 || $arr[0] !~ /^\d+$/ || $arr[1] !~ /^\d+$/)
	{
		return "";
	}
	# end check
	
	return $arr[0] . "|" . $arr[1];
}

# Create the sql query condition for correlation analysis
sub creategaparams
{
	my($parameters);
	($parameters) = @_;

	if($parameters eq "")
	{
		return "";
	}

	my @arr = split /\|/, $parameters;

	# check legal parameters - first check
	if($#arr != 2 || $arr[0] !~ /^\d+$/)
	{
		return "";
	}
	# end check legal parameters 

	# check second parameters - second check
	my @arr1 = split /:/, $arr[1];
	if($#arr1 != 1)
	{
		return "";
	}
	my $condition1 = "";

	if($arr1[0] eq "tissue")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition1 =  "Sam_Dataset='" . $arr[0] . "' and Sam_Tissue='" . $arr1[1] . "'";
		}
	}
	elsif($arr1[0] eq "age")
	{
		my @arr2 = split /-/, $arr1[1];
		if($arr2[0] !~ /^\d+$/ || $arr2[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition1 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Age > " . $arr2[0] . " and Pat_Age < " . $arr2[1] . ")";
		}
	}
	elsif($arr1[0] eq "gender")
	{
		if($arr1[1] ne "M" && $arr1[1] ne "F")
		{
			return "";
		}
		else
		{
			$condition1 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Gender='" . $arr1[1] . "')";
		}
	}
	elsif($arr1[0] eq "race")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition1 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Race=" . $arr1[1] . ")";
		}
	}
	elsif($arr1[0] eq "smoke")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition1 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Smoking_Status=" . $arr1[1] . ")";
		}
	}
	elsif($arr1[0] eq "histology")
	{
		if($arr1[1] eq "others")
		{
			$condition1 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Histology != 2120 and Pat_Histology != 2110)";
		}
		elsif($arr1[1] =~ /^\d+$/)
		{
			$condition1 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Histology=" . $arr1[1] . ")";
		}
		else
		{
			return "";
		}
	}
	else
	{
		return "";
	}

	# end check second parameter

	# check third parameters - second check
	@arr1 = split /:/, $arr[2];
	if($#arr1 != 1)
	{
		return "";
	}
	my $condition2 = "";

	if($arr1[0] eq "tissue")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition2 =  "Sam_Dataset='" . $arr[0] . "' and Sam_Tissue='" . $arr1[1] . "'";
		}
	}
	elsif($arr1[0] eq "age")
	{
		my @arr2 = split /-/, $arr1[1];
		if($arr2[0] !~ /^\d+$/ || $arr2[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition2 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Age > " . $arr2[0] . " and Pat_Age < " . $arr2[1] . ")";
		}
	}
	elsif($arr1[0] eq "gender")
	{
		if($arr1[1] ne "M" && $arr1[1] ne "F")
		{
			return "";
		}
		else
		{
			$condition2 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Gender='" . $arr1[1] . "')";
		}
	}
	elsif($arr1[0] eq "race")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition2 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Race=" . $arr1[1] . ")";
		}
	}
	elsif($arr1[0] eq "smoke")
	{
		if($arr1[1] !~ /^\d+$/)
		{
			return "";
		}
		else
		{
			$condition2 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Smoking_Status=" . $arr1[1] . ")";
		}
	}
	elsif($arr1[0] eq "histology")
	{
		if($arr1[1] eq "others")
		{
			$condition2 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Histology != 2120 and Pat_Histology != 2110)";
		}
		elsif($arr1[1] =~ /^\d+$/)
		{
			$condition2 = "Sam_Dataset='" . $arr[0] . "' and Sam_Patient in (select Pat_ID from Patients where Pat_Histology=" . $arr1[1] . ")";
		}
		else
		{
			return "";
		}
	}
	else
	{
		return "";
	}

	# end check third parameter


	if($condition1 eq "" || $condition2 eq "")
	{
		return "";
	}
	else
	{
		return $arr[0] . "|"  . $condition1 . "|" . $condition2 . "|1";
	}
}
