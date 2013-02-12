use strict;
use warnings;

package XT::Schema::Result::Article;

use Moose;

extends 'DBIx::Class::Core';

__PACKAGE__->table('article');
__PACKAGE__->add_column(
  id => {
    is_numeric         => 1,
    is_nullable        => 0,
    is_auto_increment  => 1,
    sequence           => 'article_id_seq',
    retrieve_on_insert => 1,
    auto_nextval       => 1,
  },
  source_feed => {
    is_numeric         => 1,
    is_nullable        => 1,
    retrieve_on_insert => 1,
  },
  submitting_user => {
    is_numeric         => 1,
    is_nullable        => 0,
    retreive_on_insert => 1,
  },
);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( article_id_unique => ['id'] );
__PACKAGE__->add_relationship(
  article_has_feed => Feed => {
    'foreign.id' => 'self.source_feed',
  }
);
__PACKAGE__->add_relationship(
  article_has_submitting_user => User => {
    'foreign.id' => 'self.submitting_user',
  }
);

__PACKAGE__->meta->make_immutable;

1;
