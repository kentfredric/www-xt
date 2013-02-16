use strict;
use warnings;

package XT::Schema::Result::Category;

# ABSTRACT: Leaf nodes of the Category graph.

use XT::Schema::Candy;

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

unique_constraint category_id_unique => ['id'];

1;

