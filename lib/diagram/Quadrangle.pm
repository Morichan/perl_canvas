package Quadrangle;

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

sub calculate_lines {
    my $self = shift;

    my $expected_top = Line->new(
        Point->new($self->upper_left->x, $self->upper_left->y),
        Point->new($self->bottom_right->x, $self->upper_left->y) );
    my $expected_right = Line->new(
        Point->new($self->bottom_right->x, $self->upper_left->y),
        Point->new($self->bottom_right->x, $self->bottom_right->y) );
    my $expected_bottom = Line->new(
        Point->new($self->bottom_right->x, $self->bottom_right->y),
        Point->new($self->upper_left->x, $self->bottom_right->y) );
    my $expected_left = Line->new(
        Point->new($self->upper_left->x, $self->bottom_right->y),
        Point->new($self->upper_left->x, $self->upper_left->y) );

    $self->lines([]);
    push @{$self->lines}, $expected_top;
    push @{$self->lines}, $expected_right;
    push @{$self->lines}, $expected_bottom;
    push @{$self->lines}, $expected_left;
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
