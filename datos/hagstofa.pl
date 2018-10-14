#!/usr/bin/env perl

use WWW::Mechanize;

my $url = "https://rannsokn.hagstofa.is/pxen/Dialog/varval.asp?ma=SAM08005&ti=Number%20of%20trips%20and%20overnight%20by%20forms%20of%20tourism%20and%20classes%20of%20visitors,%202009-2013%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20&path=../Database/ferdamal/ferdaidnadur/&lang=1&units=Trips%20or%20overnights";

my $mech = WWW::Mechanize->new();

$mech->get( $url );

$mech->select('values1','2');
$mech->select('values2', ['1','2','3','4','5']);
$mech->select('values3', '1');
$mech->select('values4', '1');

my $first_response = $mech->submit_form();
if ($first_response->is_success) {
  print $first_response->decoded_content;
}
else {
  print STDERR $response->status_line, "\n";
}
