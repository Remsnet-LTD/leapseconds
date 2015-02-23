#!/usr/bin/perl -e '
#
# http://www.gossamer-threads.com/lists/qmail/users/138192
#
use strict;
use POSIX qw(&mktime);
use integer;
my @mon=qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
my %months=map(($mon[$_] => $_), 0..$#mon);
my $line;
my $leaps=10;
$|=1;
while (defined($line=<STDIN>)) {
if ($line=~/^Leap\t(\d+)\t(\w+)\t(\d+)\t(\d+):(\d+):(\d+)\t\+\tS\n\z/) {
my $t=(mktime($6-1, $5, $4, $3, $months{$2}, $1-1900)+
1+$leaps++);
my @bytes=();
while ($t!=0) { unshift(@bytes, $t%256); $t/=256; }
while (@bytes<7) { unshift(@bytes, 0); }
unshift(@bytes, 64);
print(map(chr($_), @bytes)) or die($!);
}
}
' < /var/qmail/bin/leapseconds > /var/qmail/control/leapsecs.dat

