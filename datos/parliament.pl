#!/usr/bin/env perl

use strict;
use warnings;
use LWP::Simple;

use v5.14;

my $url= shift || "http://www.althingi.is/altext/cv/en/?nfaerslunr=97";

my $data = get($url);

my ($name) = ($data =~ m{<h2 class='boxhead'>([^<]+)</h2>});
my ($birth_month, $birth_year ) = ( $data =~ m{Date of Birth:</strong> (\w+).+(\d+)} );
my ($party) =  ( $data =~ m{strong>Party:</strong> ([^<]+)</li>} );

say "=> $name, $birth_month, $birth_year, $party";
