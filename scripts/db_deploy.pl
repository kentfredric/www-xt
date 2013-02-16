#!/usr/bin/env perl 
use strict;
use warnings;
use FindBin;
use Path::Tiny qw( path );
my $root;

BEGIN {
  $root = path($FindBin::Bin)->parent;
}
use lib $root->child('lib')->stringify;
use App::DH;
{
  package    # Hide
    XT_DH;
  use Moose;
  use MooseX::AttributeShortcuts;
  extends "App::DH";

  has '+schema' => (
    is      => lazy =>,
    default => sub  { 'XT::Schema' }
  );

  has '+script_dir' => (
    is      => lazy =>,
    default => sub {
      my $path = $root->child('sql');
      $path->mkpath;
      return $path->stringify;
    }
  );

  sub _build_database {
    [ 'PostgreSQL', 'MySQL', 'SQLite', 'Dumper' ],

  }
  __PACKAGE__->meta->make_immutable;
}

my $dh = XT_DH->new_with_options();
$dh->run();

