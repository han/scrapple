Scrapple
=========

Scrapple finds scrabble words that adhere to a pattern and sorts them by
score.


Usage
------------

ruby scrapple.rb

* note: yes, it's a command-line tool
* note 2: Scrapple needs Ruby 1.9+
* note 3: Currently only supports Dutch. Although ne migth wonder why this readme is in
  English then.

When scrapple asks for letters, type the 7 (or fewer) letters on your
tiles. Type a ? for the blank tile.

The pattern works as follows:

type a . (dot) for each tile position scrapple should fill on the board. Lower
case alphabetic characters represent letters already on the board. A '2'
or '3' denotes an empty tile position with 2 or 3 times word value. A
capital 'D' or 'T' stands for a Double or Triple letter value. 

Scrapple will try to form the longest word possible in a word pattern.
However it will also drop empty tiles from the beginning or end of your
patterns to find more matches. An '*' (asterisk) can be used to
represent many dots, but only at the beginning or end of the pattern.

If you have a blank tile, it's use is indicated by a capital letter in
the results.

Just hitting enter when scrapple asks for letters or a pattern exits the
program.

Examples
--------

* ..t - find words starting with one or two of your tiles and ending on
  't'
* *c..n - find words starting with any number of your tiles, followed by
  a 'c', followed by two more of your tiles, and ending in an 'n'.
* 3c.Dn - find words starting with one of your tiles, followed by a 'c',
  followed by two more tiles, the last of which is a double letter value,
  and ending in an 'n' again. The word value is tripled, since the first
  tile holds a '3'
* .k*r* - is illegal. A '*' should be at the beginning or end of a
  pattern.

Meta
----

Created by Han Kessels

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

http://github.com/han/scrapple

Scrapple uses the Dutch Opentaal (www.opentaal.org) wordlists, licensed
under a Creative Commons Attribution license.

