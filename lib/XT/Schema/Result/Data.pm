use strict;
use warnings;

package XT::Schema::Result::Data;

# ABSTRACT: Miscelaneous named shared structures as serialised objects.

use XT::Schema::Candy -components => [ 'InflateColumn::Serializer', 'Core' ];

primary_column id => {
  data_type          => int =>,
  is_auto_increment  => 1,
  retrieve_on_insert => 1,
};
column name => {
  data_type   => text =>,
  is_nullable => 0,
};

column data => {
  data_type        => text =>,
  is_nullable      => 0,
  serializer_class => 'YAML',
};

unique_constraint data_name_unique => ['name'];

1;

