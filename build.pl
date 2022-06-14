#!/usr/bin/perl
use strict;
use warnings;
use Module::Build;

use 5.008;

my $builder = Module::Build->new(
    module_name        => "CandiLib",
    license            => "MIT",
    dist_author        => "CandiceJoy",
    dist_abstract      => "Candi Perl Lib",
    create_makefile_pl => 0,
    script_files       => 'script/app.pl',
    create_readme      => 0,
    requires           => { "Data::Dumper" => "0" },
    build_requires     => { "Data::Dumper" => "0" },
    meta_merge         => {
        resources => {
            repository => 'https://github.com/CandiceJoy/CandiPerl',
            bugtracker => 'https://github.com/szabgab/CandiPerl/issues'
        }
    },

);

$builder->create_build_script();