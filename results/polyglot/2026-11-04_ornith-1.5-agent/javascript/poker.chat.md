
# aider chat started at 2026-11-04 10:17:10

> Aider v0.86.3.dev+less  
> Model: ollama_chat/ornith-1.5-agent with diff edit format  
> Git repo: none  
> Repo-map: disabled  
> Added poker.js to the chat.  

#### # Instructions  
####   
#### Pick the best hand(s) from a list of poker hands.  
####   
#### See [Wikipedia][poker-hands] for an overview of poker hands.  
####   
#### [poker-hands]: https://en.wikipedia.org/wiki/List_of_poker_hands  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: poker.js  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

I'll implement the `bestHands` function to evaluate poker hands and return the index/indices of the best hand(s).

My approach:
1. Parse each hand into cards (rank + suit).
2. Score each hand as a comparable tuple `[category, ...tiebreakers]` where higher category and tiebreakers mean a better hand.
3. Compare hands lexicographically and collect all indices tied for the best.

Here's the implementation:

poker.js
```javascript
<<<<<<< SEARCH
//
// This is only a SKELETON file for the 'Poker' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const bestHands = (hands) => {
  throw new Error('Remove this statement and implement this function');
};
=======
//
// This is only a SKELETON file for the 'Poker' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const RANK_VALUES = {
  '2': 2,
  '3': 3,
  '4': 4,
  '5': 5,
  '6': 6,
  '7': 7,
  '8': 8,
  '9': 9,
  'T': 10,
  'J': 11,
  'Q': 12,
  'K': 13,
  'A': 14,
};

function parseHand(hand) {
  return hand
    .split(' ')
    .map((card) => ({
      rank: RANK_VALUES[card.slice(0, -1)],
      suit: card[card.length - 1],
    }));
}

function scoreHand(hand) {
  const cards = parseHand(hand);
  const ranks = cards.map((c) => c.rank).sort((a, b) => b - a);
  const suits = cards.map((c) => c.suit);

  const isFlush = suits.every((s) => s === suits[0]);

  const rankCounts = {};
  ranks.forEach((r) => {
    rankCounts[r] = (rankCounts[r] || 0) + 1;
  });

  const sortedByCount = Object.keys(rankCounts)
    .map(Number)
    .sort((a, b) => rankCounts[b] - rankCounts[a] || b - a);

  const uniqueRanks = [...new Set(ranks)];
  let isStraight = false;
  let straightHigh = 0;

  if (uniqueRanks.length === 5) {
    if (uniqueRanks[0] - uniqueRanks[4] === 4) {
      isStraight = true;
      straightHigh = uniqueRanks[0];
    } else if (uniqueRanks[0] === 14 && uniqueRanks[4] === 2) {
      // Wheel straight: A, 5, 4, 3, 2 (Ace counts as low)
      isStraight = true;
      straightHigh = 5;
    }
  }

  if (isStraight && isFlush) return [8, straightHigh];
  if (sortedByCount[0] === 4) return [7, sortedByCount[0], sortedByCount[1]];
  if (sortedByCount[0] === 3 && sortedByCount[1] === 2) {
    return [6, sortedByCount[0], sortedByCount[1]];
  }
  if (isFlush) return [5, ...ranks];
  if (isStraight) return [4, straightHigh];
  if (sortedByCount[0] === 3) {
    return [3, sortedByCount[0], ...sortedByCount.slice(1)];
  }
  if (sortedByCount[0] === 2 && sortedByCount[1] === 2) {
    return [2, sortedByCount[0], sortedByCount[1], sortedByCount[2]];
  }
  if (sortedByCount[0] === 2) {
    return [1, sortedByCount[0], ...sortedByCount.slice(1)];
  }
  return [0, ...ranks];
}

function compareScore(a, b) {
  for (let i = 0; i < Math.max(a.length, b.length); i++) {
    if (a[i] > b[i]) return 1;
    if (a[i] < b[i]) return -1;
  }
  return 0;
}

export const bestHands = (hands) => {
  const scores = hands.map(scoreHand);
  const result = [];
  let best = scores[0];
  for (let i = 1; i < scores.length; i++) {
    const cmp = compareScore(scores[i], best);
    if (cmp > 0) {
      best = scores[i];
      result.length = 0;
      result.push(i);
    } else if (cmp === 0) {
      result.push(i);
    }
  }
  return result;
};
>>>>>>> REPLACE
```

