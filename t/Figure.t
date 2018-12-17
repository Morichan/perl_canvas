use strict;
use warnings;
use Test::More;
use Test::Exception;

use diagram::Figure;

use_ok $_ for qw/diagram::Figure/;

subtest q{draw関数を利用しようとすると死ぬ} => sub {
    my $obj = Figure->new;

    dies_ok { $obj->draw } "draw() be had to implement by extends class.";
};

done_testing;
