#!/usr/bin/env perl

use strict;
use Test::Most;
use Test::Mojo;

my $t = Test::Mojo->new('BeanTest');

my $response = $t->get_ok('/healthcheck');
$response->status_is(200);
$response->json_is('/status','ok');

done_testing();
