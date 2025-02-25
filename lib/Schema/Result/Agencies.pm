package Schema::Result::Agencies;
use base qw/DBIx::Class::Core/;
__PACKAGE__->load_components(qw/Core/); 

# Associated table in database
__PACKAGE__->table('agencies');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     title => {
         data_type => 'text',
     },

     description => {
         data_type => 'text',
     },

 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');

1;
