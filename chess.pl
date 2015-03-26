use warnings;
use strict;
use Board;
use Pieces;
use Game;

my $board = Board->new();
my $piece1 = Rook->new(posx => 1, posy => 1, board => $board);
my $piece2 = Rook->new(posx => 8, posy => 1, board => $board, white => 1);
my $piece3 = King->new(posx => 5, posy => 1, board => $board);
$board->add_pieces([$piece1,$piece2,$piece3]);

print "{";
for ( @{$piece3->pot_moves()}) {
  print "{" . join(', ',@{$_})  . "},";
};
print "\b}\n";


__END__
my $spaces = $board->spaces;
for my $x (1..8) {
  for my $y (1..8) {
    my $space = $board->get_space([$x,$y]);
    print "occupation of space is " . $space->occupied . "\n";# if $space->piece;
  }
}
