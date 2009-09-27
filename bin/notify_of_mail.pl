#!/usr/bin/perl

use strict;
use warnings;

use Mac::Growl ':all';
use Mail::Header;

my $prefix = shift || '';

my $app    = "Mail";
my $as_app = 'Mail.app';
my @names  = ('Incoming Mail');

RegisterNotifications($app, \@names, [$names[0]], $as_app);

my $head = Mail::Header->new( \*STDIN );
my $from = $head->get( 'From' ); 
my $subject = $head->get('Subject');
chomp $from;
chomp $subject;

if ( $prefix ne "[dns-ops] " ) { 
    PostNotification($app, $names[0], $from, $prefix . ' ' .  $subject);
}
