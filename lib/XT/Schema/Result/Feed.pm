use strict;
use warnings;

package XT::Schema::Result::Feed;

# ABSTRACT: A RSS Source that can populate articles

use XT::Schema::Candy;

primary_column id => {
  is_numeric         => 1,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retrieve_on_insert => 1,

};
column submitting_user => {
  is_numeric         => 1,
  is_nullable        => 0,
  retreive_on_insert => 1,
};

unique_constraint feed_id_unique      => ['id'];
relationship feed_has_submitting_user => (
  User => {
    'foreign.id' => 'self.submitting_user',
  }
);

1;

