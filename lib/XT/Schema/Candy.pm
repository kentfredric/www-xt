
use strict;
use warnings;

package XT::Schema::Candy;

use parent 'DBIx::Class::Candy';

# Class -> table translator.
# mostly because autopluralisation sucks.
sub import {
  my ($class) = shift;
  @_ = ( $class, -autotable => 1, @_ );
  goto \&DBIx::Class::Candy::import;
}

sub base {
  'DBIx::Class::Core';
}

sub gen_table {
  my ( $self, $class ) = @_;
  my $t = $class;
  $t =~ s/^XT::Schema::Result:://;
  $t =~ s/::/_/g;
  return lc($t);
}

1;
