#!/usr/bin/perl
## plop this into your deisred directory to replace all of the reference extenions.

use strict;
use warnings;

foreach my $file (glob "*.pubkey") {           # old extentions you would like to replace
    my $new = substr($file, 0, -3) . "asc";    # new extentions for replacement
    rename $file, $new;
}
