use strict;
use warnings;
use Test::More;

use diagram::Point;

use_ok $_ for qw/diagram::Point/;

subtest q{初期値を取得できる} => sub {
    my $expected = 0;

    my $actual = Point->new;

    is $actual->x, $expected;
    is $actual->y, $expected;
};

subtest q{初期設定値を取得できる} => sub {
    my $expected = {x => 10, y => 15};

    my $actual = Point->new(10, 15);

    is $actual->x, $expected->{x};
    is $actual->y, $expected->{y};
};

subtest q{設定値を取得できる} => sub {
    my $expected = {x => 8, y => 4};

    my $actual = Point->new;
    $actual->update(8, 4);

    is $actual->x, $expected->{x};
    is $actual->y, $expected->{y};
};

done_testing;
