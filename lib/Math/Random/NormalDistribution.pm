package Math::Random::NormalDistribution;
# coding: UTF-8

use utf8;
use strict;
use warnings;

# ------------------------------------------------------------------------------
our $VERSION = '0.01';

use Exporter;
use base qw(Exporter);
our @EXPORT = qw(
    password_entropy
);
# ------------------------------------------------------------------------------
use constant PI => 4 * atan2(1, 1);
# ------------------------------------------------------------------------------
sub rand_nd_generator(;@)
{
    my ($mean, $stddev) = @_;

    my $saved = undef;

    return sub {

    };
}
sub rand_nd_generator_log(;@)
{
    my ($mean, $stddev) = @_;

    my $saved = undef;

    return sub {

    };
}
# ------------------------------------------------------------------------------
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
# ------------------------------------------------------------------------------
1;
__END__

=head1 NAME

Math::Random::NormalDistribution - The great new Math::Random::NormalDistribution!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Math::Random::NormalDistribution;

    my $foo = Math::Random::NormalDistribution->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Oleg Alistratov, C<< <zero at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-math-random-normaldistribution at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Math-Random-NormalDistribution>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Math::Random::NormalDistribution


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Math-Random-NormalDistribution>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Math-Random-NormalDistribution>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Math-Random-NormalDistribution>

=item * Search CPAN

L<http://search.cpan.org/dist/Math-Random-NormalDistribution/>

=back


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Oleg Alistratov.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Math::Random::NormalDistribution
