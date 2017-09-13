#! /usr/bin/perl -w
#use strict;
use DBI;
use DBI qw(:sql_types);
#unshift (@INC, "$ENV{'PWD'}/joblppz");
do 'mysqlconn.pl';

sub getSubJobLock 
{
 my ($id, $is_lock);
 my $result;
 my $dbh = create_conn();
 my $sth = $dbh->prepare(qq{select id, is_lock from job_lock});
 $sth->execute();
 $sth->bind_col(1, \$id);
 $sth->bind_col(2, \$is_lock);
 while ($sth->fetch())
 {
   my $uth = $dbh->prepare(qq{update job_lock set is_lock=? where id = ? and is_lock=0});
   $result = $uth->execute(1, $id);
   if($result == 1){
   	$uth->finish;
   	$sth->finish();
 	$dbh->disconnect;
 	return($result,$id)
   }
  $uth->finish;
 }
 $sth->finish();
 $dbh->disconnect;
 return (0,$id)
}

sub getJobLock 
{  
  my ($result,$id);
  my $boo=0;
  while($boo==0){
  	  ($result,$id)=getSubJobLock();
  	  print "can't get lock wait 5 seconds...\n";
  	  if($result==1){
  	  	last;
  	  }
  	  sleep(5);
  }
  print "get lock...lock id is:$id\n";
  return $id;
}

sub main 
{
 my $id=getJobLock();
 return $id
}
exit( main );
