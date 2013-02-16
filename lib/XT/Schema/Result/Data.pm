use strict;
use warnings;

package XT::Schema::Result::Data;

# ABSTRACT: Miscelaneous named shared structures as serialised objects.

use XT::Schema::Candy -components => [ 'InflateColumn::Serializer', 'Core' ];

primary_column id => {
  is_numeric         => 1,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retrieve_on_insert => 1,
};
column name => {
  is_numeric         => 0,
  is_nullable        => 0,
  retrieve_on_insert => 1,
};

column data => {
  is_numeric         => 0,
  is_nullable        => 0,
  retrieve_on_insert => 1,
  serializer_class   => 'JSON',
};

unique_constraint data_id_unique   => ['id'];
unique_constraint data_name_unique => ['name'];

1;

