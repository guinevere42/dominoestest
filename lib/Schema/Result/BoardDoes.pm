package Schema::Result::BoardDoes;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('board_does');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },
     does_id => {
         data_type => 'integer',
         is_auto_increment => 0,
     },
     player_id => {
         data_type => 'integer',
         is_auto_increment => 0,
     },
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
 __PACKAGE__->belongs_to('board_does' => 'Schema::BoardDoes', sub {
    my $args = shift;
    return {
	"$args->{foreign_alias}.does_id" => { -ident => "does.id" },
    };
			 });
 __PACKAGE__->belongs_to('board_does' => 'Schema::BoardDoes', sub {
    my $args = shift;
    return {
	"$args->{foreign_alias}.does_id" => { -ident => "player.id" },
    };
			});
1;
