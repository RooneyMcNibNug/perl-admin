#!/bin/bash

# cpm is fast!
curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g App::cpm

# some good modules to have in your environment:
cpm install DBI
cpm install JSON
cpm install YAML
cpm install Moo
cpm install DateTime
cpm install XML::Simple
cpm install Text::CSV
cpm install WWW::Mechanize
cpm install HTTP::Response
cpm install Devel::Trace
cpm install JSON::MaybeXS
cpm install Mojo::UserAgent
