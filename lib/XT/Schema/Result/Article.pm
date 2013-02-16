use strict;
use warnings;

package XT::Schema::Result::Article;

# ABSTRACT: An Individual displayed article

use XT::Schema::Candy;

primary_column id => {
  is_numeric         => 1,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retreive_on_insert => 1,
};
column source_feed => {
  is_numeric         => 1,
  is_nullable        => 1,
  retrieve_on_insert => 1,
};
column submitting_user => {
  is_numeric         => 1,
  is_nullable        => 0,
  retreive_on_insert => 1,
};
column category => {
  is_numeric         => 1,
  is_nullable        => 0,
  retreive_on_insert => 1,
};

unique_constraint article_id_unique => ['id'];
relationship article_has_feed       => (
  Feed => {
    'foreign.id' => 'self.source_feed',
  }
);
relationship article_has_submitting_user => (
  User => {
    'foreign.id' => 'self.submitting_user',
  }
);
relationship article_has_category => (
  Category => {
    'foreign.id' => 'self.category',
  }
);

1;

