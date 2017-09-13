#! /usr/bin/perl -w
use DBI;
use DBI qw(:sql_types);
#unshift (@INC, "$ENV{'PWD'}/joblppz");
do 'mysqlconn.pl';

sub saveLogMax
{
 my $dbh = create_conn();
 my $sth = $dbh->prepare(qq{insert into joblog(log_dir,params,source_type,starttime,endtime,source_id) values(?,?,?,?,?,?)});
 my $log_dir=$ARGV[0];
 my $params=$ARGV[1];
 my $source_type=$ARGV[2];
 my $starttime=$ARGV[3];
 my $endtime=$ARGV[4];
 my $source_id=$ARGV[5];
 my $rows = $sth->execute($log_dir,$params,$source_type,$starttime,$endtime,$source_id);
   print "$rows"." inserted: $log_dir,$params,$source_type,$starttime,$endtime,$source_id";
  $sth->finish;
 $dbh->disconnect;
}

sub main 
{
 saveLogMax();
}
exit( main );
