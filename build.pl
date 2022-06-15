#!/usr/bin/perl
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'Your::Module',
    VERSION_FROM    => 'lib/CandiLib/CandiLib.pm'
);