package Schema;

# based on the DBIx::Class Schema base class
use base qw/DBIx::Class::Schema/;

# This will load any classes within
# BeanTest::Schema::Result and BeanTest::Schema::ResultSet 
__PACKAGE__->load_namespaces();

1;
