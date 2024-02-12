use strict;
use warnings;
use Net::Ping;

$net = "192.168.1.";
@range = (1..200); # feel free to narrow this down, as it could take a while

@host_array = map($net . $_, @range);

$p = Net::Ping->new();
foreach $host (@host_array)
{
# remove the line for NOT if you only want the reachable ones printed!
    print "$host was ";
    print "NOT " unless $p->ping($host, 2);
    print "reached via ping.\n";
    sleep(1);
}
$p->close();
