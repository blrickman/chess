#!/usr/bin/perl

use warnings;
use strict;
use v5.10;
use Term::ANSIColor;

my $debug_1 = 0;
my $board;
my @wpieces = qw(wr wn wb wq wk wb wn wr);
my @bpieces = qw(br bn bb bq bk bb bn br);
my $pieces = join '', (@wpieces,@bpieces);
my $chess_unicode = {
  k => [qw(♔ ♚)],
  q => [qw(♕ ♛)],
  b => [qw(♗ ♝)],
  n => [qw(♘ ♞)],
  r => [qw(♖ ♜)],
  p => [qw(♙ ♟)],
};

sub letters {
  my $i = shift;
  $i =~ tr/a-h/A-H/;
  if ($i =~ /\w/) {
    $i =~ tr/A-H/1-8/;
  } else {
  $i =~ tr/1-8/A-H/;
  }
  return $i
}

for my $column (1..8){
  $board->[8][$column] = "$bpieces[$column-1]";
  $board->[7][$column] = "bp";
  $board->[1][$column] = "$wpieces[$column-1]";
  $board->[2][$column] = "wp";
  $board->[0][$column] = " $column ";
}
for (1..8) {
  $board->[$_][0]="  " . letters($_) . "   ";
} 
$board->[0][0]="^y, x>";
while (1) {
  for my $row (reverse(0..8)) {
    for my $column (0..8) {
    my $unicode;
    my $color;
    if ((defined $board->[$row][$column]) and !($board->[$row][$column] =~ /[$pieces]/)) {
      print "$board->[$row][$column]";
    } elsif ((defined $board->[$row][$column]) and !(($row+$column)%2)) {
      if ($board->[$row][$column] =~ /(b|w)(p|k|q|b|n|r)/) {
        if ($debug_1) {
          $unicode = $1 eq 'b' ? $chess_unicode->{$2}[0] : $chess_unicode->{$2}[1];
          $color = 'white';
	} else {
          $unicode = $chess_unicode->{$2}[1];
          $color   = $1 eq 'b' ? 'red' : 'yellow';
        }
      }
      print colored(" $unicode ", "$color on_black");
    } elsif ((defined $board->[$row][$column])) {
      if ($board->[$row][$column] =~ /(b|w)(p|k|q|b|n|r)/) {
        if ($debug_1) {
          $unicode = $1 eq 'b' ? $chess_unicode->{$2}[1] : $chess_unicode->{$2}[0];
          $color = 'black';
	} else {
          $unicode = $chess_unicode->{$2}[1];
          $color   = $1 eq 'b' ? 'red' : 'yellow';
        }
      }
      print colored(" $unicode ", "$color on_white");
    } elsif (($row+$column)%2){
      print colored("   ", 'white on_white');
    } else {
      print colored("   ", 'white on_black');
    }
  } print "\n";
  }

  $board->[0][0] = undef;
  print "\nNext move?\n\n";
  my ($startx,$starty) = get_space();
  until (defined $board->[$starty][$startx]) {
    print "\nThere is no piece there\n\n";
    ($startx,$starty) = get_space();
  }
  print "\nWhere will $board->[$starty][$startx] go?\n\n"; 
  my ($endx,$endy) = get_space();
  print "\n";
  $board->[$endy][$endx]=$board->[$starty][$startx];
  $board->[$starty][$startx] = undef;
}  

sub get_space {
  my $move = <>;
  until ($move =~ /([A-Ha-h]),?\s?([1-8])/) {
    print "\nBad format, try again\n\n";
    $move = <>;
  }
  my ($sy,$sx) = $move =~ /([A-Ha-h]),?\s?([1-8])/;
  return ($sx,letters($sy))
}
