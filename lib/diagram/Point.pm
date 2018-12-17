package Point;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        x => 0,
        y => 0
    };

    if (@_ == 2) {
        $self->{x} = shift;
        $self->{y} = shift;
    }

    bless $self, $class;
}

sub update {
    my $self = shift;

    if (@_ == 2) {
        $self->{x} = shift;
        $self->{y} = shift;
    }
}

sub x {
    my $self = shift;
    if (@_) {
        $self->{x} = $_[0];
    }
    return $self->{x};
}

sub y {
    my $self = shift;
    if (@_) {
        $self->{y} = $_[0];
    }
    return $self->{y};
}

1;
