package FigureDrawer;

use strict;
use warnings;

use diagram::Point;
use diagram::Figure;
use base qw/ Figure /;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new();
    $self->{upper_left} = Point->new;
    $self->{bottom_right} = Point->new;
    bless $self, $class;
}

sub upper_left {
    my $self = shift;
    if (@_) {
        $self->{upper_left} = $_[0];
    }
    return $self->{upper_left};
}

sub bottom_right {
    my $self = shift;
    if (@_) {
        $self->{bottom_right} = $_[0];
    }
    return $self->{bottom_right};
}

1;
