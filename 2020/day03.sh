#!/bin/sh

# done in Perl

# part 1
#    import 'sum'; init $i so we end up in the right place :D; map over input with mutable $i
perl -MList::Util=sum -le 'my @lines = <STDIN>; chomp @lines; our $i = -3; print sum map {our $i; substr($_, ($i+=3) % length, 1) eq "#"} @lines' < day3.txt

# part 2
PART2=$(cat <<- 'EOF'
my @lines = <STDIN>;
chomp @lines;

sub count_trees {
    my ($arg) = @_;
    my ($right, $down) = @$arg;

    my $count = 0;
    my $col = 0;

    for (my $row = 0; $row < @lines; $row += $down) { 
        my $line = $lines[$row];
        $count += substr($line, $col % length $line, 1) eq "#";
        $col += $right
    }

    return $count;
}

my @deltas = ([1,1], [3,1], [5,1], [7,1], [1,2]);
print product map {count_trees($_)} @deltas;
EOF
)

perl -MList::Util=product -le "$PART2" < day3.txt
