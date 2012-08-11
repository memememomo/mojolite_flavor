#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use File::Spec;
use JSON;
use Test::MyApp::mysqld;


my $tempfile = File::Spec->catfile(File::Spec->tmpdir, 'test_mysqld.json');

$SIG{'INT'} = *purge;
END { purge(); }


print "Starting mysqld...";
my $mysqld = Test::MyApp::mysqld->setup;
my $log = File::Spec->catfile($mysqld->{'base_dir'}, qw/tmp mysqld.log/);
printf " started at %s\n", $mysqld->{'my_cnf'}{'socket'};
print "log file: $log\n";


{
    my $json = encode_json({ %$mysqld });
    open my $fh, '>', $tempfile or die $!;
    $fh->print($json);
    $fh->close;
}


sleep 3 while -e $tempfile;


sub purge {
    unlink $tempfile;
    print "Shutting down mysqld...\n";
    exit;
}
