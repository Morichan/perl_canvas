use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::Mock::Guard;

use diagram::Quadrangle;

use diagram::Point;
use diagram::FigureDrawer;
use diagram::Figure;
use diagram::Line;

use_ok $_ for qw/diagram::Quadrangle/;

my $obj;

subtest q{draw関数を利用しようとしても死なない} => sub {
    $obj = Quadrangle->new;

    lives_ok { $obj->draw } "draw() is implemented.";
};

subtest q{draw関数を保持している} => sub {
    $obj = Quadrangle->new;

    can_ok $obj, "draw";
};

subtest q{Figureインタフェースを継承している} => sub {
    $obj = Quadrangle->new;

    isa_ok $obj, "Figure";
};

subtest q{FigureDrawer抽象クラスを継承している} => sub {
    $obj = Quadrangle->new;

    isa_ok $obj, "FigureDrawer";
};

subtest q{初期値を返す} => sub {
    $obj = Quadrangle->new;
    my $expected = [];

    my $actual = $obj->lines;

    is_deeply $actual, $expected;
};

subtest q{設定値を返す} => sub {
    $obj = Quadrangle->new;
    my $expected = [
        Line->new(Point->new(3, 5), Point->new(7, 5)),
        Line->new(Point->new(7, 5), Point->new(7, 9)),
        Line->new(Point->new(7, 9), Point->new(3, 9)),
        Line->new(Point->new(3, 9), Point->new(3, 5)) ];

    $obj->lines([
        Line->new(Point->new(3, 5), Point->new(7, 5)),
        Line->new(Point->new(7, 5), Point->new(7, 9)),
        Line->new(Point->new(7, 9), Point->new(3, 9)),
        Line->new(Point->new(3, 9), Point->new(3, 5)) ]);
    my $actual = $obj->lines;

    is_deeply $actual, $expected;
};

subtest q{lineを4つ生成する} => sub {
    $obj = Quadrangle->new;
    my $expected_top = Line->new(Point->new(3, 5), Point->new(7, 5));
    my $expected_right = Line->new(Point->new(7, 5), Point->new(7, 9));
    my $expected_bottom = Line->new(Point->new(7, 9), Point->new(3, 9));
    my $expected_left = Line->new(Point->new(3, 9), Point->new(3, 5));

    $obj->upper_left(Point->new(3, 5));
    $obj->bottom_right(Point->new(7, 9));
    $obj->calculate_lines;
    my $actual = $obj->lines;

    is_deeply $actual->[0], $expected_top;
    is_deeply $actual->[1], $expected_right;
    is_deeply $actual->[2], $expected_bottom;
    is_deeply $actual->[3], $expected_left;
};

subtest q{drawではlineオブジェクトのdrawを4回実行する} => sub {
    my $mocked = Line->new;
    my $obj = Quadrangle->new;
    my $mock = mock_guard $mocked => {
        draw => "ok"
    };

    $obj->lines([$mocked, $mocked, $mocked, $mocked]);
    $obj->draw;

    is $mock->call_count($mocked, "draw"), 4;
};

done_testing;
