package Schema::Result::Jobs;
use base qw/DBIx::Class::Core/;
__PACKAGE__->load_components(qw/Core TimeStamp/); 

#Schema::Result::Jobs->belongs_to('agency' => 'Schema::Result::Agencies', 'id');

#__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
# Associated table in database
__PACKAGE__->table('jobs');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     title => {
         data_type => 'text',
     },

     job_descrip => {
         data_type => 'text',
	 is_nullable => 1,
     },

     agency => {
         data_type => 'integer',
     },

     category => {
         data_type => 'text',
	 is_nullable => 1,
     },

     skills => {
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