> Tokens: 2.2k sent, 6.7k received.  
> Applied edit to poker.js  
```

> test
> jest ./*

FAIL ./poker.spec.js
  Poker
    ✕ single hand always wins (5 ms)
    ✕ highest card out of all hands wins (1 ms)
    ✕ a tie has multiple winners (1 ms)
    ✕ multiple hands with the same high cards, tie compares next highest ranked, down to last card (1 ms)
    ✕ one pair beats high card (1 ms)
    ✕ highest pair wins
    ✕ two pairs beats one pair (1 ms)
    ✕ both hands have two pairs, highest ranked pair wins (1 ms)
    ✕ both hands have two pairs, with the same highest ranked pair, tie goes to low pair (1 ms)
    ✕ both hands have two identically ranked pairs, tie goes to remaining card (kicker) (1 ms)
    ✕ three of a kind beats two pair (1 ms)
    ✕ both hands have three of a kind, tie goes to highest ranked triplet (1 ms)
    ✕ with multiple decks, two players can have same three of a kind, ties go to highest remaining cards
    ✕ a straight beats three of a kind
    ✕ aces can end a straight (10 J Q K A)
    ✕ aces can start a straight (A 2 3 4 5)
    ✕ both hands with a straight, tie goes to highest ranked card (1 ms)
    ✕ even though an ace is usually high, a 5-high straight is the lowest-scoring straight (1 ms)
    ✕ flush beats a straight (1 ms)
    ✕ both hands have a flush, tie goes to high card, down to the last one if necessary
    ✕ full house beats a flush
    ✕ both hands have a full house, tie goes to highest-ranked triplet (1 ms)
    ✕ with multiple decks, both hands have a full house with the same triplet, tie goes to the pair
    ✕ four of a kind beats a full house
    ✕ both hands have four of a kind, tie goes to high quad (1 ms)
    ✕ with multiple decks, both hands with identical four of a kind, tie determined by kicker
    ✕ straight flush beats four of a kind (1 ms)
    ✕ both hands have straight flush, tie goes to highest-ranked card

  ● Poker › single hand always wins

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "4S 5S 7H 8D JC",
    - ]
    + Array []

       5 |     const hands = ['4S 5S 7H 8D JC'];
       6 |     const expected = ['4S 5S 7H 8D JC'];
    >  7 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
       8 |   });
       9 |
      10 |   test('highest card out of all hands wins', () => {

      at Object.toEqual (poker.spec.js:7:30)

  ● Poker › highest card out of all hands wins

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "3S 4S 5D 6H JH",
    +   2,
      ]

      11 |     const hands = ['4D 5S 6S 8D 3C', '2S 4C 7S 9H 10H', '3S 4S 5D 6H JH'];
      12 |     const expected = ['3S 4S 5D 6H JH'];
    > 13 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      14 |   });
      15 |
      16 |   test('a tie has multiple winners', () => {

      at Object.toEqual (poker.spec.js:13:30)

  ● Poker › a tie has multiple winners

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Array [
    -   "3S 4S 5D 6H JH",
    -   "3H 4H 5C 6C JD",
    +   2,
    +   3,
      ]

      22 |     ];
      23 |     const expected = ['3S 4S 5D 6H JH', '3H 4H 5C 6C JD'];
    > 24 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      25 |   });
      26 |
      27 |   test('multiple hands with the same high cards, tie compares next highest ranked, down to last card', () => {

      at Object.toEqual (poker.spec.js:24:30)

  ● Poker › multiple hands with the same high cards, tie compares next highest ranked, down to last card

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "3S 5H 6S 8D 7H",
    - ]
    + Array []

      28 |     const hands = ['3S 5H 6S 8D 7H', '2S 5D 6D 8C 7S'];
      29 |     const expected = ['3S 5H 6S 8D 7H'];
    > 30 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      31 |   });
      32 |
      33 |   test('one pair beats high card', () => {

      at Object.toEqual (poker.spec.js:30:30)

  ● Poker › one pair beats high card

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "2S 4H 6S 4D JH",
    +   1,
      ]

      34 |     const hands = ['4S 5H 6C 8D KH', '2S 4H 6S 4D JH'];
      35 |     const expected = ['2S 4H 6S 4D JH'];
    > 36 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      37 |   });
      38 |
      39 |   test('highest pair wins', () => {

      at Object.toEqual (poker.spec.js:36:30)

  ● Poker › highest pair wins

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "2S 4H 6C 4D JD",
    +   1,
      ]

      40 |     const hands = ['4S 2H 6S 2D JH', '2S 4H 6C 4D JD'];
      41 |     const expected = ['2S 4H 6C 4D JD'];
    > 42 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      43 |   });
      44 |
      45 |   test('two pairs beats one pair', () => {

      at Object.toEqual (poker.spec.js:42:30)

  ● Poker › two pairs beats one pair

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "4S 5H 4C 8C 5C",
    - ]
    + Array []

      46 |     const hands = ['2S 8H 6S 8D JH', '4S 5H 4C 8C 5C'];
      47 |     const expected = ['4S 5H 4C 8C 5C'];
    > 48 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      49 |   });
      50 |
      51 |   test('both hands have two pairs, highest ranked pair wins', () => {

      at Object.toEqual (poker.spec.js:48:30)

  ● Poker › both hands have two pairs, highest ranked pair wins

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "2S 8H 2D 8D 3H",
    - ]
    + Array []

      52 |     const hands = ['2S 8H 2D 8D 3H', '4S 5H 4C 8S 5D'];
      53 |     const expected = ['2S 8H 2D 8D 3H'];
    > 54 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      55 |   });
      56 |
      57 |   test('both hands have two pairs, with the same highest ranked pair, tie goes to low pair', () => {

      at Object.toEqual (poker.spec.js:54:30)

  ● Poker › both hands have two pairs, with the same highest ranked pair, tie goes to low pair

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "JD QH JS 8D QC",
    +   1,
      ]

      58 |     const hands = ['2S QS 2C QD JH', 'JD QH JS 8D QC'];
      59 |     const expected = ['JD QH JS 8D QC'];
    > 60 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      61 |   });
      62 |
      63 |   test('both hands have two identically ranked pairs, tie goes to remaining card (kicker)', () => {

      at Object.toEqual (poker.spec.js:60:30)

  ● Poker › both hands have two identically ranked pairs, tie goes to remaining card (kicker)

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "JD QH JS 8D QC",
    - ]
    + Array []

      64 |     const hands = ['JD QH JS 8D QC', 'JS QS JC 2D QD'];
      65 |     const expected = ['JD QH JS 8D QC'];
    > 66 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      67 |   });
      68 |
      69 |   test('three of a kind beats two pair', () => {

      at Object.toEqual (poker.spec.js:66:30)

  ● Poker › three of a kind beats two pair

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "4S 5H 4C 8S 4H",
    +   1,
      ]

      70 |     const hands = ['2S 8H 2H 8D JH', '4S 5H 4C 8S 4H'];
      71 |     const expected = ['4S 5H 4C 8S 4H'];
    > 72 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      73 |   });
      74 |
      75 |   test('both hands have three of a kind, tie goes to highest ranked triplet', () => {

      at Object.toEqual (poker.spec.js:72:30)

  ● Poker › both hands have three of a kind, tie goes to highest ranked triplet

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "4S AH AS 8C AD",
    - ]
    + Array []

      76 |     const hands = ['2S 2H 2C 8D JH', '4S AH AS 8C AD'];
      77 |     const expected = ['4S AH AS 8C AD'];
    > 78 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      79 |   });
      80 |
      81 |   test('with multiple decks, two players can have same three of a kind, ties go to highest remaining cards', () => {

      at Object.toEqual (poker.spec.js:78:30)

  ● Poker › with multiple decks, two players can have same three of a kind, ties go to highest remaining cards

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "4S AH AS 8C AD",
    +   1,
      ]

      82 |     const hands = ['4S AH AS 7C AD', '4S AH AS 8C AD'];
      83 |     const expected = ['4S AH AS 8C AD'];
    > 84 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      85 |   });
      86 |
      87 |   test('a straight beats three of a kind', () => {

      at Object.toEqual (poker.spec.js:84:30)

  ● Poker › a straight beats three of a kind

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "3S 4D 2S 6D 5C",
    - ]
    + Array []

      88 |     const hands = ['4S 5H 4C 8D 4H', '3S 4D 2S 6D 5C'];
      89 |     const expected = ['3S 4D 2S 6D 5C'];
    > 90 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      91 |   });
      92 |
      93 |   test('aces can end a straight (10 J Q K A)', () => {

      at Object.toEqual (poker.spec.js:90:30)

  ● Poker › aces can end a straight (10 J Q K A)

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "10D JH QS KD AC",
    - ]
    + Array []

      94 |     const hands = ['4S 5H 4C 8D 4H', '10D JH QS KD AC'];
      95 |     const expected = ['10D JH QS KD AC'];
    > 96 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      97 |   });
      98 |
      99 |   test('aces can start a straight (A 2 3 4 5)', () => {

      at Object.toEqual (poker.spec.js:96:30)

  ● Poker › aces can start a straight (A 2 3 4 5)

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "4D AH 3S 2D 5C",
    - ]
    + Array []

      100 |     const hands = ['4S 5H 4C 8D 4H', '4D AH 3S 2D 5C'];
      101 |     const expected = ['4D AH 3S 2D 5C'];
    > 102 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      103 |   });
      104 |
      105 |   test('both hands with a straight, tie goes to highest ranked card', () => {

      at Object.toEqual (poker.spec.js:102:30)

  ● Poker › both hands with a straight, tie goes to highest ranked card

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "5S 7H 8S 9D 6H",
    +   1,
      ]

      106 |     const hands = ['4S 6C 7S 8D 5H', '5S 7H 8S 9D 6H'];
      107 |     const expected = ['5S 7H 8S 9D 6H'];
    > 108 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      109 |   });
      110 |
      111 |   test('even though an ace is usually high, a 5-high straight is the lowest-scoring straight', () => {

      at Object.toEqual (poker.spec.js:108:30)

  ● Poker › even though an ace is usually high, a 5-high straight is the lowest-scoring straight

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "2H 3C 4D 5D 6H",
    - ]
    + Array []

      112 |     const hands = ['2H 3C 4D 5D 6H', '4S AH 3S 2D 5H'];
      113 |     const expected = ['2H 3C 4D 5D 6H'];
    > 114 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      115 |   });
      116 |
      117 |   test('flush beats a straight', () => {

      at Object.toEqual (poker.spec.js:114:30)

  ● Poker › flush beats a straight

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "2S 4S 5S 6S 7S",
    +   1,
      ]

      118 |     const hands = ['4C 6H 7D 8D 5H', '2S 4S 5S 6S 7S'];
      119 |     const expected = ['2S 4S 5S 6S 7S'];
    > 120 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      121 |   });
      122 |
      123 |   test('both hands have a flush, tie goes to high card, down to the last one if necessary', () => {

      at Object.toEqual (poker.spec.js:120:30)

  ● Poker › both hands have a flush, tie goes to high card, down to the last one if necessary

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "4H 7H 8H 9H 6H",
    - ]
    + Array []

      124 |     const hands = ['4H 7H 8H 9H 6H', '2S 4S 5S 6S 7S'];
      125 |     const expected = ['4H 7H 8H 9H 6H'];
    > 126 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      127 |   });
      128 |
      129 |   test('full house beats a flush', () => {

      at Object.toEqual (poker.spec.js:126:30)

  ● Poker › full house beats a flush

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "4S 5H 4C 5D 4H",
    +   1,
      ]

      130 |     const hands = ['3H 6H 7H 8H 5H', '4S 5H 4C 5D 4H'];
      131 |     const expected = ['4S 5H 4C 5D 4H'];
    > 132 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      133 |   });
      134 |
      135 |   test('both hands have a full house, tie goes to highest-ranked triplet', () => {

      at Object.toEqual (poker.spec.js:132:30)

  ● Poker › both hands have a full house, tie goes to highest-ranked triplet

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "5H 5S 5D 8S 8D",
    - ]
    + Array []

      136 |     const hands = ['4H 4S 4D 9S 9D', '5H 5S 5D 8S 8D'];
      137 |     const expected = ['5H 5S 5D 8S 8D'];
    > 138 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      139 |   });
      140 |
      141 |   test('with multiple decks, both hands have a full house with the same triplet, tie goes to the pair', () => {

      at Object.toEqual (poker.spec.js:138:30)

  ● Poker › with multiple decks, both hands have a full house with the same triplet, tie goes to the pair

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "5H 5S 5D 9S 9D",
    - ]
    + Array []

      142 |     const hands = ['5H 5S 5D 9S 9D', '5H 5S 5D 8S 8D'];
      143 |     const expected = ['5H 5S 5D 9S 9D'];
    > 144 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      145 |   });
      146 |
      147 |   test('four of a kind beats a full house', () => {

      at Object.toEqual (poker.spec.js:144:30)

  ● Poker › four of a kind beats a full house

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "3S 3H 2S 3D 3C",
    - ]
    + Array []

      148 |     const hands = ['4S 5H 4D 5D 4H', '3S 3H 2S 3D 3C'];
      149 |     const expected = ['3S 3H 2S 3D 3C'];
    > 150 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      151 |   });
      152 |
      153 |   test('both hands have four of a kind, tie goes to high quad', () => {

      at Object.toEqual (poker.spec.js:150:30)

  ● Poker › both hands have four of a kind, tie goes to high quad

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "4S 5H 5S 5D 5C",
    - ]
    + Array []

      154 |     const hands = ['2S 2H 2C 8D 2D', '4S 5H 5S 5D 5C'];
      155 |     const expected = ['4S 5H 5S 5D 5C'];
    > 156 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      157 |   });
      158 |
      159 |   test('with multiple decks, both hands with identical four of a kind, tie determined by kicker', () => {

      at Object.toEqual (poker.spec.js:156:30)

  ● Poker › with multiple decks, both hands with identical four of a kind, tie determined by kicker

    expect(received).toEqual(expected) // deep equality

    - Expected  - 3
    + Received  + 1

    - Array [
    -   "3S 3H 4S 3D 3C",
    - ]
    + Array []

      160 |     const hands = ['3S 3H 2S 3D 3C', '3S 3H 4S 3D 3C'];
      161 |     const expected = ['3S 3H 4S 3D 3C'];
    > 162 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      163 |   });
      164 |
      165 |   test('straight flush beats four of a kind', () => {

      at Object.toEqual (poker.spec.js:162:30)

  ● Poker › straight flush beats four of a kind

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "7S 8S 9S 6S 10S",
    +   1,
      ]

      166 |     const hands = ['4S 5H 5S 5D 5C', '7S 8S 9S 6S 10S'];
      167 |     const expected = ['7S 8S 9S 6S 10S'];
    > 168 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      169 |   });
      170 |
      171 |   test('both hands have straight flush, tie goes to highest-ranked card', () => {

      at Object.toEqual (poker.spec.js:168:30)

  ● Poker › both hands have straight flush, tie goes to highest-ranked card

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "5S 7S 8S 9S 6S",
    +   1,
      ]

      172 |     const hands = ['4H 6H 7H 8H 5H', '5S 7S 8S 9S 6S'];
      173 |     const expected = ['5S 7S 8S 9S 6S'];
    > 174 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      175 |   });
      176 | });
      177 |

      at Object.toEqual (poker.spec.js:174:30)

Test Suites: 1 failed, 1 total
Tests:       28 failed, 28 total
Snapshots:   0 total
Time:        0.558 s
Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./poker.js|./poker.spec.js.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./poker.spec.js  
####   Poker  
####     ✕ single hand always wins (5 ms)  
####     ✕ highest card out of all hands wins (1 ms)  
####     ✕ a tie has multiple winners (1 ms)  
####     ✕ multiple hands with the same high cards, tie compares next highest ranked, down to last card (1 ms)  
####     ✕ one pair beats high card (1 ms)  
####     ✕ highest pair wins  
####     ✕ two pairs beats one pair (1 ms)  
####     ✕ both hands have two pairs, highest ranked pair wins (1 ms)  
####     ✕ both hands have two pairs, with the same highest ranked pair, tie goes to low pair (1 ms)  
####     ✕ both hands have two identically ranked pairs, tie goes to remaining card (kicker) (1 ms)  
####     ✕ three of a kind beats two pair (1 ms)  
####     ✕ both hands have three of a kind, tie goes to highest ranked triplet (1 ms)  
####     ✕ with multiple decks, two players can have same three of a kind, ties go to highest remaining cards  
####     ✕ a straight beats three of a kind  
####     ✕ aces can end a straight (10 J Q K A)  
####     ✕ aces can start a straight (A 2 3 4 5)  
####     ✕ both hands with a straight, tie goes to highest ranked card (1 ms)  
####     ✕ even though an ace is usually high, a 5-high straight is the lowest-scoring straight (1 ms)  
####     ✕ flush beats a straight (1 ms)  
####     ✕ both hands have a flush, tie goes to high card, down to the last one if necessary  
####     ✕ full house beats a flush  
####     ✕ both hands have a full house, tie goes to highest-ranked triplet (1 ms)  
####     ✕ with multiple decks, both hands have a full house with the same triplet, tie goes to the pair  
####     ✕ four of a kind beats a full house  
####     ✕ both hands have four of a kind, tie goes to high quad (1 ms)  
####     ✕ with multiple decks, both hands with identical four of a kind, tie determined by kicker  
####     ✕ straight flush beats four of a kind (1 ms)  
####     ✕ both hands have straight flush, tie goes to highest-ranked card  
####   
####   ● Poker › single hand always wins  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "4S 5S 7H 8D JC",  
####     - ]  
####     + Array []  
####   
####        5 |     const hands = ['4S 5S 7H 8D JC'];  
####        6 |     const expected = ['4S 5S 7H 8D JC'];  
####     >  7 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####        8 |   });  
####        9 |  
####       10 |   test('highest card out of all hands wins', () => {  
####   
####       at Object.toEqual (poker.spec.js:7:30)  
####   
####   ● Poker › highest card out of all hands wins  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "3S 4S 5D 6H JH",  
####     +   2,  
####       ]  
####   
####       11 |     const hands = ['4D 5S 6S 8D 3C', '2S 4C 7S 9H 10H', '3S 4S 5D 6H JH'];  
####       12 |     const expected = ['3S 4S 5D 6H JH'];  
####     > 13 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       14 |   });  
####       15 |  
####       16 |   test('a tie has multiple winners', () => {  
####   
####       at Object.toEqual (poker.spec.js:13:30)  
####   
####   ● Poker › a tie has multiple winners  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Array [  
####     -   "3S 4S 5D 6H JH",  
####     -   "3H 4H 5C 6C JD",  
####     +   2,  
####     +   3,  
####       ]  
####   
####       22 |     ];  
####       23 |     const expected = ['3S 4S 5D 6H JH', '3H 4H 5C 6C JD'];  
####     > 24 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       25 |   });  
####       26 |  
####       27 |   test('multiple hands with the same high cards, tie compares next highest ranked, down to last card', () => {  
####   
####       at Object.toEqual (poker.spec.js:24:30)  
####   
####   ● Poker › multiple hands with the same high cards, tie compares next highest ranked, down to last card  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "3S 5H 6S 8D 7H",  
####     - ]  
####     + Array []  
####   
####       28 |     const hands = ['3S 5H 6S 8D 7H', '2S 5D 6D 8C 7S'];  
####       29 |     const expected = ['3S 5H 6S 8D 7H'];  
####     > 30 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       31 |   });  
####       32 |  
####       33 |   test('one pair beats high card', () => {  
####   
####       at Object.toEqual (poker.spec.js:30:30)  
####   
####   ● Poker › one pair beats high card  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "2S 4H 6S 4D JH",  
####     +   1,  
####       ]  
####   
####       34 |     const hands = ['4S 5H 6C 8D KH', '2S 4H 6S 4D JH'];  
####       35 |     const expected = ['2S 4H 6S 4D JH'];  
####     > 36 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       37 |   });  
####       38 |  
####       39 |   test('highest pair wins', () => {  
####   
####       at Object.toEqual (poker.spec.js:36:30)  
####   
####   ● Poker › highest pair wins  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "2S 4H 6C 4D JD",  
####     +   1,  
####       ]  
####   
####       40 |     const hands = ['4S 2H 6S 2D JH', '2S 4H 6C 4D JD'];  
####       41 |     const expected = ['2S 4H 6C 4D JD'];  
####     > 42 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       43 |   });  
####       44 |  
####       45 |   test('two pairs beats one pair', () => {  
####   
####       at Object.toEqual (poker.spec.js:42:30)  
####   
####   ● Poker › two pairs beats one pair  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "4S 5H 4C 8C 5C",  
####     - ]  
####     + Array []  
####   
####       46 |     const hands = ['2S 8H 6S 8D JH', '4S 5H 4C 8C 5C'];  
####       47 |     const expected = ['4S 5H 4C 8C 5C'];  
####     > 48 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       49 |   });  
####       50 |  
####       51 |   test('both hands have two pairs, highest ranked pair wins', () => {  
####   
####       at Object.toEqual (poker.spec.js:48:30)  
####   
####   ● Poker › both hands have two pairs, highest ranked pair wins  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "2S 8H 2D 8D 3H",  
####     - ]  
####     + Array []  
####   
####       52 |     const hands = ['2S 8H 2D 8D 3H', '4S 5H 4C 8S 5D'];  
####       53 |     const expected = ['2S 8H 2D 8D 3H'];  
####     > 54 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       55 |   });  
####       56 |  
####       57 |   test('both hands have two pairs, with the same highest ranked pair, tie goes to low pair', () => {  
####   
####       at Object.toEqual (poker.spec.js:54:30)  
####   
####   ● Poker › both hands have two pairs, with the same highest ranked pair, tie goes to low pair  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "JD QH JS 8D QC",  
####     +   1,  
####       ]  
####   
####       58 |     const hands = ['2S QS 2C QD JH', 'JD QH JS 8D QC'];  
####       59 |     const expected = ['JD QH JS 8D QC'];  
####     > 60 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       61 |   });  
####       62 |  
####       63 |   test('both hands have two identically ranked pairs, tie goes to remaining card (kicker)', () => {  
####   
####       at Object.toEqual (poker.spec.js:60:30)  
####   
####   ● Poker › both hands have two identically ranked pairs, tie goes to remaining card (kicker)  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "JD QH JS 8D QC",  
####     - ]  
####     + Array []  
####   
####       64 |     const hands = ['JD QH JS 8D QC', 'JS QS JC 2D QD'];  
####       65 |     const expected = ['JD QH JS 8D QC'];  
####     > 66 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       67 |   });  
####       68 |  
####       69 |   test('three of a kind beats two pair', () => {  
####   
####       at Object.toEqual (poker.spec.js:66:30)  
####   
####   ● Poker › three of a kind beats two pair  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "4S 5H 4C 8S 4H",  
####     +   1,  
####       ]  
####   
####       70 |     const hands = ['2S 8H 2H 8D JH', '4S 5H 4C 8S 4H'];  
####       71 |     const expected = ['4S 5H 4C 8S 4H'];  
####     > 72 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       73 |   });  
####       74 |  
####       75 |   test('both hands have three of a kind, tie goes to highest ranked triplet', () => {  
####   
####       at Object.toEqual (poker.spec.js:72:30)  
####   
####   ● Poker › both hands have three of a kind, tie goes to highest ranked triplet  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "4S AH AS 8C AD",  
####     - ]  
####     + Array []  
####   
####       76 |     const hands = ['2S 2H 2C 8D JH', '4S AH AS 8C AD'];  
####       77 |     const expected = ['4S AH AS 8C AD'];  
####     > 78 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       79 |   });  
####       80 |  
####       81 |   test('with multiple decks, two players can have same three of a kind, ties go to highest remaining cards', () => {  
####   
####       at Object.toEqual (poker.spec.js:78:30)  
####   
####   ● Poker › with multiple decks, two players can have same three of a kind, ties go to highest remaining cards  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "4S AH AS 8C AD",  
####     +   1,  
####       ]  
####   
####       82 |     const hands = ['4S AH AS 7C AD', '4S AH AS 8C AD'];  
####       83 |     const expected = ['4S AH AS 8C AD'];  
####     > 84 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       85 |   });  
####       86 |  
####       87 |   test('a straight beats three of a kind', () => {  
####   
####       at Object.toEqual (poker.spec.js:84:30)  
####   
####   ● Poker › a straight beats three of a kind  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "3S 4D 2S 6D 5C",  
####     - ]  
####     + Array []  
####   
####       88 |     const hands = ['4S 5H 4C 8D 4H', '3S 4D 2S 6D 5C'];  
####       89 |     const expected = ['3S 4D 2S 6D 5C'];  
####     > 90 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       91 |   });  
####       92 |  
####       93 |   test('aces can end a straight (10 J Q K A)', () => {  
####   
####       at Object.toEqual (poker.spec.js:90:30)  
####   
####   ● Poker › aces can end a straight (10 J Q K A)  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "10D JH QS KD AC",  
####     - ]  
####     + Array []  
####   
####       94 |     const hands = ['4S 5H 4C 8D 4H', '10D JH QS KD AC'];  
####       95 |     const expected = ['10D JH QS KD AC'];  
####     > 96 |     expect(bestHands(hands)).toEqual(expected);  
####          |                              ^  
####       97 |   });  
####       98 |  
####       99 |   test('aces can start a straight (A 2 3 4 5)', () => {  
####   
####       at Object.toEqual (poker.spec.js:96:30)  
####   
####   ● Poker › aces can start a straight (A 2 3 4 5)  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "4D AH 3S 2D 5C",  
####     - ]  
####     + Array []  
####   
####       100 |     const hands = ['4S 5H 4C 8D 4H', '4D AH 3S 2D 5C'];  
####       101 |     const expected = ['4D AH 3S 2D 5C'];  
####     > 102 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       103 |   });  
####       104 |  
####       105 |   test('both hands with a straight, tie goes to highest ranked card', () => {  
####   
####       at Object.toEqual (poker.spec.js:102:30)  
####   
####   ● Poker › both hands with a straight, tie goes to highest ranked card  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "5S 7H 8S 9D 6H",  
####     +   1,  
####       ]  
####   
####       106 |     const hands = ['4S 6C 7S 8D 5H', '5S 7H 8S 9D 6H'];  
####       107 |     const expected = ['5S 7H 8S 9D 6H'];  
####     > 108 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       109 |   });  
####       110 |  
####       111 |   test('even though an ace is usually high, a 5-high straight is the lowest-scoring straight', () => {  
####   
####       at Object.toEqual (poker.spec.js:108:30)  
####   
####   ● Poker › even though an ace is usually high, a 5-high straight is the lowest-scoring straight  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "2H 3C 4D 5D 6H",  
####     - ]  
####     + Array []  
####   
####       112 |     const hands = ['2H 3C 4D 5D 6H', '4S AH 3S 2D 5H'];  
####       113 |     const expected = ['2H 3C 4D 5D 6H'];  
####     > 114 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       115 |   });  
####       116 |  
####       117 |   test('flush beats a straight', () => {  
####   
####       at Object.toEqual (poker.spec.js:114:30)  
####   
####   ● Poker › flush beats a straight  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "2S 4S 5S 6S 7S",  
####     +   1,  
####       ]  
####   
####       118 |     const hands = ['4C 6H 7D 8D 5H', '2S 4S 5S 6S 7S'];  
####       119 |     const expected = ['2S 4S 5S 6S 7S'];  
####     > 120 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       121 |   });  
####       122 |  
####       123 |   test('both hands have a flush, tie goes to high card, down to the last one if necessary', () => {  
####   
####       at Object.toEqual (poker.spec.js:120:30)  
####   
####   ● Poker › both hands have a flush, tie goes to high card, down to the last one if necessary  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "4H 7H 8H 9H 6H",  
####     - ]  
####     + Array []  
####   
####       124 |     const hands = ['4H 7H 8H 9H 6H', '2S 4S 5S 6S 7S'];  
####       125 |     const expected = ['4H 7H 8H 9H 6H'];  
####     > 126 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       127 |   });  
####       128 |  
####       129 |   test('full house beats a flush', () => {  
####   
####       at Object.toEqual (poker.spec.js:126:30)  
####   
####   ● Poker › full house beats a flush  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "4S 5H 4C 5D 4H",  
####     +   1,  
####       ]  
####   
####       130 |     const hands = ['3H 6H 7H 8H 5H', '4S 5H 4C 5D 4H'];  
####       131 |     const expected = ['4S 5H 4C 5D 4H'];  
####     > 132 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       133 |   });  
####       134 |  
####       135 |   test('both hands have a full house, tie goes to highest-ranked triplet', () => {  
####   
####       at Object.toEqual (poker.spec.js:132:30)  
####   
####   ● Poker › both hands have a full house, tie goes to highest-ranked triplet  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "5H 5S 5D 8S 8D",  
####     - ]  
####     + Array []  
####   
####       136 |     const hands = ['4H 4S 4D 9S 9D', '5H 5S 5D 8S 8D'];  
####       137 |     const expected = ['5H 5S 5D 8S 8D'];  
####     > 138 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       139 |   });  
####       140 |  
####       141 |   test('with multiple decks, both hands have a full house with the same triplet, tie goes to the pair', () => {  
####   
####       at Object.toEqual (poker.spec.js:138:30)  
####   
####   ● Poker › with multiple decks, both hands have a full house with the same triplet, tie goes to the pair  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "5H 5S 5D 9S 9D",  
####     - ]  
####     + Array []  
####   
####       142 |     const hands = ['5H 5S 5D 9S 9D', '5H 5S 5D 8S 8D'];  
####       143 |     const expected = ['5H 5S 5D 9S 9D'];  
####     > 144 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       145 |   });  
####       146 |  
####       147 |   test('four of a kind beats a full house', () => {  
####   
####       at Object.toEqual (poker.spec.js:144:30)  
####   
####   ● Poker › four of a kind beats a full house  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "3S 3H 2S 3D 3C",  
####     - ]  
####     + Array []  
####   
####       148 |     const hands = ['4S 5H 4D 5D 4H', '3S 3H 2S 3D 3C'];  
####       149 |     const expected = ['3S 3H 2S 3D 3C'];  
####     > 150 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       151 |   });  
####       152 |  
####       153 |   test('both hands have four of a kind, tie goes to high quad', () => {  
####   
####       at Object.toEqual (poker.spec.js:150:30)  
####   
####   ● Poker › both hands have four of a kind, tie goes to high quad  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "4S 5H 5S 5D 5C",  
####     - ]  
####     + Array []  
####   
####       154 |     const hands = ['2S 2H 2C 8D 2D', '4S 5H 5S 5D 5C'];  
####       155 |     const expected = ['4S 5H 5S 5D 5C'];  
####     > 156 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       157 |   });  
####       158 |  
####       159 |   test('with multiple decks, both hands with identical four of a kind, tie determined by kicker', () => {  
####   
####       at Object.toEqual (poker.spec.js:156:30)  
####   
####   ● Poker › with multiple decks, both hands with identical four of a kind, tie determined by kicker  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 3  
####     + Received  + 1  
####   
####     - Array [  
####     -   "3S 3H 4S 3D 3C",  
####     - ]  
####     + Array []  
####   
####       160 |     const hands = ['3S 3H 2S 3D 3C', '3S 3H 4S 3D 3C'];  
####       161 |     const expected = ['3S 3H 4S 3D 3C'];  
####     > 162 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       163 |   });  
####       164 |  
####       165 |   test('straight flush beats four of a kind', () => {  
####   
####       at Object.toEqual (poker.spec.js:162:30)  
####   
####   ● Poker › straight flush beats four of a kind  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "7S 8S 9S 6S 10S",  
####     +   1,  
####       ]  
####   
####       166 |     const hands = ['4S 5H 5S 5D 5C', '7S 8S 9S 6S 10S'];  
####       167 |     const expected = ['7S 8S 9S 6S 10S'];  
####     > 168 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       169 |   });  
####       170 |  
####       171 |   test('both hands have straight flush, tie goes to highest-ranked card', () => {  
####   
####       at Object.toEqual (poker.spec.js:168:30)  
####   
####   ● Poker › both hands have straight flush, tie goes to highest-ranked card  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   "5S 7S 8S 9S 6S",  
####     +   1,  
####       ]  
####   
####       172 |     const hands = ['4H 6H 7H 8H 5H', '5S 7S 8S 9S 6S'];  
####       173 |     const expected = ['5S 7S 8S 9S 6S'];  
####     > 174 |     expect(bestHands(hands)).toEqual(expected);  
####           |                              ^  
####       175 |   });  
####       176 | });  
####       177 |  
####   
####       at Object.toEqual (poker.spec.js:174:30)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       28 failed, 28 total  
#### Snapshots:   0 total  
#### Time:        0.558 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./poker.js|./poker.spec.js.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in poker.js to resolve the errors.  

The tests expect `bestHands` to return the actual hand **strings**, not indices. Also, there's a bug where a single hand returns an empty array because `result` is never initialized with index 0.

Let me fix the `bestHands` function:

poker.js
```javascript
<<<<<<< SEARCH
export const bestHands = (hands) => {
  const scores = hands.map(scoreHand);
  const result = [];
  let best = scores[0];
  for (let i = 1; i < scores.length; i++) {
    const cmp = compareScore(scores[i], best);
    if (cmp > 0) {
      best = scores[i];
      result.length = 0;
      result.push(i);
    } else if (cmp === 0) {
      result.push(i);
    }
  }
  return result;
};
=======
export const bestHands = (hands) => {
  const scores = hands.map(scoreHand);
  const result = [0];
  let best = scores[0];
  for (let i = 1; i < scores.length; i++) {
    const cmp = compareScore(scores[i], best);
    if (cmp > 0) {
      best = scores[i];
      result.length = 0;
      result.push(i);
    } else if (cmp === 0) {
      result.push(i);
    }
  }
  return result.map((i) => hands[i]);
};
>>>>>>> REPLACE
```

> Tokens: 11k sent, 2.9k received.  
> Applied edit to poker.js  
```

