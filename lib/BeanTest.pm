package BeanTest;

use Mojo::Base 'Mojolicious';

=head1 DESCRIPTION

This is the base L<Mojolicious> application for the Broadbean technical test, 
it provides a skeleton application framework which can be added to.  Included
properties are configuration and a templating system.

It has 2 routes available by default:

1. A simple index powered by a template, powered by 
L<BeanTest::Controller::Index>
2. A healthcheck route to allow the service to report on itself, powered by 
L<BeanTest::Controller::Healthcheck>

=cut

has schema => sub {
  return Schema->connect('dbi:SQLite:' . ($ENV{TEST_DB} || 'moblo.db'));
};

# Set up some attributes for our app, for instance a database schema
has _dummy => sub {
    my ($self) = @_;

    return {
        my => 'object',
        is => 'here',
        welcome => 'Welcome to the Dominoes Test',
    };
};



=func C<startup>

Called by L<Mojolicious> when the application starts

=cut

sub startup {
    my ($self) = @_;

    $self->setup_directories();
    $self->setup_plugins();
    $self->setup_helpers();
    $self->setup_routes();
    
    return;
}

=func C<setup_directories>

Sets up the template and static directories.

=cut

sub setup_directories {
    my ($self) = @_;

    # All templates found in $ENV{MOJO_HOME}/root/templates
    $self->renderer->paths([$self->home->rel_dir('root/templates')]);
    # All static files found in $ENV{MOJO_HOME}/root/static
    $self->static->paths([$self->home->rel_dir('root/static')]);

    return;
}

=func C<setup_plugins>

Sets up any plugins which are required.  If you wished to add configuration 
from the configuration file for a new plugin you could do it like so.

Assuming you had the following config file.

    {
        dummy: {
            option1: "value",
            options2: "value"
        }
    }

Then you could load that configuration as follows.

    $self->plugin('Dummy', $self->config->{dummy});

=cut

sub setup_plugins {
    my ($self) = @_;

    $self->plugin('JSONConfig');
    #$self->plugin('tt_renderer');
  $self->plugin('tt_renderer' => {
        template_options => {
        EVAL_PERL    => 1, 
        },
    });
    return;
}


=func C<setup_helpers>

Set up C<Mojolicious/helper>, so we can access our attributes without using the 
app object directly.  It also makes them useable directly in templates.

    # Before a helper
    $self->app->dummy
    # After a helper
    $self->dummy

=cut

sub setup_helpers {
    my ($self) = @_;

    $self->helper(db => sub { $self->app->schema });
    $self->helper( dummy => sub { $self->app->_dummy; } );

    return;
}

=func C<setup_routes>

Set up our various C<Mojolicious::Routes> which actually do the grunt work for
the application.

=cut

sub setup_routes {
    my ($self) = @_;

    my $r = $self->routes->namespaces(['BeanTest::Controller']);
    $r->get('/healthcheck')->to('healthcheck#healthcheck');
    $r->get('/index')->to('index#index');
#    $r->get('/admin')->to('admin#index');
#    $r->get('/admin')->to(controller => 'admin', action => 'index');
    
    $r->get('/signup')->to(controller => 'signup', action => 'signup'); # if num_players missing gives form
    $r->post('/signup')->to(controller => 'signup', action => 'signup'); # if num_players then creates the board

    $r->get('/admin')->to(controller => 'admin', action => 'create_gameplay'); # if no params sets up for gameplay
    $r->post('/admin')->to(controller => 'admin', action => 'play_turn'); # if params, does the gameplay

    return;
}

1;
