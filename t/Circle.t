use strict;
use warnings;
use Test::More;
use Test::Exception;

use diagram::Circle;

use diagram::Point;
use diagram::FigureDrawer;
use diagram::Figure;

use_ok $_ for qw/diagram::Circle/;

my $obj;

subtest q{draw関数を利用しようとしても死なない} => sub {
    $obj = Circle->new;

    lives_ok { $obj->draw } "draw() is implemented.";
};

subtest q{draw関数を保持している} => sub {
    $obj = Circle->new;

    can_ok $obj, "draw";
};

subtest q{Figureインタフェースを継承している} => sub {
    $obj = Circle->new;

    isa_ok $obj, "Figure";
};

subtest q{FigureDrawer抽象クラスを継承している} => sub {
    $obj = Circle->new;

    isa_ok $obj, "FigureDrawer";
};

subtest q{初期値の半径の値を取得する} => sub {
    my $expected = 0;
    $obj = Circle->new;

    my $actual = $obj->radius;

    is_deeply $actual, $expected;
};

subtest q{設定した半径の値を取得する} => sub {
    my $expected = 1;
    $obj = Circle->new;

    $obj->radius(1);
    my $actual = $obj->radius;

    is_deeply $actual, $expected;
};

subtest q{初期値の中央座標の値を取得する} => sub {
    my $expected = Point->new;
    $obj = Circle->new;

    my $actual = $obj->center;

    is_deeply $actual, $expected;
};

subtest q{設定した中央座標の値を取得する} => sub {
    my $expected = Point->new(4, 3);
    $obj = Circle->new;

    $obj->center(Point->new(4, 3));
    my $actual = $obj->center;

    is_deeply $actual, $expected;
};

subtest q{upper_leftとbottom_rightが正方形の場合の中央座標を計算する} => sub {
    my $expected = Point->new(2, 3);
    $obj = Circle->new;

    $obj->upper_left(Point->new(1, 2));
    $obj->bottom_right(Point->new(3, 4));
    $obj->calculate_circle;
    my $actual = $obj->center;

    is_deeply $actual, $expected;
};

subtest q{upper_leftとbottom_rightが縦長長方形の場合の中央座標を計算する} => sub {
    my $expected = Point->new(2, 4);
    $obj = Circle->new;

    $obj->upper_left(Point->new(1, 1));
    $obj->bottom_right(Point->new(3, 7));
    $obj->calculate_circle;
    my $actual = $obj->center;

    is_deeply $actual, $expected;
};

subtest q{upper_leftとbottom_rightが横長長方形の場合の中央座標を計算する} => sub {
    my $expected = Point->new(4, 3);
    $obj = Circle->new;

    $obj->upper_left(Point->new(0, 1));
    $obj->bottom_right(Point->new(8, 5));
    $obj->calculate_circle;
    my $actual = $obj->center;

    is_deeply $actual, $expected;
};

subtest q{upper_leftとbottom_rightが正方形の場合の半径を計算する} => sub {
    my $expected = 1;
    $obj = Circle->new;

    $obj->upper_left(Point->new(1, 2));
    $obj->bottom_right(Point->new(3, 4));
    $obj->calculate_circle;
    my $actual = $obj->radius;

    is_deeply $actual, $expected;
};

subtest q{upper_leftとbottom_rightが縦長長方形の場合の短径を半径として計算する} => sub {
    my $expected = 1;
    $obj = Circle->new;

    $obj->upper_left(Point->new(1, 1));
    $obj->bottom_right(Point->new(3, 7));
    $obj->calculate_circle;
    my $actual = $obj->radius;

    is_deeply $actual, $expected;
};

subtest q{upper_leftとbottom_rightが横長長方形の場合の短径を半径として計算する} => sub {
    my $expected = 2;
    $obj = Circle->new;

    $obj->upper_left(Point->new(0, 1));
    $obj->bottom_right(Point->new(8, 5));
    $obj->calculate_circle;
    my $actual = $obj->radius;

    is_deeply $actual, $expected;
};

done_testing;
