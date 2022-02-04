## Recursively search for files with a particular extension and list them

#!/usr/local/bin/perl

use strict;
use warnings;

sub shellq { "'".(shift =~ s/'/'\\''/gr). "'" }
 
sub finder {
    my $dir = shellq(shift);
    my $test = shellq(shift);
 
    local $/ = "\0";
    open my $pipe, "find $dir -iname $test -print0 |" or die "find: $!.\n";
    while (<$pipe>) { print "$_\n"; }
    close $pipe;
}

# Place extension in last part here: 
finder('.', '*.pl');