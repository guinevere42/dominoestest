package BeanTest::Controller::Signup;

use lib '/srv/econliberty.default.econ.uk0.bigv.io/lib/lib/perl5'; ## temp!

use Mojo::Base 'Mojolicious::Controller';
use Algorithm::Numerical::Shuffle qw( shuffle );

=head1 DESCRIPTION

This is the C<Mojolicious::Controller> for the public search page.

=cut

sub signup { # print both search form and list of jobs (paged)
    my($self, $c) = @_;
    my $post_saved;
    my $num_players = $self->param('num_players');
    if($num_players)
    {
	$self->create_gameplay($num_players);
	for my $c ( 1 .. $num_players ) {
	    $self->insert_player( $c );
	}
	$post_saved='Game Board Created';
    }

    $self->load_players();
    
    $self->flash(post_saved => $post_saved);
    $self->stash(post_saved => $post_saved);
    $self->stash(search_res => undef);
    $self->render(template => 'search', post_saved => $post_saved);
}




sub create_gameplay {
    my($self) = @_;

    # at the start of the game we create the initial board & give every player their pieces
    # so first we grab our number of players (a param)
    # we create a fresh game play of dominoes, with player does and board does
    # we then call insert_players() and then loop through giving them pieces
    # remaining pieces go in the board table with an id to the remaining_does table
    $self->insert_board_and_pieces();
}

sub insert_board_and_pieces {
    my($self, $num_players) = @_;

    my $rs = $self->app->schema->resultset('Does');
    my $storage = $self->app->schema->storage;
    $storage->debug(1);    

    my @total_dots;
    for ( 1 .. 4 ) {	     # total of 28, every other creates new doe
	# create the does table by looping thru the options, for 0..6 x4
	my(@side1_dots) = shuffle( 0 .. 6 );
	my(@side2_dots) = shuffle( 0 .. 6 );

	while( @side1_dots ) {
	    my($side1) = splice(@side1_dots, rand @side1_dots, 1); # rand or just use first since already shuffled?
	    my($side2) = splice(@side2_dots, rand @side2_dots, 1); # rand or just use first since already shuffled?

	    $rs->create({
		dots_one => $side1,
		dots_two => $side2,
						 });
	}
    }
}

sub insert_player {
    my ( $self, $player_name ) = @_; #  don't need player_num because we need to autoincrement so multiple games can be played simultaneously
    # use num of player as name for now, since we don't have a separate form for adding names
    # at start of play, number of players is chosen & inserted into table
    # this will affect game play, so we will loop through each player &
    # this is where we will get the players & link to the dominoes they have
    # create table playerdoes(id int NOT NULL AUTO_INCREMENT PRIMARY KEY, does_id int REFERENCES does(id));

    my $rs = $self->app->schema->resultset('PlayerDoes');
    my $storage = $self->app->schema->storage;
    $storage->debug(1);

    my $rs_play = $self->app->schema->resultset('Player');
    $rs_play->create( { player_name => $player_name } );
    # player should get 7 dominoes to start, so 7 rows linking to the does.id; this can be automated

    my $c=1;
    my $rs_does = $self->app->schema->resultset('Does')->search;
    while( my $does_row = $rs_does->next ) {
	my $does_id = $does_row->id; # should be 1-28
	$rs->create( { player_name => $player_name, does_id => $does_id } );
	last if $c==7;
	$c++;
    }

}

sub load_players {
    my $self = shift;
    
    my $rs = $self->app->schema->resultset('Player')->search();

    my $storage = $self->app->schema->storage;
    $storage->debug(1);
    my @player_rows;
    while ( my $play_row = $rs->next ) {
	push @player_rows, $play_row;
    }
    $self->stash(players => \@player_rows);
}


sub update_does_for_turn {
    my ( $self ) = @_;
    my $rs = $self->app->schema->resultset('Does');
    my $storage = $self->app->schema->storage;
    $storage->debug(1);    

    # for player, upon each turn update to add/remove
    #    $rs->update( { does_id => $id } );
}

1;
