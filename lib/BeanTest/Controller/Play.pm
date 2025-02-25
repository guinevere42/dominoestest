package BeanTest::Controller::Play;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the public search page.

=cut

sub play { # print both search form and list of jobs (paged)
    my($self, $c) = @_;
    my $key = $self->param('keyword');
    my $rs = $self->app->schema->resultset('Jobs');
    my(@rows);
# SELECT * FROM dominoes LIMIT 1;
    my $query_rs = $rs->search({skills => { -like => "%$key%" } });
    while(my $r = $query_rs->next){
	push(@rows, $r); 
    }
    push(@rows, [{'title' => ''}]);
    $self->stash(search_res => \@rows);
# Iterate all posts by this author
#    while (my $post = $rs->next) {
#	print $post->title; # ? add to template?
#    }
    $self->render(template => 'search', search_res => \@rows); #, search_res => $query_rs);
    $rs->{CachedKids} = {}; 
#    return;
}


sub play_form {
    my ($self) = @_;

    $self->render(template => 'search_form');
}

1;
