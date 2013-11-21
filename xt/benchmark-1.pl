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

    my $g1 = gen_nd_1();
    my $g2 = gen_nd_2();
    my $go = gen_optnd_1();

    timethese($count, {
        'v1'    => sub { nd_1() },
        'v2'    => sub { nd_2() },
        'op'    => sub { optnd_1() },
        'gv1'   => sub { $g1->() },
        'gv2'   => sub { $g2->() },
        'gop'   => sub { $go->() },
    });
}
# ------------------------------------------------------------------------------
use constant PI => 4 * atan2(1, 1);

sub nd_1
{
    my $rho = 1.0 - rand; # distributed in the interval ( 0; +1 ]
    my $phi = 1.0 - rand;

    my $s = 2.0 * PI * $phi;
    my $t = sqrt(-2.0 * log($rho));

    my $v1 = cos($s) * $t;
    my $v2 = sin($s) * $t;

    return $v1;
}
sub nd_2
{
    my ($x, $y, $s);

    while (1) {
        $x = 1.0 - 2.0 * rand; # distributed in the interval ( -1; +1 ] wrong!!!
        $y = 1.0 - 2.0 * rand;

        $s = $x * $x + $y * $y;
        last if ($s > 0.0 && $s <= 1.0);
    }
    my $t = sqrt(-2.0 * log($s) / $s);

    my $v1 = $x * $t;
    my $v2 = $y * $t;

    return $v1;
}
sub gen_nd_1
{
    my $saved = undef;

    return sub {
	if (defined $saved) {
	    my $rv = $saved;
	    undef $saved;
	    return $rv;
	}
        else {
            my $rho = 1.0 - rand; # distributed in the interval ( 0; +1 ]
            my $phi = 1.0 - rand;

            my $s = 2.0 * PI * $phi;
            my $t = sqrt(-2.0 * log($rho));

            my $v1 = cos($s) * $t;
            $saved = sin($s) * $t;

            return $v1;
        }
    }
}
sub gen_nd_2
{
    my $saved = undef;

    return sub {
	if (defined $saved) {
	    my $rv = $saved;
	    undef $saved;
	    return $rv;
	}
        else {
            my ($x, $y, $s);

            while (1) {
                $x = 1.0 - 2.0 * rand; # distributed in the interval ( -1; +1 ] wrong!!!
                $y = 1.0 - 2.0 * rand;

                $s = $x * $x + $y * $y;
                last if ($s > 0.0 && $s <= 1.0);
            }
            my $t = sqrt(-2.0 * log($s) / $s);

            my $v1 = $x * $t;
            $saved = $y * $t;

            return $v1;
        }
    }
}
sub optnd_1
{
    return cos(2.0 * PI * (1.0 - rand)) * sqrt(-2.0 * log(1.0 - rand));
}
sub gen_optnd_1
{
    my $saved = undef;

    return sub {
	if (defined $saved) {
	    my $rv = $saved;
	    undef $saved;
	    return $rv;
	}
        else {
            my $s = 2.0 * PI * (1.0 - rand);
            my $t = sqrt(-2.0 * log(1.0 - rand));

            $saved = cos($s) * $t;
            return sin($s) * $t;
        }
    }
}
# ------------------------------------------------------------------------------
1;
__END__

Benchmark: timing 10000000 iterations of gop, gv1, gv2, op, v1, v2...
       gop: 10 wallclock secs ( 8.64 usr +  0.00 sys =  8.64 CPU) @ 1157407.41/s (n=10000000)
       gv1: 10 wallclock secs (10.29 usr +  0.01 sys = 10.30 CPU) @ 970873.79/s (n=10000000)
       gv2: 14 wallclock secs (13.19 usr +  0.01 sys = 13.20 CPU) @ 757575.76/s (n=10000000)
        op:  8 wallclock secs ( 8.13 usr +  0.02 sys =  8.15 CPU) @ 1226993.87/s (n=10000000)
        v1: 14 wallclock secs (14.93 usr +  0.01 sys = 14.94 CPU) @ 669344.04/s (n=10000000)
        v2: 21 wallclock secs (21.31 usr +  0.02 sys = 21.33 CPU) @ 468823.25/s (n=10000000)

