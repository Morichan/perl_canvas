package Line;

use strict;
use warnings;

use diagram::Point;
use diagram::FigureDrawer;
use base qw/ FigureDrawer /;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new();
    $self->{begin} = Point->new;
    $self->{end} = Point->new;

    if (@_ == 2) {
        $self->begin($_[0]) if $_[0]->isa("Point");
        $self->end($_[1]) if $_[1]->isa("Point");
    }

    bless $self, $class;
}

sub draw {
    my $self = shift;

    if (@_ == 2) {
        # 引数が2つの実装を記述
        $self->draw_two_params($_[0], $_[1]);
    } else {
        # 引数が空の実装を記述
        $self->draw_without_params;
    }
}

sub draw_without_params {
    my $self = shift;
    # 実装する
}

sub draw_two_params {
    my $self = shift;
    my $begin = shift;
    my $end = shift;

    $self->begin($begin) if $begin->isa("Point");
    $self->end($end) if $end->isa("Point");

    $self->draw_without_params;
}

# アクセサ
sub begin {
    my $self = shift;
    if (@_) {
        $self->{begin} = $_[0];
    }
    return $self->{begin};
}

sub end {
    my $self = shift;
    if (@_) {
        $self->{end} = $_[0];
    }
    return $self->{end};
}

1;
