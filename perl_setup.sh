#!/bin/bash

# cpm is fast as an alternative
# curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g App::cpm

# some good modules to have in your environment:
cpan DBI JSON YAML Moo DateTime XML::Simple PDF::Collage Text::CSV WWW::Mechanize HTTP::Response Devel::Trace JSON::MaybeXS Mojo::UserAgent

#Informational:
cpan -l
whereis perl
perl -v
