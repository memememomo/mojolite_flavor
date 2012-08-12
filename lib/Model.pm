package Model;

use strict;
use warnings;
use utf8;
use Encode;
use Time::Piece;
use Time::Seconds;
use Digest::SHA1 ();
use Mojo::JSON;

sub db_json_decode {
    my ($text) = @_;
    my $parser = Mojo::JSON->new;
    return $parser->decode( encode_utf8( $text ) );
}

sub sha1 {
    my ($data) = @_;
    return Digest::SHA1::sha1_hex( $data );
}

1;
