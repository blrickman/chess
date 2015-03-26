package Board;
use Moose;

has 'x_spaces'	=> ( is => 'ro', isa => 'Int', default => 8, );
has 'y_spaces'	=> ( is => 'ro', isa => 'Int', default => 8, );
has 'pieces'	=> ( is => 'rw', isa => 'ArrayRef', );
has 'spaces'	=> ( 
  is	  => 'ro', 
  isa	  => 'ArrayRef',
  lazy	  => 1,	 
  builder => '_create_board',
);

sub _create_board {
  my $self = shift;
  my $board;
  for my $x (1..$self->x_spaces) {
    for my $y (1..$self->y_spaces) {
      $$board[$x][$y] = Space->new(posx => $x, posy => $y );
    }
  }
  return $board;
}

sub get_space {
  my $self = shift;
  my $pos = shift;
  return 0 if $pos->[0] <= 0 || $pos->[1] <= 0;
  return ${$self->spaces}[$pos->[0]][$pos->[1]] || 0;
}

sub add_pieces {
  my $self = shift;
  my $pieces = shift;
  for my $piece (@{$pieces}) {
    my $space = $self->get_space($piece->position);
    die "Board Setup: Can't place two pieces on same spot" if $space->occupied;
    $space->piece($piece);
    my $hold = $self->pieces;
    push @{$hold}, $piece;
    $self->pieces($hold);
  }
}

sub remove_piece {
  my $self = shift;
  my $piece = shift;
  my $space = $self->get_space($piece->position);
  $space->piece(undef);
  my $hold;
  for (@{$self->pieces}) {
    next if $_ == $piece;
    push @{$hold}, $_;
  }
  $self->pieces($hold);
}

sub _max_dim {
  my $self = shift;
  return $self->x_spaces > $self-> y_spaces ? $self->x_spaces : $self->y_spaces;
}

package Space;
use Moose;
use Pieces;

has 'posx' 	=> ( is => 'ro', isa => 'Int' );
has 'posy'	=> ( is => 'ro', isa => 'Int' );
has 'piece'	=> ( is => 'rw', isa => 'Maybe[Piece]', );
has 'color'	=> ( 
  is 	  => 'ro', 
  isa 	  => 'Str', 
  lazy	  => 1,
  default => sub {
    my $self = shift;
    return ($self->posx + $self->posy) % 2 ? 'black' : 'white';
  },
);

sub occupied {
  my $self = shift;
  return $self->piece ? 1 : 0;
}

sub occupiable_by {
  my $self = shift;
  return 1 unless $self->occupied;
  my $new_piece = shift;
  my $cur_piece = $self->piece;
  return 1 unless $new_piece->color eq $cur_piece->color;
  return 0;
}

1;
