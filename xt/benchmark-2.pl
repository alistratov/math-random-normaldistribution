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


Benchmark: timing 10000000 iterations of adv, adv_p, base, g, g_p...
       adv: 10 wallclock secs (10.33 usr +  0.00 sys = 10.33 CPU) @ 968054.21/s (n=10000000)
     adv_p: 11 wallclock secs ( 9.82 usr +  0.00 sys =  9.82 CPU) @ 1018329.94/s (n=10000000)
      base:  6 wallclock secs ( 5.36 usr +  0.00 sys =  5.36 CPU) @ 1865671.64/s (n=10000000)
         g:  5 wallclock secs ( 5.83 usr +  0.00 sys =  5.83 CPU) @ 1715265.87/s (n=10000000)
       g_p:  5 wallclock secs ( 5.84 usr +  0.00 sys =  5.84 CPU) @ 1712328.77/s (n=10000000)
