package t::Util;
use strict;
use warnings;
use Encode;
use Test::mysqld;
use Test::Fixture::DBI;
use Test::Mojo;
use Test::More;

use base 'Exporter';
our @EXPORT = qw/U u E e eU qrU/;

use File::Basename;
use lib dirname(__FILE__) . '/lib';
use Test::MyApp::mysqld;


sub setup_mysqld {
    my ($schema, $fixture) = @_;

    my $mysqld = Test::MyApp::mysqld->setup;
    Test::MyApp::mysqld->cleanup($mysqld);

    my $dbh = dbh_mysqld($mysqld);


    # テーブル作成
    construct_database(
        dbh      => $dbh,
        database => $schema,
    );

    # 初期データ
    for my $f (@$fixture) {
        construct_fixture(
            dbh => $dbh,
            fixture => $f,
        );
    }

    $dbh->commit();

    return $mysqld;
}


sub U($) { decode_utf8($_[0]) }
sub u($) { encode_utf8($_[0]) }
sub E($) { decode('euc-jp', $_[0]) }
sub e($) { encode('euc-jp', $_[0]) }
sub eU($) { e(U($_[0])) }
sub qrU($) {
    my $str = decode_utf8($_[0]);
    return qr/$str/;
}

1;
