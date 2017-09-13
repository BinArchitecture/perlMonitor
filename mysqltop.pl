#! /usr/bin/perl -w
unshift (@INC, "$ENV{'PWD'}/pl");
require ("monitor.pl");
sub main 
{
 open_rc_order();
}
exit( main );
