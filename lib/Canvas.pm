package Canvas;

use strict;
use warnings;

use diagram::Shape;
use diagram::Circle;
use diagram::Line;
use diagram::Quadrangle;
use diagram::Polygon;


sub new {
    my $class = shift;
    my $self = {
        figures => []
    };
    bless $self, $class;
}

sub create_figure {
    my ($self, $shape) = @_;

    if ($shape == Shape->Circle) {
        push @{$self->{figures}}, Circle->new;
    } elsif ($shape == Shape->Line) {
        push @{$self->{figures}}, Line->new;
    } elsif ($shape == Shape->Quadrangle) {
        push @{$self->{figures}}, Quadrangle->new;
    } elsif ($shape == Shape->Polygon) {
        push @{$self->{figures}}, Polygon->new;
    }
}

sub draw {
    my $self = shift;

    $_->draw foreach @{$self->figures};
}

# アクセサ
sub figures {
    my $self = shift;
    if (@_) {
        $self->{figures} = $_[0];
    }
    return $self->{figures};
}


1;
