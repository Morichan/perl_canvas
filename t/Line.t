use strict;
use warnings;
use Test::More;
use Test::Exception;
use Test::Mock::Guard;

use diagram::Line;

use diagram::Point;
use diagram::FigureDrawer;
use diagram::Figure;

use_ok $_ for qw/diagram::Line/;

my $obj;

subtest q{draw関数を利用しようとしても死なない} => sub {
    $obj = Line->new;

    lives_ok { $obj->draw } "draw() is implemented.";
};

subtest q{draw関数を保持している} => sub {
    $obj = Line->new;

    can_ok $obj, "draw";
};

subtest q{Figureインタフェースを継承している} => sub {
    $obj = Line->new;

    isa_ok $obj, "Figure";
};

subtest q{FigureDrawer抽象クラスを継承している} => sub {
    $obj = Line->new;

    isa_ok $obj, "FigureDrawer";
};

subtest q{初期値の線の開始点の座標を取得する} => sub {
    $obj = Line->new;
    my $expected = Point->new;

    my $actual = $obj->begin;

    is_deeply $actual, $expected;
};

subtest q{設定した線の開始点の座標を取得する} => sub {
    $obj = Line->new;
    my $expected = Point->new(2, 4);

    $obj->begin(Point->new(2, 4));
    my $actual = $obj->begin;

    is_deeply $actual, $expected;
};

subtest q{初期値の線の終了点の座標を取得する} => sub {
    $obj = Line->new;
    my $expected = Point->new;

    my $actual = $obj->end;

    is_deeply $actual, $expected;
};

subtest q{設定した線の終了点の座標を取得する} => sub {
    $obj = Line->new;
    my $expected = Point->new(2, 1);

    $obj->end(Point->new(2, 1));
    my $actual = $obj->end;

    is_deeply $actual, $expected;
};

subtest q{引数0の際はdraw_without_paramsを実行する} => sub {
    my $obj = Line->new;
    my $mock = mock_guard $obj => {
        draw_without_params => "ok",
        draw_two_params => "ng"
    };

    $obj->draw;

    is $mock->call_count($obj, "draw_without_params"), 1;
    is $mock->call_count($obj, "draw_two_params"), 0;
};

subtest q{引数2つの際はdraw_two_paramsを実行する} => sub {
    my $obj = Line->new;
    my $mock = mock_guard $obj => {
        draw_without_params => "ng",
        draw_two_params => "ok"
    };

    $obj->draw(Point->new, Point->new);

    is $mock->call_count($obj, "draw_two_params"), 1;
};

subtest q{引数2つの際はbeginとendを更新する} => sub {
    my $obj = Line->new;
    my $expected_begin = Point->new(2, 4);
    my $expected_end = Point->new(3, 9);

    $obj->draw(Point->new(2, 4), Point->new(3, 9));

    is_deeply $obj->begin, $expected_begin;
    is_deeply $obj->end, $expected_end;
};

subtest q{引数にPointオブジェクト以外を入力した際はbeginとendを更新しない} => sub {
    my $obj = Line->new;
    my $expected_begin = Point->new(2, 4);
    my $expected_end = Point->new(3, 9);

    $obj->begin(Point->new(2, 4));
    $obj->end(Point->new(3, 9));

    $obj->draw(3, 9);

    is_deeply $obj->begin, $expected_begin;
    is_deeply $obj->end, $expected_end;
};

done_testing;
