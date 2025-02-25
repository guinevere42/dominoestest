#!/usr/bin/env perl

use strict;
use Test::Most;
use Test::Mojo;

my $t = Test::Mojo->new('BeanTest');

my $response = $t->get_ok('/');
$response->status_is(200);

done_testing();
