package Package::Stash::XS;
use strict;
use warnings;
# ABSTRACT: faster and more correct implementation of the Package::Stash API

use XSLoader;
XSLoader::load(
    __PACKAGE__,
    # we need to be careful not to touch $VERSION at compile time, otherwise
    # DynaLoader will assume it's set and check against it, which will cause
    # fail when being run in the checkout without dzil having set the actual
    # $VERSION
    exists $Package::Stash::XS::{VERSION}
        ? ${ $Package::Stash::XS::{VERSION} } : (),
);

=head1 SYNOPSIS

  use Package::Stash;

=head1 DESCRIPTION

This is a backend for L<Package::Stash>, which provides the functionality in a
way that's less buggy and much faster. It will be used by default if it's
installed, and should be preferred in all environments with a compiler.

=head1 BUGS / CAVEATS

=over 4

=item * On perl versions prior to 5.10, undefined package scalars will not show up as existing, due to shortcomings within perl.

=item * GLOB and FORMAT variables are not (yet) accessible through this module.

=back

Please report any bugs through RT: email
C<bug-package-stash-xs at rt.cpan.org>, or browse to
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Package-Stash-XS>.

=head1 SEE ALSO

=over 4

=item * L<Class::MOP::Package>

This module is a factoring out of code that used to live here

=back

=head1 SUPPORT

You can find this documentation for this module with the perldoc command.

    perldoc Package::Stash::XS

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Package-Stash-XS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Package-Stash-XS>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Package-Stash-XS>

=item * Search CPAN

L<http://search.cpan.org/dist/Package-Stash-XS>

=back

=head1 AUTHOR

Jesse Luehrs <doy at tozt dot net>

Based on code from L<Class::MOP::Package>, by Stevan Little and the Moose
Cabal.

=cut

1;
