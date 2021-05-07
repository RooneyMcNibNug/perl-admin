# Print a file with line numbering
# Replace "filename.txt" with your desired file

perl -ne 'print "$.\t$_";' filename.txt
