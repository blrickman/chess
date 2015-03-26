package Game;
use Moose;
use Term::ANSIColor;
use Board;
use Piece;

has 'board' => ( is => 'ro', isa => 'Board', );
#has 'winner'
#has 'turns'
#has 'history'

my $ps = {
  King   => ['♔', '♚'],
  Queen  => ['♕', '♛'],
  Bishop => ['♗', '♝'],
  Knight => ['♘', '♞'],
  Rook   => ['♖', '♜'],
  Pawn   => ['♙', '♟'],
};

sub play {
  # initiates game
}

sub draw_board {
  my $self = shift;
  my $board = $self->board;
  my ($spaces,$xdim,$ydim) = map {$board->$_} qw/spaces x_spaces y_spaces/;
  for my $y (reverse (1..$ydim)) {
    for my $x (1..$xdim) {
      my $space = $board->get_space([$x,$y]);
      my $sc = $space->color;
      my $symbol = $space->piece ? $ps->{ref $space->piece}[1] : " ";
      my $pc = $space->piece ? $space->piece->color : 'yellow';
      $pc =~ s/white/yellow/;
      $pc =~ s/black/red/;
      print colored(" $symbol ", "$pc on_$sc");
    }
    print "\n"
  }
}


#print color 'bold blue';
#print "This text is bold blue.\n";
#print color 'reset';
#print "This text is normal.\n";
#print colored("Yellow on magenta.", 'yellow on_magenta'), "\n";
#print "This text is normal.\n";
#print colored ['yellow on_magenta'], 'Yellow on magenta.', "\n";
#print colored ['red on_bright_yellow'], 'Red on bright yellow.', "\n";
#print colored ['bright_red on_black'], 'Bright red on black.', "\n";
#print "\n";

1;
