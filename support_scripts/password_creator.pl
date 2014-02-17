#!/usr/bin/env perl

use strict;

my $salt=join '', ('.', '/', 0..9, 'A'..'Z', 'a'..'z')[rand 64, rand 64];
print crypt($ARGV[0],$salt), "\n";
