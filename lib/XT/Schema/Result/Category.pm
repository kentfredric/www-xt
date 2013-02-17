use strict;
use warnings;

package XT::Schema::Result::Category;

# ABSTRACT: Leaf nodes of the Category graph.

use XT::Schema::Candy;

primary_column id => {
  data_type          => int =>,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retrieve_on_insert => 1,
};

column name => {
  data_type   => text =>,
  is_nullable => 0,
};

1;

