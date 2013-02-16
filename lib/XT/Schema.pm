use strict;
use warnings;

package XT::Schema;

use parent 'DBIx::Class::Schema';

sub schema_version { 1 }

__PACKAGE__->load_namespaces();
__PACKAGE__->load_components('Schema::Config');

1;
