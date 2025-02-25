package BeanTest::Controller::Admin;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the Admin index page.

=cut

sub index {
    my ($self) = @_;

    $self->render(template => 'index');
}

1;


