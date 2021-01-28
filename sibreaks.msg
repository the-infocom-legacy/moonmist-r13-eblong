Here's how to change how a game handles punctuation.

Normally, ZIP interpreters treat comma, period, and (double) quote as
break characters (because, like space, they break words apart) and in
fact as "self-inserting" break characters (because, unlike space, they
are inserted as "words" in the input buffer that the game itself sees).
This behavior is caused (as of January 1986) by a Muddle global called
SIBREAKS.  ZILCH does <SETG SIBREAKS ",.\""> to give the "normal"
behavior.  If you want a game to have more (or fewer?) self-inserting
breaks, you can put a similar statement anywhere in the game's files of
code.

Example: Suppose you want question-mark in a command to be the same as
period.  (It has been in ZIP20 until January 1986, due to a special
"feature" that is now removed.)  Here's how:

1. Somewhere in the game's files do <SETG SIBREAKS ",.\"?"> to supersede
the "normal" set of self-inserting breaks.

2. Somewhere in the game's files do <BUZZ \?> to make sure the "word"
question-mark gets into the vocabulary table.

3. Wherever the game tests for ,W?PERIOD make it test for ,W?? as well.
Example: <EQUAL? <GET ,P-LEXV .PTR> ,W?PERIOD ,W?\! ,W??>.
