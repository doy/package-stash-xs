use strict;
use warnings;
use Test::More;
BEGIN {
  # shut up the debugger
  $ENV{PERLDB_OPTS} = 'NonStop';
}

BEGIN {

#line 1
#!/usr/bin/perl -d
#line 14

}

use Package::Stash::XS;

use Devel::Peek;

eval {
    Package::Stash::XS->new('Package::Stash::XS');
};

is $@, '',
    'no errors getting stash under debugger';

__END__
my $utf8_package = eval q{"Package::WithUnicode\x{7EF4}::Characters"};

eval {
    Package::Stash::XS->new($utf8_package);
};

like $@, qr/is not a module name/,
    'Unicode characters in stash names rejected';

done_testing;
