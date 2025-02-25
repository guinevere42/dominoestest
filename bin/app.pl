#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
use Schema;
use Mojolicious::Commands;

# Mojo home directory is one level up
# see Mojo::Home for how it detects the home directory
$ENV{MOJO_HOME} = "$FindBin::Bin/..";




my $schema = Schema->connect('dbi:SQLite:moblo.db');
$schema->storage->debug(1);
$schema->deploy();
#$schema->source('Schema::Jobs');

Mojolicious::Commands->start_app('BeanTest');



