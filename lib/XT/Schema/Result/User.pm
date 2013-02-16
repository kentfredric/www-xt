use strict;
use warnings;

package XT::Schema::Result::User;

# ABSTRACT: A user who can vote/comment/submit

use XT::Schema::Candy;

primary_column id => {
  is_numeric         => 1,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retrieve_on_insert => 1,
};

unique_constraint user_id_unique => ['id'];

1;

