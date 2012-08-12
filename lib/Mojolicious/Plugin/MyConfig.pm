package Mojolicious::Plugin::MyConfig;

use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Controller;
use HTML::FillInForm::Lite;
use DBI;
use Teng::Schema::Loader;
use DB;


sub register {
    my ($self, $app) = @_;

    my $c = Mojolicious::Controller->new(app => $app);

    # config
    my $config_file = $app->home->rel_file('/conf/config.pl');
    my $config = $app->plugin(
        config => {
            file      => $config_file,
            stash_key => 'config',
        }
    );

    $app->plugin('charset'=> {charset => 'UTF-8'});

    $app->sessions->default_expiration(60 * 60 * 24);

    $app->plugin('tt_renderer');

    # add set_error_messages method
    $app->helper(
        set_error_messages => sub {
            my ($self, $validator) = @_;

            my @messages;
            for my $message ( $validator->get_error_messages ) {
                push @messages, $message;
            }

            $self->stash(error_messages => \@messages);
        }
    );

    # add set_result_message method
    $app->helper(
        set_result_message => sub {
            my ($self, $result_message) = @_;
            $self->flash(result_message => $result_message);
        }
    );


    # DB
    $app->helper(
        db => sub {
            my $c = shift;
            my $app = $c->app;

            if ( !defined $app->{db} ) {
                my $dbi_config = $ENV{'CONFIG_DBI'} || $config->{'DBI'};

                my $dbh = DBI->connect(@{$dbi_config});
                my $db = Teng::Schema::Loader->load(
                    namespace => 'DB',
                    dbh       => $dbh,
                );
                $app->{db} = $db;
            }

            return $app->{db};
        }
    );

    $app->helper(
        render_filled_html => sub {
            my $self = shift;
            my $params = shift;
            my $html = $self->render_partial(@_)->to_string;

            my $fill = HTML::FillInForm::Lite->new( fill_password => 1 );
            $self->render_text(
                $fill->fill(\$html, $params),
                format => 'html'
            );
        }
    );

    $app->helper(
        req_to_hash => sub {
            my $c = shift;
            return $c->req->params->to_hash;
        }
    );
}


1;
