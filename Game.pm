package Game;
use Moose;
use Term::ANSIColor;
use Board;
use Piece;

#has 'board' => ( is 'ro', isa 'Board', );


print color 'bold blue';
print "This text is bold blue.\n";
print color 'reset';
print "This text is normal.\n";
