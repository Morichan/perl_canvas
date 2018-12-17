use strict;
use warnings;
use Test::More;
use Test::Exception;

use diagram::Point;
use diagram::FigureDrawer;
use diagram::Figure;

use_ok $_ for qw/diagram::FigureDrawer/;

my $obj;

subtest q{draw関数を利用しようとすると死ぬ} => sub {
    $obj = FigureDrawer->new;

    dies_ok { $obj->draw } "draw() be had to implement by extends class.";
};

subtest q{draw関数を保持している} => sub {
    $obj = FigureDrawer->new;

    can_ok $obj, "draw";
};

subtest q{Figureインタフェースを継承している} => sub {
    $obj = FigureDrawer->new;

    isa_ok $obj, "Figure";
};

subtest q{設定した左上隅の座標の値を取得する} => sub {
    my $expected = Point->new(2, 3);
    $obj = FigureDrawer->new;

    $obj->upper_left(Point->new(2, 3));
    my $actual = $obj->upper_left;

    is_deeply $actual, $expected;
};

subtest q{設定した右下隅の座標の値を取得する} => sub {
    my $expected = Point->new(8, 6);
    $obj = FigureDrawer->new;

    $obj->bottom_right(Point->new(8, 6));
    my $actual = $obj->bottom_right;

    is_deeply $actual, $expected;
};

done_testing;
