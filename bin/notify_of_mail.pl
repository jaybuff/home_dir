#!/usr/bin/perl

# this script is called via procmail (see my .procmailrc)
# only works on a mac with growl installed
# see http://www.growl.info/
# also need to do this to install: 
# sudo cpan -i Mac::Growl
# sudo cpan -i Mail::Header

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

# don't notify me of the dns-ops mailing list
if ( $prefix ne "[dns-ops] " ) { 
    PostNotification($app, $names[0], $from, $prefix . ' ' .  $subject);
}
