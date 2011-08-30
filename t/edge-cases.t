#!/usr/bin/env perl
use strict;
use warnings;
use lib 't/lib';
use Test::More;
use Test::Fatal;

use Package::Stash;

{
    package Foo;
    use constant FOO => 1;
    use constant BAR => \1;
    use constant BAZ => [];
    use constant QUUX => {};
    use constant QUUUX => sub { };
    sub normal { }
    sub stub;
    sub normal_with_proto () { }
    sub stub_with_proto ();

    our $SCALAR;
    our $SCALAR_WITH_VALUE = 1;
    our @ARRAY;
    our %HASH;
}

my $stash = Package::Stash->new('Foo');
{ local $TODO = $] < 5.010
      ? "undef scalars aren't visible on 5.8"
      : undef;
ok($stash->has_symbol('$SCALAR'), '$SCALAR');
}
ok($stash->has_symbol('$SCALAR_WITH_VALUE'), '$SCALAR_WITH_VALUE');
ok($stash->has_symbol('@ARRAY'), '@ARRAY');
ok($stash->has_symbol('%HASH'), '%HASH');
is_deeply(
    [sort $stash->list_all_symbols('CODE')],
    [qw(BAR BAZ FOO QUUUX QUUX normal normal_with_proto stub stub_with_proto)],
    "can see all code symbols"
);

$stash->add_symbol('%added', {});
ok(!$stash->has_symbol('$added'), '$added');
ok(!$stash->has_symbol('@added'), '@added');
ok($stash->has_symbol('%added'), '%added');

my $constant = $stash->get_symbol('&FOO');
is(ref($constant), 'CODE', "expanded a constant into a coderef");

# ensure get doesn't prevent subsequent vivification (not sure what the deal
# was here)
is(ref($stash->get_symbol('$glob')), '', "nothing yet");
is(ref($stash->get_or_add_symbol('$glob')), 'SCALAR', "got an empty scalar");

done_testing;
