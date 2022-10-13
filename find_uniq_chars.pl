## Quickly print all unique characters from a string

print "Enter your string below: \n";
print "====================== \n";

%seen = ();
my $string = <STDIN>; # Your text here

foreach $char (split //, $string) {
    $seen{$char}++;
}

print "Unique characters from your string: ", sort(keys %seen), "\n";