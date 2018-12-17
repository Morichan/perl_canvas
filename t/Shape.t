use strict;
use warnings;
use Test::More;

use diagram::Shape;

use_ok $_ for qw/diagram::Shape/;

my $shape = Shape->new;

subtest q{取得したCircleの値が等しいことを確認する} => sub {
    my $expected = Shape->Circle;

    my $actual = $shape->Circle;

    is $actual, $expected;
};

subtest q{取得したLineの値が等しいことを確認する} => sub {
    my $expected = Shape->Line;

    my $actual = $shape->Line;

    is $actual, $expected;
};

subtest q{取得したQuadrangleの値が等しいことを確認する} => sub {
    my $expected = Shape->Quadrangle;

    my $actual = $shape->Quadrangle;

    is $actual, $expected;
};

subtest q{取得したPolygonの値が等しいことを確認する} => sub {
    my $expected = Shape->Polygon;

    my $actual = $shape->Polygon;

    is $actual, $expected;
};

done_testing;
