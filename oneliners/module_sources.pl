# When you want to find the Perl source directories for a module already installed on your system
# This will give you only the built-in @INC array of paths - for more verbose info, do "perl -V" command

perl -e 'print join("\n",@INC,"")'
