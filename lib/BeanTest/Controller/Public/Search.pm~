package BeanTest::Controller::Public::Search;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the public search page.

=cut

sub search_form {
    my ($self) = @_;


}

sub search { # print both search form and list of jobs (paged)
    my($self, $c) = @_;
    my $key = $c->param('keyword');
    my $rs = $schema->resultset('Jobs');

# SELECT * FROM jobs WHERE skills like '%keyword%';
    my $query_rs = $rs->search({skills -like '%$key%' });


# Iterate all posts by this author
    while (my $post = $rs->next) {
	print $post->title; # ? add to template?
    }
    $self->render(template => 'search');
#    return;
}


1;
