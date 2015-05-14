#!/usr/bin/env perl

use Modern::Perl;
use autodie;

use LWP::Simple;
use Mojo::DOM;

my $url = "http://www.elchecf.es/plantilla";

my $dom = Mojo::DOM->new( get $url );

my $jugadores =  $dom->find("div.titulo_datos_comunes");
my @pesos;
for my $p ( @$jugadores ) {
  if ( $p->content() =~ /Peso/ ) {
    my $peso;
    if ( $p->content() =~ /div/ ) {
      ($peso) = ( $p->content() =~ /o: (\d+)/ );
    } else {
      ($peso) = ( $p->content() =~ /(\d+)/ );
    }
    push @pesos, $peso;
  }
}
say("Indice;Peso");
my $i = 1;
say join("\n",map($i++.";".$_, @pesos ));
