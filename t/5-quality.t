#!/usr/bin/perl -w

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------

use strict;
use warnings;

use Test::More;

unless ($ENV{ALLOW_NONDETERMINISTIC_TESTS}) {
    plan skip_all => "Developer tests not required for installation";
}

eval "use Statistics::Descriptive 3.0200";
if ($@) {
    plan skip_all => "Statistics::Descriptive 3.0200 required for testing randomness quality";
}

use FindBin qw($Bin);
use lib ("$Bin/../lib");

use Math::Random::NormalDistribution;

&main();
# ------------------------------------------------------------------------------
sub main
{
    my $sets = [
        {
            times       => 10_000,
            mathexp     => undef,
            stddev      => undef,
            mean        => [ 0.0, 0.05 ],
            median      => [ 0.0, 0.05 ],
            variance    => [ 1.0, 0.10 ],
            skewness    => [ 0.0, 0.20 ],
            kurtosis    => [ 0.0, 0.20 ],
        },
        {
            times       => 10_000,
            mathexp     => 8.0,
            stddev      => 12.0,
            mean        => [   8.0, 0.40 ],
            median      => [   8.0, 0.40 ],
            variance    => [ 144.0, 5.00 ],
            skewness    => [   0.0, 0.20 ],
            kurtosis    => [   0.0, 0.20 ],
        },
        {
            times       => 10_000,
            mathexp     => -2.0,
            stddev      => 9.0,
            mean        => [  -2.0, 0.30 ],
            median      => [  -2.0, 0.30 ],
            variance    => [  81.0, 3.00 ],
            skewness    => [   0.0, 0.20 ],
            kurtosis    => [   0.0, 0.20 ],
        },
    ];

    plan tests => 5 * scalar(@$sets);

    my $i = 0;
    for my $s (@$sets) {

        my $g = rand_nd_generator($s->{mathexp}, $s->{stddev});
        my $stat = Statistics::Descriptive::Full->new;

        for (1 .. $s->{times}) {
            $stat->add_data($g->());
        }

        for my $metric (qw(mean median variance skewness kurtosis)) {
            ok(cmp_float($stat->$metric, $s->{$metric}->[0], $s->{$metric}->[1]), "Set $i " . ucfirst($metric));
            #print ucfirst($metric) . ': ' . $stat->$metric . "\n";
        }
        $i++;
    }
}
# ------------------------------------------------------------------------------
sub cmp_float
{
    my ($val, $etalon, $diff) = @_;
    return (abs($val - $etalon) < $diff);
}
# ------------------------------------------------------------------------------
1;
