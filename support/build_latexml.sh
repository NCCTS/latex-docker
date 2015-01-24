#!/bin/bash

export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH

cpan Archive::Zip \
     DB_File \
     File::Which \
     Image::Size \
     IO::String \
     JSON::XS \
     LWP \
     Parse::RecDescent \
     URI \
     XML::LibXML \
     XML::LibXSLT \
     UUID::Tiny

cd /docker-build/support
git clone https://github.com/brucemiller/LaTeXML.git

cd LaTeXML
git checkout v0.8.0
perl Makefile.PL
make
make test
make install
