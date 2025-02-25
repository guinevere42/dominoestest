package BeanTest::Controller::Admin;

use Mojo::Base 'Mojolicious::Controller';

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the Admin Game Play

We create players, pick dominoes, and have the functions of play here
The Play module then calls upon this to take care of the play

=cut

sub index {
    my ($self) = @_;

    $self->render(template => 'admin/index');
}

sub play_turn {
    my($self, $c) = @_;
    my $post_saved;
    my $player = $self->param('myplayer');
print STDERR "\n\n got here with player $player \n";
    $self->load_my_does($player);
    $self->load_board_does();

  # for each player, as we loop, we get their does 'in hand'
    # and then they will select one to play based on the 'board'
    $self->flash(post_saved => $post_saved);
    $self->stash(post_saved => $post_saved);

    $self->render(template => 'gameplay', post_saved => $post_saved);
}


sub pick_board_piece {
    my($self, $c) = @_;

    my $rs = $self->app->schema->resultset('Does'); # col: id, dots_one & dots_two
    my $storage = $self->app->schema->storage;
    $storage->debug(1);    

    $self->flash(post_saved => 0);
    my $post_saved=0;
    my @rows;
#    if($self->board_has_dominoes) # change to if board_has_dominoes?
#    {
    my ($row) = $rs->search({},
            { order_by => \"RAND()",
              columns => ['dots1', 'dots2'],
              rows => 1 });

    push(@rows, [{'selected dominoe' => ''}]);
    push @rows, $row;
    $self->stash(search_res => $row);

    $self->render(template => 'play', search_res => \@rows); #, search_res => $query_rs);
    $post_saved=1;
    $self->flash(post_saved => $post_saved);
    $self->stash(post_saved => $post_saved);
#    }

}

sub load_my_does {
    my ($self,$player) = @_;
    
    my $rs_pd = $self->app->schema->resultset('PlayerDoes')->search({ player_name => $player });
    my $storage = $self->app->schema->storage;
    $storage->debug(1);
    my @does;
    while ( my $row = $rs_pd->next) {
      push @does, $row->does_id;
    }

    my @doe_rows;
    for my $doe_id ( @does ) { # only a few and can't use map for this
      my $row = $self->app->schema->resultset('Does')->search( id => $doe_id )->first;

      push @doe_rows, $row;
    }
    $self->stash(mydominoes => \@doe_rows);
}

sub load_board_does {
    my $self = shift;
    
    my $rs = $self->app->schema->resultset('BoardDoes')->search;
    my $storage = $self->app->schema->storage;
    $storage->debug(1);
    my @doe_rows;
    while ( my $doe_row = $rs->next ) {
	push @doe_rows, $doe_row;
    }
    $self->stash(board => \@doe_rows);
}

1;


