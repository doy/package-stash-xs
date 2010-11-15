package # hide from PAUSE
    Package::Stash;
use strict;
use warnings;

use Package::Stash::XS;

BEGIN {
    my $ps = Package::Stash::XS->new(__PACKAGE__);
    my $ps_xs = Package::Stash::XS->new('Package::Stash::XS');
    for my $method (qw(new name namespace add_symbol remove_glob has_symbol
                       get_symbol get_or_add_symbol remove_symbol
                       list_all_symbols get_all_symbols)) {
        my $sym = '&' . $method;
        $ps->add_symbol($sym => $ps_xs->get_symbol($sym));
    }
}

1;
