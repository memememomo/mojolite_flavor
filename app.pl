#! perl
use strict;
use warnings;
use utf8;
use Encode;
use File::Basename;
use lib dirname(__FILE__) . '/lib';
use local::lib dirname(__FILE__) . '/local';
use Mojolicious::Lite;
use Model;


app->plugin('MyConfig');
app->log->level('error');


get '/' => sub {
    my $self = shift;
    $self->render();
} => 'index';


app->start;

