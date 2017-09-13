#! /usr/bin/perl -w
use DBI;
use DBI qw(:sql_types);
#unshift (@INC, "$ENV{'PWD'}/joblppz");
do 'mysqlconn.pl';

sub saveLogSpark
{
 my $dbh = create_conn();
 my $sth = $dbh->prepare(qq{insert into joblog(params,source_type,source_id) values(?,?,?)});
 my $params=$ARGV[0];
 my $source_type=$ARGV[1];
 my $source_id=$ARGV[2];
 my $rows = $sth->execute($params, $source_type,$source_id);
   print "$rows"." inserted: $params, $source_type, $source_id";
  $sth->finish;
 $dbh->disconnect;
}

sub main 
{
 saveLogSpark();
}
exit( main );
