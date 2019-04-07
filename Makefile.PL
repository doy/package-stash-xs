# This module uses Dist::Zilla for development. This Makefile.PL will let you
# run the tests, but you are encouraged to install Dist::Zilla and the needed
# plugins if you intend on doing any serious hacking.

use strict;
use warnings;

use ExtUtils::MakeMaker::Dist::Zilla::Develop;

WriteMakefile(
    NAME => 'Package::Stash::XS',
    VERSION_FROM => 'lib/Package/Stash/XS.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    NORECURS => 1,
);
