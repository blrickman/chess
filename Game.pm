package Game;
use Moose;

use Board;
use Piece;

has 'board' => ( is 'ro', isa 'Board', );

