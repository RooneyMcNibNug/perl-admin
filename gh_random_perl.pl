## Trying to learn better Perl here. Taking a look at some O'Reilly book, but also trying to get some exposure
## to Perl-based applications, scripts, etc. That's where this comes  - its a Perl Script to look for Perl!
#
## I didn't want to deal with Github API, so I used LWP, HTML, and List modules - these are all required here.
#
## I did ask ChatGPT for a bit of help here with a few lines..

#!/usr/bin/perl

use strict;
use warnings;
use LWP::Simple;
use HTML::TreeBuilder;
use List::Util qw(shuffle);

# Search through repos that are using perl as a langauge, sort by latest created
my $url = "https://github.com/search?l=Perl&o=desc&q=language%3Aperl&s=created&type=Repositories";
my $content = get $url;

# Dig down into content of the links with TreeBuilder
my $tree = HTML::TreeBuilder->new_from_content($content);

my @links = $tree->look_down(
    _tag => "a",
    class => "v-align-middle"
);

if (@links) {
    my @random_indices = shuffle(0..$#links); # Shuffle the links
    my @random_links = map { $links[$_] } splice(@random_indices, 0, 15); # Get 15 results (feel free to change)
    
    # Randomize and search for .pl file links to print
    foreach my $random_link (@random_links) {
        my $href = $random_link->attr('href');
        my $repo_url = "https://github.com$href";
        my $repo_content = get $repo_url;
        my $repo_tree = HTML::TreeBuilder->new_from_content($repo_content);
        
        my @perl_links = $repo_tree->look_down(
            _tag => "a",
            href => qr/\.pl$/
        );
        
        if (@perl_links) {
            print "\e[32mRandom Perl script link(s) from $repo_url:\n\e[0m"; # Print link to main repo in Green
            foreach my $perl_link (@perl_links) {
                my $perl_href = $perl_link->attr('href');
                print "https://github.com$perl_href\n"; # Print the direct links to the Perl files themselves
            }
        } else { 
            print "\e[31mNo Perl script links found on $repo_url\e[0m\n"; # If no .pl files found in repo, print to lmk in Red
        }
    }
} else {
    print "No Perl script links found on GitHub\n"; # If none found from my search at all, also let me know
}
