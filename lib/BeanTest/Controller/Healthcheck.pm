package BeanTest::Controller::Healthcheck;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the healthcheck page.  It returns
a JSON encoded status page for the application.

=cut

sub healthcheck {
    my $self = shift;

    $self->render(json => {
        'status' => 'ok',
    });
}

1;
