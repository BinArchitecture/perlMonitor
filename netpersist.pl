#! /usr/bin/perl -w
unshift (@INC, "$ENV{'PWD'}/pl");
require ("monitor.pl");
sub main 
{
 persistnet();
}
exit( main );
