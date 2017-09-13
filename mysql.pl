#! /usr/bin/perl -w
#use strict;
use DBI;
use DBI qw(:sql_types);
#unshift (@INC, "$ENV{'PWD'}/pl");
#do 'mysqlconn.pl';

sub create_conn    
{
 my $dsn = "DBI:mysql:joblppz:192.168.37.246:3306";
 my $user = "root";
 my $pass = "KTqHDMg8r3q1w";
 my $dbh = DBI->connect($dsn, $user, $pass, {RaiseError=>0, PrintError => 1})
  or die "Could not connect to mysql server: $DBI::err($DBI::errstr)\n";
 return $dbh;
}

sub fetch_and_print_results  # params: stmt handle
{
 my $sth = shift(@_);
 while (my @row = $sth->fetchrow_array())
 {
  print join("\t", @row), "\n";
 }
}
sub fetch_and_print_results2  # params: stmt handle
{
 my $sth = shift(@_);
 while (my $rowref = $sth->fetchrow_arrayref())
 {
  my $delim = "";
  for( my $i = 0; $i < @{$rowref}; ++$i)
  {
   #$rowref->{$i} = " " if !defined ($rowref->{$i}); # NULL to space
   print $delim . @{$rowref}[$i];
   $delim = ',';
  }
  print "\n";
 }
}

sub fetch_and_print_results3  # params: stmt handle
{
 my $sth = shift(@_);
 my $labels = $sth->{NAME};
 my $cols = $sth->{NUM_OF_FIELDS};
  
 print ">>>> field count $cols\n";
 while (my $rowref = $sth->fetchrow_hashref() )
 {
  my $delim = "";
  for( my $i = 0; $i < $cols; ++$i)
  {
   print $delim . $labels->[$i]. ' = '.%{$rowref}->{$labels->[$i]};
   $delim = ',';
  }
  print "\n";
 }
}

sub test_clear_table
{
 my $dbh = create_conn;
 my $rows = $dbh->do(qq/delete from member/);  
 print ">>>> total $rows records deleted\n";
 $dbh->disconnect;
}

sub test_insert_and_select
{
 my $db = create_conn;
    my $csr = $db->prepare(q{
            BEGIN
                MONITOR.RECORD_MEM(:memtotal,:memused,:memfree,:membuffers,:memcached,:memshared,:swaptotal,:swapused,:swapfree);
              # MONITOR.RECORD_MEM("123","22","34","453","42","43","54","453","57");
            END;
      });
my $memtotal=123;
my $memused=123;
my $memfree=123;
my $membuffers=123;
my $memcached=123;
my $memshared=123;
my $swaptotal=123;
my $swapused=123;
my $swapfree=123;
      $csr->bind_param(':memtotal', $memtotal);
      $csr->bind_param(':memused', $memused);
      $csr->bind_param(':memfree', $memfree);
      $csr->bind_param(':membuffers', $membuffers);
      $csr->bind_param(':memcached', $memcached);
      $csr->bind_param(':memshared', $memshared);
      $csr->bind_param(':swaptotal', $swaptotal);
      $csr->bind_param(':swapused', $swapused);
      $csr->bind_param(':swapfree', $swapfree);

      eval {
        $csr->execute;
        $csr->finish;
      };
 
 $db->disconnect;
}

sub test_param_insert
{
 my $dbh = create_conn();
 my $sth = $dbh->prepare(qq{insert into member (username, password) values (?, ?)});
 my $rows = $sth->execute('maria', 'louise');
   print "$rows".' inserted: maria louise';
  $sth->finish;
  
 $dbh->do(qq/insert into member (username, password) values (?, ?)/, undef,
          'george', 'cardon');
  
 $dbh->disconnect;
}
sub test_select_out_param_bind 
{
 print ">>>>>>> test_select_param_bind\n";
 my ($starttime, $is_lock);
 my $dbh = create_conn;
 my $sth = $dbh->prepare(qq{select starttime, is_lock from job_lock});
 $sth->execute();
 $sth->bind_col(1, \$starttime);
 $sth->bind_col(2, \$is_lock);
 print(">>1 == $starttime, $is_lock\n") while $sth->fetch(); 
 $sth->finish();
  
# $sth = $dbh->prepare(qq{select username, password from member});
# $sth->execute();
# $sth->bind_columns(\$user, \$pass);
# print(">>2 == $user, $pass\n") while $sth->fetch(); 
# $sth->finish();
  
 $dbh->disconnect;
}
sub test_transaction
{
 print ">>>>>>> test_transaction\n";
 my $dbh = create_conn;
 $dbh->{AutoCommit} = 0;
 my $sth = $dbh->prepare(qq{insert into member (username, password) values (?,?)});
 $sth->execute('tom', 'jerry');
 $dbh->commit;
  
 $sth->execute('tom', 'tom');
 $dbh->rollback;
 $sth->finish;
  
 $dbh->disconnect;
}
sub main 
{
  test_select_out_param_bind
# test_clear_table;
# test_param_insert;
# test_insert_and_select;
# test_transaction;
}
exit( main );
