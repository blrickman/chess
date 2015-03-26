use warnings;
use strict;
use Board;
use Pieces;
use Game;

my $board = Board->new();
my (@p1,@p2,@p7,@p8);

$p1[0] = Rook->new(   posx => 1, posy => 1, board => $board);
$p1[1] = Knight->new( posx => 2, posy => 1, board => $board);
$p1[2] = Bishop->new( posx => 3, posy => 1, board => $board);
$p1[3] = Queen->new(  posx => 4, posy => 1, board => $board);
$p1[4] = King->new(   posx => 5, posy => 1, board => $board);
$p1[5] = Bishop->new( posx => 6, posy => 1, board => $board);
$p1[6] = Knight->new( posx => 7, posy => 1, board => $board);
$p1[7] = Rook->new(   posx => 8, posy => 1, board => $board);
$p2[$_]= Pawn->new(   posx => $_+1,posy => 2, board => $board) for (0..7);

$p8[0] = Rook->new(   posx => 1, posy => 8, board => $board, white => 0);
$p8[1] = Knight->new( posx => 2, posy => 8, board => $board, white => 0);
$p8[2] = Bishop->new( posx => 3, posy => 8, board => $board, white => 0);
$p8[3] = Queen->new(  posx => 4, posy => 8, board => $board, white => 0);
$p8[4] = King->new(   posx => 5, posy => 8, board => $board, white => 0);
$p8[5] = Bishop->new( posx => 6, posy => 8, board => $board, white => 0);
$p8[6] = Knight->new( posx => 7, posy => 8, board => $board, white => 0);
$p8[7] = Rook->new(   posx => 8, posy => 8, board => $board, white => 0);
$p7[$_]= Pawn->new(   posx => $_+1,posy => 7, board => $board, white => 0) for (0..7);

my @pieces = (@p1,@p2,@p7,@p8);
$board->add_pieces(\@pieces);

$p8[5]->move_to(2,1)


__END__
my $spaces = $board->spaces;
for my $x (1..8) {
  for my $y (1..8) {
    my $space = $board->get_space([$x,$y]);
    print "occupation of space is " . $space->occupied . "\n";# if $space->piece;
  }
}
