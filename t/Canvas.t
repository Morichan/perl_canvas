use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::Mock::Guard;

use Canvas;

use_ok $_ for qw/Canvas/;

my $obj;

subtest q{Circleオブジェクトを生成する} => sub {
    $obj = Canvas->new;
    my $expected = Circle->new;

    $obj->create_figure(Shape->Circle);
    my $actual = $obj->figures->[0];

    is_deeply $actual, $expected;
};

subtest q{Lineオブジェクトを生成する} => sub {
    $obj = Canvas->new;
    my $expected = Line->new;

    $obj->create_figure(Shape->Line);
    my $actual = $obj->figures->[0];

    is_deeply $actual, $expected;
};

subtest q{Quadrangleオブジェクトを生成する} => sub {
    $obj = Canvas->new;
    my $expected = Quadrangle->new;

    $obj->create_figure(Shape->Quadrangle);
    my $actual = $obj->figures->[0];

    is_deeply $actual, $expected;
};

subtest q{Polygonオブジェクトを生成する} => sub {
    $obj = Canvas->new;
    my $expected = Polygon->new;

    $obj->create_figure(Shape->Polygon);
    my $actual = $obj->figures->[0];

    is_deeply $actual, $expected;
};

subtest q{オブジェクトを生成した順に取得する} => sub {
    $obj = Canvas->new;
    my $expected = [
        "Polygon",
        "Circle",
        "Line",
        "Quadrangle",
        "Polygon",
        "Polygon",
        "Line",
        "Quadrangle",
        "Quadrangle",
        "Polygon",
    ];

    my $shapes = [
        Shape->Polygon,
        Shape->Circle,
        Shape->Line,
        Shape->Quadrangle,
        Shape->Polygon,
        Shape->Polygon,
        Shape->Line,
        Shape->Quadrangle,
        Shape->Quadrangle,
        Shape->Polygon,
    ];

    $obj->create_figure($_) foreach @$shapes;

    is @{$obj->figures}, @$expected;

    for (my $i = 0; $i < @$expected; $i++) {
        isa_ok $obj->figures->[$i], $expected->[$i];
    }
};

subtest q{drawではfiguresの各drawを要素数回実行する} => sub {
    $obj = Canvas->new;
    my $mocked_circle = Circle->new;
    my $mocked_line = Line->new;
    my $mocked_quadrangle = Quadrangle->new;
    my $mocked_polygon = Polygon->new;
    my $mock_circle = mock_guard $mocked_circle => {
        draw => "circle drawn"
    };
    my $mock_line = mock_guard $mocked_line => {
        draw => "line drawn"
    };
    my $mock_quadrangle = mock_guard $mocked_quadrangle => {
        draw => "quadrangle drawn"
    };
    my $mock_polygon = mock_guard $mocked_polygon => {
        draw => "polygon drawn"
    };

    $obj->figures([
            $mocked_line,
            $mocked_polygon,
            $mocked_line,
            $mocked_circle,
            $mocked_line,
            $mocked_quadrangle,
            $mocked_circle,
            $mocked_circle,
            $mocked_quadrangle,
            $mocked_line
        ]);
    $obj->draw;

    is $mock_circle->call_count($mocked_circle, "draw"), 3;
    is $mock_line->call_count($mocked_line, "draw"), 4;
    is $mock_quadrangle->call_count($mocked_quadrangle, "draw"), 2;
    is $mock_polygon->call_count($mocked_polygon, "draw"), 1;
};

done_testing;
