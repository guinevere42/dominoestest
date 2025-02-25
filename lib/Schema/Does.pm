package Schema::Does;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('does');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },
     dots_one => {
         data_type => 'integer',
         is_auto_increment => 0,
     },

     dots_two => {
         data_type => 'integer',
         is_auto_increment => 0,
     },
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');

1;
