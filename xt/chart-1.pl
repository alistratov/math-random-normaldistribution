#!/usr/bin/perl -w

# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------

use strict;
use warnings;

use FindBin qw($Bin);
use lib ("$Bin/../lib");

use Math::Random::NormalDistribution;

&main();
# ------------------------------------------------------------------------------
sub main
{
    my $LINES = 10;
    my $TIMES = $LINES * 15;

    my @count = (0) x $LINES;
    my $generator = rand_nd_generator($LINES / 2, $LINES / 6);

    for (1 .. $TIMES) {
        my $x = $generator->();
        my $idx = int($x);
        next if $idx < 0 || $idx >= $LINES;
        $count[$idx]++;
    }

    print '|' x $_, "\n" for (@count);

    #my @nums = map { $generator->() } (1..10);
    #print join("\n", (@nums, ''));

}
# ------------------------------------------------------------------------------
1;
__END__
