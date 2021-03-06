#!/home/kent/perl5/perlbrew/perls/perl-blead/bin/perl5.17.9

#
# Generated by SQL::Translator 0.11016
# 2013-02-17
# For more info, see http://sqlfairy.sourceforge.net/
#

use strict;
use Cwd;
use DBI;
use Getopt::Long;
use File::Spec::Functions 'catfile';

my ( $help, $add_truncate, $skip, $skiplike, $no_comments,
    $takelike, $mysql_loadfile );
GetOptions(
    'add-truncate'   => \$add_truncate,
    'h|help'         => \$help,
    'no-comments'    => \$no_comments,
    'mysql-loadfile' => \$mysql_loadfile,
    'skip:s'         => \$skip,
    'skiplike:s'     => \$skiplike,
    'takelike:s'     => \$takelike,
);

if ( $help ) {
    print <<"USAGE";
Usage:
  $0 [options] > dump.sql

  Options:
    -h|--help          Show help and exit
    --add-truncate     Add "TRUNCATE TABLE" statements
    --mysql-loadfile   Create MySQL's LOAD FILE syntax, not INSERTs
    --no-comments      Suppress comments
    --skip=t1[,t2]     Comma-separated list of tables to skip
    --skiplike=regex   Regular expression of table names to skip
    --takelike=regex   Regular expression of table names to take

USAGE
    exit(0);
}

$no_comments = 1 if $mysql_loadfile;

my $db     = DBI->connect(
    'dbi:DBD:',
    'db_user',
    'db_pass',
    { RaiseError => 1 }
);
my %skip   = map { $_, 1 } map { s/^\s+|\s+$//; $_ } split (/,/, $skip);
my @tables = (
    {
        table_name  => 'category',
        fields      => [ qw/ id name / ],
        types       => {
            'name' => 'string',
            'id' => 'number',
        },
    },
    {
        table_name  => 'data',
        fields      => [ qw/ id name data / ],
        types       => {
            'data' => 'string',
            'name' => 'string',
            'id' => 'number',
        },
    },
    {
        table_name  => 'user',
        fields      => [ qw/ id / ],
        types       => {
            'id' => 'number',
        },
    },
    {
        table_name  => 'feed',
        fields      => [ qw/ id submitting_user / ],
        types       => {
            'submitting_user' => 'number',
            'id' => 'number',
        },
    },
    {
        table_name  => 'article',
        fields      => [ qw/ id source_feed submitting_user category / ],
        types       => {
            'source_feed' => 'number',
            'submitting_user' => 'number',
            'category' => 'number',
            'id' => 'number',
        },
    },
    {
        table_name  => 'vote',
        fields      => [ qw/ id article_id user_id / ],
        types       => {
            'user_id' => 'number',
            'article_id' => 'number',
            'id' => 'number',
        },
    },
);

for my $table ( @tables ) {
    my $table_name = $table->{'table_name'};
    next if $skip{ $table_name };
    next if $skiplike && $table_name =~ qr/$skiplike/;
    next if $takelike && $table_name !~ qr/$takelike/;

    my ( $out_fh, $outfile );
    if ( $mysql_loadfile ) {
        $outfile = catfile( cwd(), "$table_name.txt" );
        open $out_fh, ">$outfile" or
            die "Can't write LOAD FILE to '$table_name': $!\n";
    }

    print "--\n-- Data for table '$table_name'\n--\n" unless $no_comments;

    if ( $add_truncate ) {
        print "TRUNCATE TABLE $table_name;\n";
    }

    my $sql =
        'select ' . join(', ', @{ $table->{'fields'} } ) . " from $table_name"
    ;
    my $sth = $db->prepare( $sql );
    $sth->execute;

    while ( my $rec = $sth->fetchrow_hashref ) {
        my @vals;
        for my $fld ( @{ $table->{'fields'} } ) {
            my $val = $rec->{ $fld };
            if ( $table->{'types'}{ $fld } eq 'string' ) {
                if ( defined $val ) {
                    $val =~ s/'/\\'/g;
                    $val = qq['$val']
                }
                else {
                    $val = qq[''];
                }
            }
            else {
                $val = defined $val ? $val : $mysql_loadfile ? '\N' : 'NULL';
            }
            push @vals, $val;
        }

        if ( $mysql_loadfile ) {
            print $out_fh join("\t", @vals), "\n";
        }
        else {
            print "INSERT INTO $table_name (".
                join(', ', @{ $table->{'fields'} }) .
                ') VALUES (', join(', ', @vals), ");\n";
        }
    }

    if ( $out_fh ) {
        print "LOAD DATA INFILE '$outfile' INTO TABLE $table_name ",
            "FIELDS OPTIONALLY ENCLOSED BY '\\'';\n";
        close $out_fh or die "Can't close filehandle: $!\n";
    }
    else {
        print "\n";
    }
}
;
