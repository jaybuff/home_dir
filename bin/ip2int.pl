#!/usr/bin/perl
# Turn an IP into an integer for use with mysql server IDs (or whatever)

$exp = 3;
map { $x += $_ * (2 ** (8 * $exp--)) } split(/\./, $ARGV[1]);
print $x

