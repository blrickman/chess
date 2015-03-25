use warnings;
use strict;
use Board;
use Pieces;
use Game;

my $board = Board->new();
my $piece2 = Rook->new(posx => 2, posy => 3, board => $board, white => 0);
my $piece = Pawn->new(posx =>1, posy => 2, board => $board);
$board->add_pieces([$piece,$piece2]);


print "{";
for ( @{$piece->pot_moves()}) {
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
