package Model;

use strict;
use warnings;
use utf8;
use Encode;
use Time::Piece;
use Time::Seconds;

use Mojo::JSON;

sub db_json_decode {
    my ($text) = @_;
    my $parser = Mojo::JSON->new;
    return $parser->decode( encode_utf8( $text ) );
}

1;
