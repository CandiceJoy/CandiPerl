#!/usr/bin/env perl
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'Candi::CandiLib',
    VERSION_FROM    => 'lib/CandiLib/CandiLib.pm'
);