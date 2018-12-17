package Figure;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
}

sub draw {
    my $self = shift;
    die "Please override!!\n";
}

1;
