Untitled Word Game Pro is a Wordle clone for 8-bit Apple II computers. It runs on any Apple ][ with 64K. It runs under ProDOS and can be copied to a hard drive if you like that sort of thing.

The game is fully playable and feature-complete. It randomly picks from a curated list of 2048 five-letter words and validates your guesses against a list of 9330 words. There is no "daily" play, just random puzzles as long as your Apple II can draw breath. It even plays a little tune when you win.

## Background

Since Wordle exploded in popularity in late 2021 / early 2022, there have been many variations ([Quordle](https://www.quordle.com/), [Octordle](https://octordle.com/)), innovative adjacent spin-offs ([Nerdle](https://nerdlegame.com/), [Worldle](https://worldle.teuteuf.fr/)), and ports to older space- and CPU-constrained devices ([Gameboy Fiver](https://alexanderpruss.blogspot.com/2022/02/game-boy-wordle-how-to-compress-12972.html)).

As you might expect, the primary challenge of a retrocomputing port of a word guessing game is the massive word list. Generalized text compression is a well-studied topic, but CPU-intensive decompression is usually required before access, and there's not enough space to decompress everything (or possibly anything).

Untitled Word Game Pro stores words in two lists: the first of possible solutions, and the second of all valid words not in the first list. Each list is stored as a directed acyclic word graph, using the [Blitzkrieg algorithm](https://pages.pathcom.com/~vadco/dawg.html) for fast lookups. We discarded the node lookup table in favor of a hard-coded solution, and we trimmed the entry size from 4 bytes to 3. And by "we" I mean [qkumba](https://github.com/peterferrie), who wrote the 6502 assembly language routines to access the word lists: [`nth`](https://github.com/a2-4am/untitled-word-game-pro/blob/main/src/lookup.a#L10) to pick a solution word, and [`exists`](https://github.com/a2-4am/untitled-word-game-pro/blob/main/src/lookup.a#L128) to validate your guesses. Lookups are so fast that we don't even bother displaying a progress indicator.
