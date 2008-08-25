#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;
use Path::Dispatcher;

my @calls;

my $dispatcher = Path::Dispatcher->new;
for my $stage (qw/first on last/) {
    for my $number (qw/first second/) {
        $dispatcher->stage($stage)->add_rule(
            Path::Dispatcher::Rule::Regex->new(
                regex => qr/foo/,
                block => sub { push @calls, "$stage: $number" },
            ),
        );
    }
}

$dispatcher->run('foo');
is_deeply(\@calls, [
    'first: first',
    'on: first',
    'last: first',
]);