> test
> jest ./*

FAIL ./poker.spec.js
  Poker
    ✓ single hand always wins (3 ms)
    ✓ highest card out of all hands wins
    ✓ a tie has multiple winners (1 ms)
    ✓ multiple hands with the same high cards, tie compares next highest ranked, down to last card
    ✓ one pair beats high card (1 ms)
    ✓ highest pair wins (1 ms)
    ✕ two pairs beats one pair (3 ms)
    ✓ both hands have two pairs, highest ranked pair wins (1 ms)
    ✓ both hands have two pairs, with the same highest ranked pair, tie goes to low pair (1 ms)
    ✓ both hands have two identically ranked pairs, tie goes to remaining card (kicker) (1 ms)
    ✓ three of a kind beats two pair
    ✕ both hands have three of a kind, tie goes to highest ranked triplet (1 ms)
    ✓ with multiple decks, two players can have same three of a kind, ties go to highest remaining cards
    ✕ a straight beats three of a kind
    ✕ aces can end a straight (10 J Q K A) (1 ms)
    ✕ aces can start a straight (A 2 3 4 5) (1 ms)
    ✓ both hands with a straight, tie goes to highest ranked card (1 ms)
    ✓ even though an ace is usually high, a 5-high straight is the lowest-scoring straight
    ✓ flush beats a straight
    ✓ both hands have a flush, tie goes to high card, down to the last one if necessary (1 ms)
    ✓ full house beats a flush
    ✕ both hands have a full house, tie goes to highest-ranked triplet
    ✓ with multiple decks, both hands have a full house with the same triplet, tie goes to the pair
    ✕ four of a kind beats a full house
    ✕ both hands have four of a kind, tie goes to high quad
    ✕ with multiple decks, both hands with identical four of a kind, tie determined by kicker
    ✓ straight flush beats four of a kind (1 ms)
    ✓ both hands have straight flush, tie goes to highest-ranked card

  ● Poker › two pairs beats one pair

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "4S 5H 4C 8C 5C",
    +   "2S 8H 6S 8D JH",
      ]

      46 |     const hands = ['2S 8H 6S 8D JH', '4S 5H 4C 8C 5C'];
      47 |     const expected = ['4S 5H 4C 8C 5C'];
    > 48 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      49 |   });
      50 |
      51 |   test('both hands have two pairs, highest ranked pair wins', () => {

      at Object.toEqual (poker.spec.js:48:30)

  ● Poker › both hands have three of a kind, tie goes to highest ranked triplet

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "4S AH AS 8C AD",
    +   "2S 2H 2C 8D JH",
      ]

      76 |     const hands = ['2S 2H 2C 8D JH', '4S AH AS 8C AD'];
      77 |     const expected = ['4S AH AS 8C AD'];
    > 78 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      79 |   });
      80 |
      81 |   test('with multiple decks, two players can have same three of a kind, ties go to highest remaining cards', () => {

      at Object.toEqual (poker.spec.js:78:30)

  ● Poker › a straight beats three of a kind

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "3S 4D 2S 6D 5C",
    +   "4S 5H 4C 8D 4H",
      ]

      88 |     const hands = ['4S 5H 4C 8D 4H', '3S 4D 2S 6D 5C'];
      89 |     const expected = ['3S 4D 2S 6D 5C'];
    > 90 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      91 |   });
      92 |
      93 |   test('aces can end a straight (10 J Q K A)', () => {

      at Object.toEqual (poker.spec.js:90:30)

  ● Poker › aces can end a straight (10 J Q K A)

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "10D JH QS KD AC",
    +   "4S 5H 4C 8D 4H",
      ]

      94 |     const hands = ['4S 5H 4C 8D 4H', '10D JH QS KD AC'];
      95 |     const expected = ['10D JH QS KD AC'];
    > 96 |     expect(bestHands(hands)).toEqual(expected);
         |                              ^
      97 |   });
      98 |
      99 |   test('aces can start a straight (A 2 3 4 5)', () => {

      at Object.toEqual (poker.spec.js:96:30)

  ● Poker › aces can start a straight (A 2 3 4 5)

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "4D AH 3S 2D 5C",
    +   "4S 5H 4C 8D 4H",
      ]

      100 |     const hands = ['4S 5H 4C 8D 4H', '4D AH 3S 2D 5C'];
      101 |     const expected = ['4D AH 3S 2D 5C'];
    > 102 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      103 |   });
      104 |
      105 |   test('both hands with a straight, tie goes to highest ranked card', () => {

      at Object.toEqual (poker.spec.js:102:30)

  ● Poker › both hands have a full house, tie goes to highest-ranked triplet

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "5H 5S 5D 8S 8D",
    +   "4H 4S 4D 9S 9D",
      ]

      136 |     const hands = ['4H 4S 4D 9S 9D', '5H 5S 5D 8S 8D'];
      137 |     const expected = ['5H 5S 5D 8S 8D'];
    > 138 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      139 |   });
      140 |
      141 |   test('with multiple decks, both hands have a full house with the same triplet, tie goes to the pair', () => {

      at Object.toEqual (poker.spec.js:138:30)

  ● Poker › four of a kind beats a full house

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "3S 3H 2S 3D 3C",
    +   "4S 5H 4D 5D 4H",
      ]

      148 |     const hands = ['4S 5H 4D 5D 4H', '3S 3H 2S 3D 3C'];
      149 |     const expected = ['3S 3H 2S 3D 3C'];
    > 150 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      151 |   });
      152 |
      153 |   test('both hands have four of a kind, tie goes to high quad', () => {

      at Object.toEqual (poker.spec.js:150:30)

  ● Poker › both hands have four of a kind, tie goes to high quad

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "4S 5H 5S 5D 5C",
    +   "2S 2H 2C 8D 2D",
      ]

      154 |     const hands = ['2S 2H 2C 8D 2D', '4S 5H 5S 5D 5C'];
      155 |     const expected = ['4S 5H 5S 5D 5C'];
    > 156 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      157 |   });
      158 |
      159 |   test('with multiple decks, both hands with identical four of a kind, tie determined by kicker', () => {

      at Object.toEqual (poker.spec.js:156:30)

  ● Poker › with multiple decks, both hands with identical four of a kind, tie determined by kicker

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   "3S 3H 4S 3D 3C",
    +   "3S 3H 2S 3D 3C",
      ]

      160 |     const hands = ['3S 3H 2S 3D 3C', '3S 3H 4S 3D 3C'];
      161 |     const expected = ['3S 3H 4S 3D 3C'];
    > 162 |     expect(bestHands(hands)).toEqual(expected);
          |                              ^
      163 |   });
      164 |
      165 |   test('straight flush beats four of a kind', () => {

      at Object.toEqual (poker.spec.js:162:30)

Test Suites: 1 failed, 1 total
Tests:       9 failed, 19 passed, 28 total
Snapshots:   0 total
Time:        0.509 s, estimated 1 s
Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./poker.js|./poker.spec.js.

```