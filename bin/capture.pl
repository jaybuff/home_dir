#!/usr/bin/perl 
use strict;
use warnings;

use DateTime;
use DateTime::Duration;
use File::Find;

# the days start at three am
my $three_hours = DateTime::Duration->new( hours => 3 );
my $start = DateTime->now( time_zone => 'America/Los-Angeles' ) - $three_hours;

my $stills_dir = '/Users/jaybuff/Documents/picomin/' . uc( $start->strftime( "%d%b%Y" ) );
# this is where we'll put the photos that we capture
if ( !-d $stills_dir ) { 
    mkdir $stills_dir, 0755;
}

# figure out what the next filename should be
my @files;
my $is_it_between = sub { 
    # file name is stored in $_ and looks like this: 1234.jpg
    # so strip off anything that isn't a digit
    my $target = $_;
    $target =~ s/[^\d]//g;
    return if !$target;

    push @files, $target;
    return;
};

find( $is_it_between, $stills_dir );

@files = sort @files;
my $next_file = $files[-1] + 1;
my $file_name = sprintf("$stills_dir/%06d.jpg", $next_file);

print `/usr/local/bin/isightcapture -t jpeg $file_name`;
