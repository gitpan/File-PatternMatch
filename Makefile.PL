#!/usr/bin/perl
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile1(
    META_MERGE => {
        resources => {
            repository => 'https://github.com/trapd00r/File-PatternMatch',
            bugtracker => 'https://github.com/trapd00r/File-PatternMatch/issues',
        },
    },
    #BUILD_REQUIRES => {
    #},

    NAME                => 'File::PatternMatch',
    AUTHOR              => q{Magnus Woldrich <trapd00r@trapd00r.se>},
    ABSTRACT_FROM       => 'lib/File/PatternMatch.pm',
    VERSION_FROM        => 'lib/File/PatternMatch.pm',
    'LICENSE'           => 'perl',
    PL_FILES            => {},
    PREREQ_PM => {
      'Term::ExtendedColor' => 0.16,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'File-PatternMatch-*' },
);

#Written by Alexandr Ciornii, version 0.23. Added by eumm-upgrade.
sub WriteMakefile1 {
    my %params=@_;
    my $eumm_version=$ExtUtils::MakeMaker::VERSION;
    $eumm_version=eval $eumm_version;
    die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
    die "License not specified" if not exists $params{LICENSE};
    if ($params{AUTHOR} and ref($params{AUTHOR}) eq 'ARRAY'
        and $eumm_version < 6.5705) {
          $params{META_ADD}->{author}=$params{AUTHOR};
          $params{AUTHOR}=join(', ',@{$params{AUTHOR}});
    }
    if ($params{BUILD_REQUIRES} and $eumm_version < 6.5503) {
        #EUMM 6.5502 has problems with BUILD_REQUIRES
        $params{PREREQ_PM}={
          %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}}
        };
        delete $params{BUILD_REQUIRES};
    }
    delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
    delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
    delete $params{META_MERGE} if $eumm_version < 6.46;
    delete $params{META_ADD} if $eumm_version < 6.46;
    delete $params{LICENSE} if $eumm_version < 6.31;
    delete $params{AUTHOR} if $] < 5.005;
    delete $params{ABSTRACT_FROM} if $] < 5.005;
    delete $params{BINARY_LOCATION} if $] < 5.005;

    WriteMakefile(%params);
}

