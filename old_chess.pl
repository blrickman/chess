#!/usr/bin/perl

use warnings;
use strict;
use v5.10;

my @board;
my @wpieces = qw(♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖);
my @bpieces = qw(♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜);
my $pieces = join '', (@wpieces,@bpieces);
my %letters = (
  a => 1,
  b => 2,
  c => 3,
  d => 4,
  e => 5,
  f => 6,
  g => 7,
  h => 8,
);

for my $column (1..8){
  $board[8][$column] = "$bpieces[$column-1]";
  $board[7][$column] = "♟";
  $board[1][$column] = "$wpieces[$column-1]";
  $board[2][$column] = "♙";
  $board[0][$column] = " $column ";
}
for (keys %letters) {
  $board[$letters{$_}][0]="  $_   ";
} 
$board[0][0]="^y, x>";
while (1) {
  for my $row (reverse(0..8)) {
    for my $column (0..8) {
    if ((defined $board[$row][$column]) and !($board[$row][$column] =~ /[$pieces]/)) {
      print "$board[$row][$column]";
    } elsif ((defined $board[$row][$column]) and !(($row+$column)%2))  {
      print "|$board[$row][$column]|";
    } elsif ((defined $board[$row][$column])) {
      print " $board[$row][$column] ";
    } elsif (($row+$column)%2){
      print "   ";
    } else {
      print "|||";
    }
  } print "\n";
  }

  print "\nNext move?\n\n";
  my $move = <>;
  last unless ($move =~ /([a-h]),(\s)?([1-8])/);
  my $starty = $letters{$1};
  my $startx = $3;
  unless (defined $board[$starty][$startx]) {
    print "\nThere is no piece there\n\n";
    next
  }
  print "\nWhere will $board[$starty][$startx] go?\n\n"; 
  $move = <>;
  print "\n";
  last unless ($move =~ /([a-h]),(\s)?([1-8])/);
  my $endy = $letters{$1};
  my $endx = $3;
  $board[$endy][$endx]=$board[$starty][$startx];
  $board[$starty][$startx] = undef;
}  
