#!/bin/bash

# cpm is fast as an alternative
# curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g App::cpm

# set the CPAN configuration parameter to "follow" and automatically plug in "yes"
# COMMENT THIS & CONFIGURE CPAN MANUALLY BEFORE RUNNING THIS SCRIPT IF YOU DON'T WANT DETFAULTS!
(echo y; echo o conf prerequisites_policy follow; echo o conf commit) | cpan

# some good modules to have in your environment:
cpan Data::Printer Perl::Critic DBI URI JSON YAML Moo DateTime XML::Simple PDF::Collage Text::CSV WWW::Mechanize HTTP::Response Devel::Trace JSON::MaybeXS Mojo::UserAgent use LWP::Simple LWP::UserAgent HTML::TreeBuilder HTML::Parser Mojo::DOM REST::Client Text::Markdown

#Informational:
cpan -l
whereis perl
perl -v
