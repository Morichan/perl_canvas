use strict;
use warnings;
use Test::More;

use diagram::Shape;

use_ok $_ for qw/diagram::Shape/;

my $shape = Shape->new;

subtest q{$B<hF@$7$?(BCircle$B$NCM$,Ey$7$$$3$H$r3NG'$9$k(B} => sub {
    my $expected = Shape->Circle;

    my $actual = $shape->Circle;

    is $actual, $expected;
};

subtest q{$B<hF@$7$?(BLine$B$NCM$,Ey$7$$$3$H$r3NG'$9$k(B} => sub {
    my $expected = Shape->Line;

    my $actual = $shape->Line;

    is $actual, $expected;
};

subtest q{$B<hF@$7$?(BQuadrangle$B$NCM$,Ey$7$$$3$H$r3NG'$9$k(B} => sub {
    my $expected = Shape->Quadrangle;

    my $actual = $shape->Quadrangle;

    is $actual, $expected;
};

subtest q{$B<hF@$7$?(BPolygon$B$NCM$,Ey$7$$$3$H$r3NG'$9$k(B} => sub {
    my $expected = Shape->Polygon;

    my $actual = $shape->Polygon;

    is $actual, $expected;
};

done_testing;
