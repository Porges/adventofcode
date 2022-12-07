my $line = <>;
my $len = 14;
# zero-width pattern forces all matches including overlap
while ($line =~ /(?=(.{$len}))/g) {
    my %chars;
    next if grep { ++$chars{$_} == 2 } split '', $1;
    print $1 . ": " . ($+[0] + $len) . "\n";
    last;
}
