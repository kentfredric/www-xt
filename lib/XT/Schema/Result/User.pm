use strict;
use warnings;

package XT::Schema::Result::User;

# ABSTRACT: A user who can vote/comment/submit

use XT::Schema::Candy;

primary_column id => {
  data_type          => int =>,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retrieve_on_insert => 1,
};

1;

