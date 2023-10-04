#!/usr/bin/perl
use strict;
use warnings;

my %katakana = (
  "ア" => "a",
  "イ" => "i",
  "ウ" => "u",
  "エ" => "e",
  "オ" => "o",
  "カ" => "ka",
  "キ" => "ki",
  "ク" => "ku",
  "ケ" => "ke",
  "コ" => "ko",
  "サ" => "sa",
  "シ" => "shi",
  "ス" => "su",
  "セ" => "se",
  "ソ" => "so",
  "タ" => "ta",
  "チ" => "chi",
  "ツ" => "tsu",
  "テ" => "te",
  "ト" => "to",
  "ナ" => "na",
  "ニ" => "ni",
  "ヌ" => "nu",
  "ネ" => "ne",
  "ノ" => "no",
  "ハ" => "ha",
  "ヒ" => "hi",
  "フ" => "fu",
  "ヘ" => "he",
  "ホ" => "ho",
  "マ" => "ma",
  "ミ" => "mi",
  "ム" => "mu",
  "メ" => "me",
  "モ" => "mo",
  "ヤ" => "ya",
  "ユ" => "yu",
  "ヨ" => "yo",
  "ラ" => "ra",
  "リ" => "ri",
  "ル" => "ru",
  "レ" => "re",
  "ロ" => "ro",
  "ワ" => "wa",
  "ヲ" => "wo",
  "ン" => "n"
);

print "\nKatakana Pop Quiz Time!\n";

foreach my $key (keys %katakana) {
print "\nWhat is the English sound for the katakana character '$key'?: ";
chomp(my $answer = <STDIN> );

if($answer eq $katakana{$key}) {
     print "Correct!\n";
} else {
     print "Incorrect. The correct answer is '$katakana{$key}'.\n";
}
}
