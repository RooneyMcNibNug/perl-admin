# create dirs (in your current path) where each directory is named after each line in a text document
perl -lne 'mkdir $_ or warn "$_: $!\n"' < folder_names.txt
