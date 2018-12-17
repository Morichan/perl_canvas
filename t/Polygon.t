use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::Mock::Guard;

use diagram::Polygon;

use diagram::Point;
use diagram::FigureDrawer;
use diagram::Figure;
use diagram::Line;

use_ok $_ for qw/diagram::Polygon/;

my $obj;

subtest q{draw関数を利用しようとしても死なない} => sub {
    $obj = Polygon->new;

    lives_ok { $obj->draw } "draw() is implemented.";
};

subtest q{draw関数を保持している} => sub {
    $obj = Polygon->new;

    can_ok $obj, "draw";
};

subtest q{Figureインタフェースを継承している} => sub {
    $obj = Polygon->new;

    isa_ok $obj, "Figure";
};

subtest q{FigureDrawer抽象クラスを継承している} => sub {
    $obj = Polygon->new;

    isa_ok $obj, "FigureDrawer";
};

subtest q{初期値を返す} => sub {
    $obj = Polygon->new;
    my $expected = [];

    my $actual = $obj->lines;

    is_deeply $actual, $expected;
};

subtest q{設定値を返す} => sub {
    $obj = Polygon->new;
    my $expected = [
        Line->new(Point->new(3, 5), Point->new(7, 5)),
        Line->new(Point->new(7, 5), Point->new(5, 9)),
        Line->new(Point->new(5, 9), Point->new(3, 5)) ];

    $obj->lines([
        Line->new(Point->new(3, 5), Point->new(7, 5)),
        Line->new(Point->new(7, 5), Point->new(5, 9)),
        Line->new(Point->new(5, 9), Point->new(3, 5)) ]);
    my $actual = $obj->lines;

    is_deeply $actual, $expected;
};

subtest q{linesを計算する} => sub {
    $obj = Polygon->new;
    my $expected = [
        Line->new(Point->new(3, 5), Point->new(7, 5)),
        Line->new(Point->new(7, 5), Point->new(5, 9)),
        Line->new(Point->new(5, 9), Point->new(3, 5)) ];

    $obj->create_lines([ Point->new(3, 5), Point->new(7, 5), Point->new(5, 9) ]);
    my $actual = $obj->lines;

    is_deeply $actual, $expected;
};

subtest q{drawではlineオブジェクトのdrawをlinesの要素数回実行する} => sub {
    my $mocked = Line->new;
    my $obj = Polygon->new;
    my $mock = mock_guard $mocked => {
        draw => "ok"
    };

    $obj->lines([$mocked, $mocked, $mocked]);
    $obj->draw;

    is $mock->call_count($mocked, "draw"), 3;
};

done_testing;
