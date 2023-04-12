## Cheapo's alternative to using the Letterboxd API, which is in beta and requires a signup.
#
## This requires you to login to letterboxd and export your watchlist.
## Example: https://letterboxd.com/rooneymcnibnug/watchlist/export/
#
## This script will go through your exported watchlist file, pick a random title for you to watch, 
## and then check against a directory on your machine to see if you have a video file matching it.
#
## Creative because I want to work to make fighting against indecisiveness lazy
## ..and to learn better Perl.

#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use HTML::TreeBuilder;

# Open the CSV file for reading - CHANGE watchlist.csv here to your watchlist file name!
open my $fh, '<', 'watchlist.csv' or die "Could not open the watchlist file: $!";

# Read all lines into an array
my @lines = <$fh>;

# Choose a random line index
my $random_index = int(rand(scalar(@lines)));

# Get the desired columns from the chosen line
my @fields = split /,/, $lines[$random_index];
my $title = $fields[1];
my $shortened_link = $fields[3];
my $year = $fields[2];

# Resolve the shortened link to the full letterboxd.com URL
my $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3');
my $response = $ua->get($shortened_link);
die "HTTP error: " . $response->status_line unless $response->is_success;
my $full_link = $response->base;

# Print the random film, its release year, and its letterboxd.com link
print "\e[35mYou should just watch...\e[0m\n";
print "\e[32m$title ($year)\e[0m \e[35m-\e[0m\ \e[32m$full_link\e[0m\n";

# Check for files with the title name
print "Checking for files with the title name...\n";
my @title_words = split /\s+/, $title;
my @ignore_words = ("the", "and", "&", "A");
@title_words = grep { !($_ ~~ @ignore_words) } @title_words;
my $title_regex = join('.*', @title_words);
my @matching_files = grep /$title_regex/i, glob('~/media/*'); # CHANGE your directory for file lookups here!
if (@matching_files) {
    print "Found the following files matching the title name:\n";
    print join("\n", @matching_files), "\n";
} else {
    print "No files found matching the title name.\n";
}
