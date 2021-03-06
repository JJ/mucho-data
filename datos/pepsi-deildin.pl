#!/usr/bin/env perl

use Modern::Perl;
use autodie;

use LWP::Simple;
use Mojo::DOM;
use JSON;
binmode STDOUT, ':encoding(UTF-8)';

my $url = "http://www.ksi.is/mot/motalisti/urslit-stada/?MotNumer=33503";

my $dom = Mojo::DOM->new( get $url );

my $classification_data =  $dom->find("table#stodu-tafla tr");

my %classification;

shift @$classification_data; # off with the headers

my %data = ( u => 3,
	     j => 4,
	     t => 5,
	     net => 7,
	     stig => 8 );

open my $fh, ">pepsi-deildin.csv";
say $fh "Team,",join(",",keys %data );
for my $p ( @$classification_data ) {
  my $rows = $p->find( "td" );
  my $team = $rows->[1]->all_text();
  print $fh $team;
  $classification{$team} = {}; 
  for my $d ( keys %data ) {
    $classification{$team}->{$d} = $rows->[$data{$d}]->text();
    print $fh ",$classification{$team}->{$d}";
  }
  print $fh "\n";
}
close $fh;
say to_json  \%classification ;

