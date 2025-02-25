package Schema::Result::PlayerDoes;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('playerdoes');

# Column definition
__PACKAGE__->add_columns(

    id => {
         data_type => 'integer',
         is_auto_increment => 1,
    },
    player_name => {
	data_type  => 'char',
    },
     does_id => {
         data_type => 'integer',
         is_auto_increment => 0,
     },

 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
 __PACKAGE__->belongs_to('playerdoes' => 'Schema::Player', sub {
    my $args = shift;
    return {
	"$args->{foreign_alias}.does_id" => { -ident => "does.id" },
    };
			 });

1;
