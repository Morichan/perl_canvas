package Circle;

use strict;
use warnings;

use diagram::Point;
use diagram::FigureDrawer;
use base qw/ FigureDrawer /;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new();
    $self->{center} = Point->new;
    $self->{radius} = 0;
    bless $self, $class;
}

sub draw {
    my $self = shift;
    # 実装を記述
}

sub calculate_circle {
    my $self = shift;

    my $harf_width = ($self->bottom_right->x - $self->upper_left->x) / 2;
    my $harf_height = ($self->bottom_right->y - $self->upper_left->y) / 2;
    $self->center(Point->new(
            $harf_width + $self->upper_left->x,
            $harf_height + $self->upper_left->y,
        ));

    # 短径を半径として計算する
    my $radius = $harf_width < $harf_height
            ? $harf_width
            : $harf_height;
    $self->radius($radius);
}

# アクセサ
sub radius {
    my $self = shift;
    if (@_) {
        $self->{radius} = $_[0];
    }
    return $self->{radius};
}

sub center {
    my $self = shift;
    if (@_) {
        $self->{center} = $_[0];
    }
    return $self->{center};
}

1;
