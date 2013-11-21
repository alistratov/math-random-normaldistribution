#!/usr/bin/perl -w

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------

use strict;
use warnings;

use FindBin qw($Bin);
use lib ("$Bin/../lib");

use Math::Random::NormalDistribution;

use Benchmark qw(timethese);

&main();
# ------------------------------------------------------------------------------
sub main
{
    my $count = 10_000_000;

    my $g1 = Math::Random::NormalDistribution::gen_nd_1();
    my $g2 = Math::Random::NormalDistribution::gen_nd_2();

    timethese($count, {
        'v1'  => sub { Math::Random::NormalDistribution::nd_1() },
        'v2'  => sub { Math::Random::NormalDistribution::nd_2() },
        'gv1' => sub { $g1->() },
        'gv2' => sub { $g2->() },
    });
}
# ------------------------------------------------------------------------------
1;
