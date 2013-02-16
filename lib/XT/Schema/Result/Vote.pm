use strict;
use warnings;

package XT::Schema::Result::Vote;

# ABSTRACT: A Vote by a user

use XT::Schema::Candy;

primary_column id => {
  is_numeric         => 1,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retrieve_on_insert => 1,
};
column article_id => {
  is_numeric         => 1,
  is_nullable        => 0,
  retrieve_on_insert => 1,
};
column user_id => {
  is_numeric         => 1,
  is_nullable        => 0,
  retrieve_on_insert => 1,
};

unique_constraint vote_id_unique => ['id'];
unique_constraint vote_combo_unique => [ 'article_id', 'user_id' ];

relationship vote_has_article => (
  Article => {
    'foreign.id' => 'self.article_id'
  }
);
relationship vote_has_user => ( User => { 'foreign.id' => 'self.user_id' } );

1;

