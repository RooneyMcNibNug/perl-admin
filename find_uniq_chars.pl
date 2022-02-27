## Quickly print all unique characters from a string

%seen = ();
$string = "SG9uayBIb25rISBRdWFjayBRdWFjayE="; # Your text here

foreach $char (split //, $string) {
    $seen{$char}++;
}

print "Unique characters from your string: ", sort(keys %seen), "\n";