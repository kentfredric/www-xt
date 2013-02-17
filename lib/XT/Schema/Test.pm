
use strict;
use warnings;
use v5.10;

package XT::Schema::Test;

use File::Temp qw( tempdir tempfile );
use Path::Tiny qw( path );
use File::Spec;
use XT::Schema;

sub tmpdir_name {
  return 'XT_test';
}

sub scratch {
  return state $scratch = do {
    my $p = path( File::Spec->tmpdir )->child( $_[0]->tmpdir_name );
    $p->mkpath;
    $p;
  };
}

sub xt_tempdir {
  return state $dir = do {
    tempdir( 'XT.XXXXXX', DIR => $_[0]->scratch()->absolute->stringify, CLEANUP => 1 );
  };
}

sub db_file {
  state $files = [];
  my ( $tempfile, $filename ) = tempfile( "XT.XXXXXX", SUFFIX => '.sqlite', DIR => $_[0]->xt_tempdir() );
  push @{$files}, $tempfile;
  return path($filename)->absolute->stringify;
}

sub tdb {
  my $instance = XT::Schema->connect( 'dbi:SQLite:' . $_[0]->db_file );
  $instance->deploy();
  return $instance;
}

1;
