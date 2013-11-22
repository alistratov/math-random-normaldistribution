#!/usr/bin/perl -w

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------

use strict;
use warnings;

use Benchmark qw(timethese);

&main();
# ------------------------------------------------------------------------------
sub main
{
    my $count = 10_000_000;

    my $g = rand_nd_gen();
    my $g_p = rand_nd_gen(10, 20);

    timethese($count, {
        'base'  => sub { rand_nd_base() },
        'adv'   => sub { rand_nd() },
        'g'     => sub { $g->() },
        'adv_p' => sub { rand_nd(10, 20) },
        'g_p'   => sub { $g_p->() },
    });
}
# ------------------------------------------------------------------------------
use constant TWOPI => 2.0 * 4.0 * atan2(1.0, 1.0);

sub rand_nd_base()
{
    return cos(TWOPI * (1.0 - rand)) * sqrt(-2.0 * log(1.0 - rand));
}

sub rand_nd(;@)
{
    my ($mean, $stddev) = @_;

    $mean = 0.0 if ! defined $mean;
    $stddev = 1.0 if ! defined $stddev;
    return $mean + $stddev * cos(TWOPI * (1.0 - rand)) * sqrt(-2.0 * log(1.0 - rand));
}

sub rand_nd_gen(;@)
{
    my ($mean, $stddev) = @_;
    $mean = 0.0 if ! defined $mean;
    $stddev = 1.0 if ! defined $stddev;

    return sub {
        return $mean + $stddev * cos(TWOPI * (1.0 - rand)) * sqrt(-2.0 * log(1.0 - rand));
    }
}
# ------------------------------------------------------------------------------
1;
__END__
