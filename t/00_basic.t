#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;

use Test::More;
use Test::Mojo;

use t::Util;

require(dirname(__FILE__) . '/../app.pl');

# Test
my $t = Test::Mojo->new;

$t->get_ok('/')
  ->status_is(200);

done_testing();
