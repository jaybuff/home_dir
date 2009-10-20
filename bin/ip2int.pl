#!/usr/bin/perl

# Turn an IP into an integer for use with mysql server IDs (or whatever)

$ip = shift @ARGV or die "usage: $0 <ip>\n";
$exp = 3;
map { $x += $_ * (2 ** (8 * $exp--)) } split(/\./, $ip);
print $x

