package Shape;

use strict;
use warnings;

use enum qw/ circle line quadrangle polygon /;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
}

sub Circle {
    my $class = shift;
    return circle;
}

sub Line {
    my $class = shift;
    return line;
}

sub Quadrangle {
    my $class = shift;
    return quadrangle;
}

sub Polygon {
    my $class = shift;
    return polygon;
}

1;
