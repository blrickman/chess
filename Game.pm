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
print colored("Yellow on magenta.", 'yellow on_magenta'), "\n";
print "This text is normal.\n";
print colored ['yellow on_magenta'], 'Yellow on magenta.', "\n";
print colored ['red on_bright_yellow'], 'Red on bright yellow.', "\n";
print colored ['bright_red on_black'], 'Bright red on black.', "\n";
print "\n";
