## Smol script to show you how "deep" a directory goes (how many max subfolders)

#!/usr/bin/perl
use warnings;
use strict;

sub max_depth {
    my ($path, $depth) = @_;
    $depth //= 0;
    opendir my $dir, $path or die "$path: $!";
    my $max = 0;
    while (my $child = readdir $dir) {
        next if '.' eq $child || '..' eq $child;  # Avoid neverending recursion!

        if (-d "$path/$child") {
            my $d = max_depth("$path/$child", 1);
            $max = $d if $d > $max;
        }
    }
    return $max + $depth;
}

print "Enter directory path: ";
my $dir_path = <STDIN>;
chomp $dir_path;

my $depth = max_depth($dir_path);
print "The maximum depth of directory '$dir_path' is: $depth\n";
