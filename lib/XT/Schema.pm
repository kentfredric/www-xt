use strict;
use warnings;

package XT::Schema;

use Moose;

use parent 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces();
__PACKAGE__->load_components('Schema::Config');

#__PACKAGE__->backup_directory( $backup );
#__PACKAGE__->upgrade_directory($upgrades);

1;
