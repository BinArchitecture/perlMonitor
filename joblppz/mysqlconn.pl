#! /usr/bin/perl -w
use strict;
use DBI;
use DBI qw(:sql_types);
sub create_conn    
{
 my $dsn = "DBI:mysql:joblppz:192.168.37.246:3306";
 my $user = "root";
 my $pass = "KTqHDMg8r3q1w";
 my $dbh = DBI->connect($dsn, $user, $pass, {RaiseError=>0, PrintError => 1})
  or die "Could not connect to mysql server: $DBI::err($DBI::errstr)\n";
 return $dbh;
}
1
