#! /usr/bin/perl -w
use strict;
use DBI;
use DBI qw(:sql_types);
unshift (@INC, "$ENV{'PWD'}/pl");
do 'mysqlconn.pl';
sub persistmem
{
 my $db = create_conn();
    my $csr = $db->prepare(q{
            CALL MONITOR.RECORD_MEM(?,?,?,?,?,?,?,?,?,?,?,?,?);
      });
my $memtotal=$ARGV[0];
my $memused=$ARGV[1];
my $memfree=$ARGV[2];
my $membuffers=$ARGV[3];
my $memcached=$ARGV[4];
my $memshared=$ARGV[5];
my $swaptotal=$ARGV[6];
my $swapused=$ARGV[7];
my $swapfree=$ARGV[8];
my $datet=$ARGV[9];
my $timestep=$ARGV[10];
my $hostname=$ARGV[11];
my $ipaddr=$ARGV[12];
      $csr->bind_param(1, $memtotal,SQL_VARCHAR);
      $csr->bind_param(2, $memused,SQL_VARCHAR);
      $csr->bind_param(3, $memfree,SQL_VARCHAR);
      $csr->bind_param(4, $membuffers,SQL_VARCHAR);
      $csr->bind_param(5, $memcached,SQL_VARCHAR);
      $csr->bind_param(6, $memshared,SQL_VARCHAR);
      $csr->bind_param(7, $swaptotal,SQL_VARCHAR);
      $csr->bind_param(8, $swapused,SQL_VARCHAR);
      $csr->bind_param(9, $swapfree,SQL_VARCHAR);
      $csr->bind_param(10, $datet,SQL_VARCHAR);
      $csr->bind_param(11, $timestep,SQL_VARCHAR);
      $csr->bind_param(12, $hostname,SQL_VARCHAR);
      $csr->bind_param(13, $ipaddr,SQL_VARCHAR);

      eval {
        $csr->execute;
        $csr->finish;
      };
 
 $db->disconnect;
}

sub persistcpu
{
 my $db = create_conn();
    my $csr = $db->prepare(q{
            CALL MONITOR.RECORD_CPU(?,?,?,?,?,?,?,?,?,?,?,?);
      });
my $used=$ARGV[0];
my $sys=$ARGV[1];
my $nice=$ARGV[2];
my $iowait=$ARGV[3];
my $irq=$ARGV[4];
my $soft=$ARGV[5];
my $steal=$ARGV[6];
my $guest=$ARGV[7];
my $idle=$ARGV[8];
my $datet=$ARGV[9];
my $hostname=$ARGV[10];
my $ipaddr=$ARGV[11];
      $csr->bind_param(1, $used,SQL_VARCHAR);
      $csr->bind_param(2, $sys,SQL_VARCHAR);
      $csr->bind_param(3, $nice,SQL_VARCHAR);
      $csr->bind_param(4, $iowait,SQL_VARCHAR);
      $csr->bind_param(5, $irq,SQL_VARCHAR);
      $csr->bind_param(6, $soft,SQL_VARCHAR);
      $csr->bind_param(7, $steal,SQL_VARCHAR);
      $csr->bind_param(8, $guest,SQL_VARCHAR);
      $csr->bind_param(9, $idle,SQL_VARCHAR);
      $csr->bind_param(10, $datet,SQL_VARCHAR);
      $csr->bind_param(11, $hostname,SQL_VARCHAR);
      $csr->bind_param(12, $ipaddr,SQL_VARCHAR);

      eval {
        $csr->execute;
        $csr->finish;
      };
 
 $db->disconnect;
}

sub persistio
{
 my $db = create_conn();
    my $csr = $db->prepare(q{
            CALL MONITOR.RECORD_IO(?,?,?,?,?,?,?,?,?,?);
      });
my $dev=$ARGV[0];
my $tps=$ARGV[1];
my $kbrp=$ARGV[2];
my $kbwp=$ARGV[3];
my $kbr=$ARGV[4];
my $kbw=$ARGV[5];
my $datet=$ARGV[6];
my $timestep=$ARGV[7];
my $hostname=$ARGV[8];
my $ipaddr=$ARGV[9];
      $csr->bind_param(1, $dev,SQL_VARCHAR);
      $csr->bind_param(2, $tps,SQL_VARCHAR);
      $csr->bind_param(3, $kbrp,SQL_VARCHAR);
      $csr->bind_param(4, $kbwp,SQL_VARCHAR);
      $csr->bind_param(5, $kbr,SQL_VARCHAR);
      $csr->bind_param(6, $kbw,SQL_VARCHAR);
      $csr->bind_param(7, $datet,SQL_VARCHAR);
      $csr->bind_param(8, $timestep,SQL_VARCHAR);
      $csr->bind_param(9, $hostname,SQL_VARCHAR);
      $csr->bind_param(10, $ipaddr,SQL_VARCHAR);

      eval {
        $csr->execute;
        $csr->finish;
      };
 
 $db->disconnect;
}

sub persistnet
{
 my $db = create_conn();
    my $csr = $db->prepare(q{
            CALL MONITOR.RECORD_NET(?,?,?,?,?,?,?,?,?,?,?);
      });
my $iface=$ARGV[0];
my $rxpckps=$ARGV[1];
my $txpckps=$ARGV[2];
my $rxbytps=$ARGV[3];
my $txbytps=$ARGV[4];
my $rxcmpps=$ARGV[5];
my $datet=$ARGV[6];
my $txcmpps=$ARGV[7];
my $rxmcstps=$ARGV[8];
my $hostname=$ARGV[9];
my $ipaddr=$ARGV[10];
      $csr->bind_param(1, $iface,SQL_VARCHAR);
      $csr->bind_param(2, $rxpckps,SQL_VARCHAR);
      $csr->bind_param(3, $txpckps,SQL_VARCHAR);
      $csr->bind_param(4, $rxbytps,SQL_VARCHAR);
      $csr->bind_param(5, $txbytps,SQL_VARCHAR);
      $csr->bind_param(6, $rxcmpps,SQL_VARCHAR);
      $csr->bind_param(7, $datet,SQL_VARCHAR);
      $csr->bind_param(8, $txcmpps,SQL_VARCHAR);
      $csr->bind_param(9, $rxmcstps,SQL_VARCHAR);
      $csr->bind_param(10, $hostname,SQL_VARCHAR);
      $csr->bind_param(11, $ipaddr,SQL_VARCHAR);

      eval {
        $csr->execute;
        $csr->finish;
      };
 
 $db->disconnect;
}

sub clearSystem
{
 my $db = create_conn();
    my $csr = $db->do(q{
            CALL MONITOR.clearSystem();
      });
 $db->disconnect;
}

sub open_rc_order
{
 my $db = create_conn();
       my $csr = $db->prepare(q{
            CALL MONITOR.EMORDER(?);
      });
       my $emorder=$ARGV[0];
  $csr->bind_param(1, $emorder,SQL_INTEGER);
   eval {
        $csr->execute;
        $csr->finish;
      };
 $db->disconnect;
}

sub kill_rc_order
{
 my $db = create_conn();
    my $csr = $db->do(q{
            CALL MONITOR.EMORDERKILL();
      });
 $db->disconnect;
}

