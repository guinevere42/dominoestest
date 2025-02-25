package BeanTest::Controller::Index;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the index page.

=cut

sub index {
    my ($self) = @_;

    $self->render(template => 'index');
}

1;
