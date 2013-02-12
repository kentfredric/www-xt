use strict;
use warnings;

package XT::Web;

# ABSTRACT: Web Engine for the platform for world domination

use Web::Simple 'XT::Web';

require XT::Web::Controller::JSON;

sub dispatch_request {
  return (
    '/json...' => sub {
      XT::Web::Controller::JSON->dispatch_request(@_);
    },
  );
}

__PACKAGE__->run_if_script;
