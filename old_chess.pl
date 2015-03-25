#!/usr/bin/perl

use warnings;
use strict;
use v5.10;
use Term::ANSIColor;

my @board;
my @wpieces = qw(♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖);
@wpieces = qw(wr wn wb wq wk wb wn wr);
my @bpieces = qw(♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜);
@bpieces = qw(br bn bb bq bk bb bn br);
my $pieces = join '', (@wpieces,@bpieces);
my $chess_unicode = {
  k => [qw(♔ ♚)],
  q => [qw(♕ ♛)],
  b => [qw(♗ ♝)],
  n => [qw(♘ ♞)],
  r => [qw(♖ ♜)],
  p => [qw(♙ ♟)],
};

my %letters = (
  A => 1,
  B => 2,
  C => 3,
  D => 4,
  E => 5,
  F => 6,
  G => 7,
  H => 8,
);

for my $column (1..8){
  $board[8][$column] = "$bpieces[$column-1]";
  $board[7][$column] = "bp";
  $board[1][$column] = "$wpieces[$column-1]";
  $board[2][$column] = "wp";
  $board[0][$column] = " $column ";
}
for (keys %letters) {
  $board[$letters{$_}][0]="  $_   ";
} 
$board[0][0]="^y, x>";
while (1) {
  for my $row (reverse(0..8)) {
    for my $column (0..8) {
    my $unicode;
    if ((defined $board[$row][$column]) and !($board[$row][$column] =~ /[$pieces]/)) {
      print "$board[$row][$column]";
    } elsif ((defined $board[$row][$column]) and !(($row+$column)%2)) {
      if ($board[$row][$column] =~ /(b|w)+(p|k|q|b|n|r)+/) {
        $unicode = $1 eq 'b' ? $chess_unicode->{$2}[1] : $chess_unicode->{$2}[0];
    }
      print colored(" $unicode ", 'white on_black');
    } elsif ((defined $board[$row][$column])) {
      if ($board[$row][$column] =~ /(b|w)(p|k|q|b|n|r)/) {
        $unicode = $1 eq 'b' ? $chess_unicode->{$2}[0] : $chess_unicode->{$2}[1];
    }
      print colored(" $unicode ", 'black on_white');
    } elsif (($row+$column)%2){
      print colored("   ", 'white on_white');
    } else {
      print colored("   ", 'white on_black');
    }
  } print "\n";
  }

  print "\nNext move?\n\n";
  my $move = <>;
  last unless ($move =~ /([a-h]),\s?([1-8])/);
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
