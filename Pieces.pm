package Piece;
use Moose;
use Board;

has 'posx' 	=> ( is => 'rw', isa => 'Int', );
has 'posy'	=> ( is => 'rw', isa => 'Int', );
has 'pot_moves'	=> ( is => 'ro', lazy => 1, builder => '_move', );
has 'board'	=> ( is => 'ro', isa => 'Board', );
has 'movements'	=> ( is => 'rw', isa => 'Int', default => 0, );
has 'white'	=> ( is => 'ro', isa => 'Bool', default => 1);

sub position {
  my $self = shift;
  return [$self->posx,$self->posy];
}
	
sub color { 
  my $self = shift;
  return $self->white ? 'white' : 'black';
}

sub move_to {
  my $self = shift;
  my ($tx,$ty) = @_;
  my $test = 0;
  for my $move (@{$self->pot_moves}) {
    $test ||= (@{$move}[0] == $tx && @{$move}[1] == $ty);
  }
  print "Illegal move, chose again\n" unless $test;
}

####################
###     KING     ###
####################

#TODO Add Castling moves

package King;
use Moose;
extends 'Piece';

sub _move {
  my $self = shift;
  my ($px,$py) = map $self->$_, qw/posx posy/;
  my $board = $self->board;
  my @moves;
  for (-1,1) {
    for my $move ([$px+$_,$py],[$px,$py+$_],[$px+$_,$py+$_],[$px+$_,$py-$_]) {
      push @moves, $move if $board->get_space($move) && $board->get_space($move)->occupiable_by($self);
    }
  }
  unless($self->movements){
    # check rooks to castle with
  }
  return \@moves;
}

####################
###    QUEEN     ###
####################

package Queen;
use Moose;
extends 'Piece';

sub _move {
  my $self = shift;
  my ($px,$py) = map $self->$_, qw/posx posy/;
  my $board = $self->board;
  my $x_dim = $board->x_spaces;
  my $y_dim = $board->y_spaces;
  my @moves;

  my ($nx,$ny) = ($px,$py);
  --$nx; 
  while ($nx >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx--,$ny])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$nx; 
  while ($nx <= $x_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx++,$ny])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  --$ny; 
  while ($ny >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx,$ny--])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$ny; 
  while ($ny <= $y_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx,$ny++])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  --$nx; --$ny;
  while ($nx >= 1 && $ny >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx--,$ny--])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$nx; ++$ny; 
  while ($nx <= $x_dim && $ny <= $y_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx++,$ny++])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$nx; --$ny; 
  while ($nx <= $x_dim && $ny >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx++,$ny--])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  --$nx; ++$ny; 
  while ($nx >= 1 && $ny <= $y_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx--,$ny++])->occupied;
    } else {
      last;
    }
  }

  return \@moves;
}

####################
###     ROOK     ###
####################

package Rook;
use Moose;
extends 'Piece';

sub _move {
  my $self = shift;
  my ($px,$py) = map $self->$_, qw/posx posy/;
  my $board = $self->board;
  my $x_dim = $board->x_spaces;
  my $y_dim = $board->y_spaces;
  my @moves;

  my ($nx,$ny) = ($px,$py);
  --$nx; 
  while ($nx >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx--,$ny])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$nx; 
  while ($nx <= $x_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx++,$ny])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  --$ny; 
  while ($ny >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx,$ny--])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$ny; 
  while ($ny <= $y_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx,$ny++])->occupied;
    } else {
      last;
    }
  }

  return \@moves;
}

####################
###    BISHOP    ###
####################

package Bishop;
use Moose;
extends 'Piece';

sub _move {
  my $self = shift;
  my ($px,$py) = map $self->$_, qw/posx posy/;
  my $board = $self->board;
  my $x_dim = $board->x_spaces;
  my $y_dim = $board->y_spaces;
  my @moves;
 
  my ($nx,$ny) = ($px,$py);
  --$nx; --$ny;
  while ($nx >= 1 && $ny >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx--,$ny--])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$nx; ++$ny; 
  while ($nx <= $x_dim && $ny <= $y_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx++,$ny++])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  ++$nx; --$ny; 
  while ($nx <= $x_dim && $ny >= 1) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx++,$ny--])->occupied;
    } else {
      last;
    }
  }
  ($nx,$ny) = ($px,$py);
  --$nx; ++$ny; 
  while ($nx >= 1 && $ny <= $y_dim) {
    if ($board->get_space([$nx,$ny])->occupiable_by($self)) {
      push @moves, [$nx,$ny];
      last if $board->get_space([$nx--,$ny++])->occupied;
    } else {
      last;
    }
  }

  return \@moves;
}

####################
###   KNIGHT     ###
####################

package Knight;
use Moose;
extends 'Piece';

sub _move {
  my $self = shift;
  my ($px,$py) = map $self->$_, qw/posx posy/;
  my $board = $self->board;
  my $max_dim = $board->_max_dim;
  my @moves;
  for (-1,1) {
    for my $move ([$px+2*$_,$py+$_],[$px+2*$_,$py-$_],[$px+$_,$py+2*$_],[$px+$_,$py-2*$_]) {
      push @moves, $move if $board->get_space($move) && $board->get_space($move)->occupiable_by($self);
    }
  }
  return \@moves;
}

####################
###     PAWN     ###
####################

package Pawn;
use Moose;
extends 'Piece';

sub _move {
  my $self = shift;
  my ($px,$py) = map $self->$_, qw/posx posy/;
  my $board = $self->board;
  my $max_dim = $board->_max_dim;
  my @moves;
  push @moves, [$px,$py+1] unless $board->get_space([$px,$py+1])->occupied;
  for my $move ([$px+1,$py+1], [$px-1,$py+1]) {
    push @moves, $move if $board->get_space($move) && $board->get_space($move)->occupiable_by($self) && $board->get_space($move)->occupied;
  }
  push @moves, [$px,$py+2] unless $self->movements || $board->get_space([$px,$py+1])->occupied || $board->get_space([$px,$py+2])->occupied;
  return \@moves;
}

1;
