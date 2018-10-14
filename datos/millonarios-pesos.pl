#!/usr/bin/env perl

use Modern::Perl;
use autodie;

use LWP::Simple;
use Mojo::DOM;

my $url = "http://www.millonarios.com.co/team";

my $dom = Mojo::DOM->new( get $url );
my @pesos;
my $players = $dom->find("select#player option[value]");

for my $p (@$players) {
  if ( $p->val ) {
    my $this_dom = Mojo::DOM->new( get "http://www.millonarios.com.co/".$p->val );
    my $jugador = $this_dom->at("div.sombra-detalle");
    my $nombre = $jugador->find("strong")->map("text")->join( " " );
    my $data = $jugador->find("p")->map("text");
    my ($posicion) = ($data->[0] =~ /(\w+),/);
    my ($peso) = ($data->[3] =~ /(\d+)/);
    my ($altura) = ($data->[4] =~ /(\d+,\d+)/);
    $altura =~ s/,/./ if $altura;
    if ( $posicion =~ /(Arq|Def|Del|Med)/ ) {
      push @pesos, [$nombre->encode,$posicion,$peso,$altura];
    }
  }
}

say("Nombre;Posición;Peso;Altura");
for my $p (@pesos) {
  say join(";",@$p);
}
