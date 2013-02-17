use strict;
use warnings;

package XT::Schema::Result::Article;

# ABSTRACT: An Individual displayed article

use XT::Schema::Candy;

primary_column id => {
  data_type          => int =>,
  is_nullable        => 0,
  is_auto_increment  => 1,
  retreive_on_insert => 1,
};
column source_feed => {
  data_type   => int =>,
  is_numeric  => 1,
  is_nullable => 1,
};
column submitting_user => {
  data_type   => int =>,
  is_numeric  => 1,
  is_nullable => 0,
};
column category => {
  data_type   => int =>,
  is_numeric  => 1,
  is_nullable => 0,
};

relationship article_has_feed => (
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

