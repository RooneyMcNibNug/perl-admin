use strict;
use warnings;

print "~~ Finds Base64 encoded strings within a file ~~ \n";
print "   Enter your file below (provide full path): \n";
print "================================================ \n";
my $file = <STDIN>; #'/Users/name/Documents/testbase64.txt';
    open(FH, $file) or die("$file not found - please check your path and spelling");
	
    while(my $String = <FH>)
    {
        if($String =~ /^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{4}|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{2}={2})$/)
        {
            print "$String \n";
        }
    }
close(FH);