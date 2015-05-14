#!/usr/bin/env perl

use Modern::Perl;
use autodie;

use LWP::Simple;
use Mojo::DOM;

my $url = "http://www.elchecf.es/plantilla";

my $dom = Mojo::DOM->new( get $url );

my $jugadores =  $dom->find("div.journal-content-article tr");
my %pesos;
for my $p ( @$jugadores ) {
  say $p->content();
  my $cells = $p->children();
  next if !$cells->[1];
  my $numero = $cells->[1]->text();
  if ( $numero =~ /\d/ ) {
    my $peso_div = $p->at('div#peso')->content();
    say $peso_div;
    my ($peso) = ($peso_div =~ /(\d+)/);
    $pesos{$numero} = $peso;
  }
}
say join("\n",map("$_;$pesos{$_}", keys %pesos ));
