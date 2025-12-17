## If you're working with the ISO of a dumped dvd+rw disc, you can use this to find the chapters located on the disc 
## and you will get output of the commands to run to convert to mp4 via ffmpeg and run those afterwards.

#!/usr/bin/perl
use v5.16;
use strict;
use warnings;

my $off = 0;
my $file = $ARGV[0];
open my $fh, '<:bytes', $file or die;
my $buf;
my @pos;

# Search through each block for one beginning with the header text and store these in array of offsets - I think it's one for each track?
while( my $len = read $fh, $buf, 1024 ) {
        die if $len != 1024;

        if( $buf =~ /^DVDVIDEO/ ) {
                push @pos, $off;
        }
        $off++;
}
push @pos, $off;

my $chap = 0;
for( my $i = 0; $i < @pos - 1; $i++ ) {
        my $length = $pos[$i+1] - $pos[$i];
        next if $length < 1000;
        $chap++;
        say "dd if=$file bs=1024 skip=$pos[$i] count=$length | ffmpeg -i pipe:0 -acodec copy -vcodec copy out$chap.mp4";
}
