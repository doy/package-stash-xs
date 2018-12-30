package Package::Stash::XS;
use strict;
use warnings;
use 5.008001;
# ABSTRACT: faster and more correct implementation of the Package::Stash API

our $VERSION = '0.29';

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

=head1 BUGS

No known bugs (but see the BUGS section in L<Package::Stash>).

=head1 SEE ALSO

L<Package::Stash>

=head1 SUPPORT

You can find this documentation for this module with the perldoc command.

    perldoc Package::Stash::XS

You can also look for information at:

=over 4

=item * MetaCPAN

L<https://metacpan.org/release/Package-Stash-XS>

=item * Github

L<https://github.com/moose/Package-Stash-XS>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Package-Stash-XS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Package-Stash-XS>

=back

=begin Pod::Coverage

add_symbol
get_all_symbols
get_or_add_symbol
get_symbol
has_symbol
list_all_symbols
name
namespace
new
remove_glob
remove_symbol

=end Pod::Coverage

=cut

1;
