#! /usr/bin/perl -w
unshift (@INC, "$ENV{'PWD'}/pl");
require ("monitor.pl");
sub main 
{
 clearSystem();
}
exit( main );
