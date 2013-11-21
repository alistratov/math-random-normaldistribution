#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Math::Random::NormalDistribution' ) || print "Bail out!\n";
}

diag( "Testing Math::Random::NormalDistribution $Math::Random::NormalDistribution::VERSION, Perl $], $^X" );
