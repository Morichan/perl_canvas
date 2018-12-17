package Polygon;

use strict;
use warnings;

use diagram::FigureDrawer;
use base qw/ FigureDrawer /;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new();
    $self->{lines} = [];
    bless $self, $class;
}

sub draw {
    my $self = shift;

    $_->draw foreach @{$self->lines};
}

sub create_lines {
    my $self = shift;
    my $points = shift;
    return if not ref($points) eq "ARRAY";
    $_->isa("Point") or return foreach @$points;

    my $ref = [];
    my $before_point = $points->[0];
    push @$points, $before_point;

    for (my $i = 1; $i < @$points; $i++) {
        my $point = $points->[$i];
        push @{$ref}, Line->new($before_point, $point);
        $before_point = $point;
    }

    $self->lines($ref);
}

# アクセサ
sub lines {
    my $self = shift;
    if (@_) {
        $self->{lines} = $_[0];
    }
    return $self->{lines};
}

1;
