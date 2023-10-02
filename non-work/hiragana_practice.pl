#!/usr/bin/perl
use strict;
use warnings;

my %hiragana = (
    "あ" => "a",
    "い" => "i",
    "う" => "u",
    "え" => "e",
    "お" => "o",
    "か" => "ka",
    "き" => "ki",
    "く" => "ku",
    "け" => "ke",
    "こ" => "ko",
    "さ" => "sa",
    "し" => "shi",
    "す" => "su",
    "せ" => "se",
    "そ" => "so",
    "た" => "ta",
    "ち" => "chi",
    "つ" => "tsu",
    "て" => "te",
    "と" => "to",
    "な" => "na",
    "に" => "ni",
    "ぬ" => "nu",
    "ね" => "ne",
    "の" => "no",
    "は" => "ha",
    "ひ" => "hi",
    "ふ" => "fu",
    "へ" => "he",
    "ほ" => "ho",
    "ま" => "ma",
    "み" => "mi",
    "む" => "mu",
    "め" => "me",
    "も" => "mo",
    "や" => "ya",
    "ゆ" => "yu",
    "よ" => "yo",
    "ら" => "ra",
    "り" => "ri",
    "る" => "ru",
    "れ" => "re",
    "ろ" => "ro",
    "わ" => "wa",
    "を" => "wo",
    "ん" => "n"
);

print "\nHiragana Pop Quiz Time!\n";

foreach my $key (keys %hiragana) {
    print "\nWhat is the english sound for the hiragana character '$key'?: ";
    chomp(my $answer = <STDIN>);

    if($answer eq $hiragana{$key}) {
         print "Correct!\n";
    } else {
         print "Incorrect. The correct answer is '$hiragana{$key}'.\n";
    }
}
