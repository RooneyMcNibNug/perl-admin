## Using /dev/urandom to fetch they characters
## Generating in "consonant, vowel, number, consonat, symbol.." pattern
## Trying to grasp enough entropy here

#!/usr/bin/env perl

use strict;
use warnings;

my $debug = 0;

if ( $debug ) {
  require Data::Dumper;
  Data::Dumper -> import();
}

# Change the value of $num to alter the length of the password generated
my $num    = 8;

# You can change the format here to alter the ordering of the password generated
my $format = "CVNCS";

my $count = 0;

# Feel free to change the caharcter types/inclusions here based on your particular needs
# NOTE: the "#" and "," characters will possibly produce a warning via "use warnings;"
my %chars = (
    V => [qw ( a e i o u y )],
    C => [grep { not /[aeiouy]/ } "a" .. "z"],
    N => [qw ( 0 1 2 3 4 5 6 7 8 9 )],
    S => [qw ( ! @ $ % ^ & * _ + - = ~ : < > ? / )] );

if ($debug) {
   print Dumper(\%chars);
}

my %limit_for;
foreach my $type (keys %chars) {
    $limit_for{$type} = 255 - 255 % @{$chars{$type}}; }

if ($debug) {
   print Dumper(\%limit_for);
}

open(my $urandom, '<:raw', '/dev/urandom') or die $!;

my @groups;
for (1 .. $num) {
    push @groups, '';
    for my $type (split //, $format) {
        my $value;
        while (not defined $value or $value >= $limit_for{$type}) {
            my $byte;
            read($urandom, $byte, 1) or die $!;

            # Convert to numeric
            $value = (unpack "C", $byte);
            $count++;
        }
        print "$value \t=> " if $debug;
        $value = $value % @{$chars{$type}};
        print "$value \t= " if $debug;
        $groups[$#groups] .= $chars{$type}[$value];
        print $chars{$type}[$value] if $debug;
        print "\n" if $debug;
    }

    print "\n" if $debug;
}

close($urandom);

print "YOUR PASSWORD IS BELOW: \n";
print "-----------------------\n";
print join "", @groups,"\n";
print "RNG: ", $count, "\n" if $debug;
