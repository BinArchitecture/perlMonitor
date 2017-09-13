#! /usr/bin/perl -w
use DBI;
use DBI qw(:sql_types);
#unshift (@INC, "$ENV{'PWD'}/joblppz");
do 'mysqlconn.pl';

sub releaseJobLock
{  
  my $id=$ARGV[0];
  my $dbh = create_conn();
  my $uth = $dbh->prepare(qq{update job_lock set is_lock=0 where id = ?});
   $result = $uth->execute($id);
   if($result == 1){
   	$uth->finish;
 	$dbh->disconnect;
 	print "release lock success...id is:$id\n";
 	return($result)
   }
}

sub main 
{
 releaseJobLock();
}
exit( main );
