package Schema::Result::Player;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('player');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },
     player_name => {
         data_type => 'char',
         is_auto_increment => 0,
     },

 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');


1;
