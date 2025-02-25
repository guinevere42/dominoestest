package Schema::Result::JobSeekers;
use base qw/DBIx::Class::Core/;
use DBIx::Class::InflateColumn::DateTime;
__PACKAGE__->load_components(qw/Core TimeStamp/); 

# Associated table in database
__PACKAGE__->table('jobseekers');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     name => {
         data_type => 'text',
     },

     cv => {
         data_type => 'text',
     },

     jobs_of_interest => {
         data_type => 'text',
	 is_nullable => 1,
     },

     date_published => {
         data_type => 'datetime',
	 set_on_create => 1
     },

 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');

1;
