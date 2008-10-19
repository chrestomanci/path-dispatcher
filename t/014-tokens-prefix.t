#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;
use Path::Dispatcher;

my @calls;

my $rule = Path::Dispatcher::Rule::Tokens->new(
    tokens => ['foo', 'bar'],
    block  => sub { push @calls, [$1, $2, $3] },
    prefix => 1,
);

ok(!$rule->match('foo'), "prefix means the rule matches a prefix of the path, not the other way around");
ok($rule->match('foo bar'), "prefix matches the full path");
ok($rule->match('foo bar baz'), "prefix matches a prefix of the path");

is_deeply($rule->match('foo bar baz'), ["foo", "bar"], "match returns just the results");
is_deeply([$rule->_match('foo bar baz')], [
    ["foo", "bar"],
    "baz"
], "_match returns the results and the rest of the path");
