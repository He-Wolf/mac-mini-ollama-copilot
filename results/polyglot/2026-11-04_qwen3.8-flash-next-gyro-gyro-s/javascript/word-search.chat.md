
# aider chat started at 2026-11-04 16:14:11

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-flash-next-gyro-gyro-s with diff edit format, reasoning none  
> Git repo: none  
> Repo-map: disabled  
> Added word-search.js to the chat.  

#### # Instructions  
####   
#### In word search puzzles you get a square of letters and have to find specific words in them.  
####   
#### For example:  
####   
#### ```text  
#### jefblpepre  
#### camdcimgtc  
#### oivokprjsm  
#### pbwasqroua  
#### rixilelhrs  
#### wolcqlirpc  
#### screeaumgr  
#### alxhpburyi  
#### jalaycalmp  
#### clojurermt  
#### ```  
####   
#### There are several programming languages hidden in the above square.  
####   
#### Words can be hidden in all kinds of directions: left-to-right, right-to-left, vertical and diagonal.  
####   
#### Given a puzzle and a list of words return the location of the first and last letter of each word.  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: word-search.js  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

To implement the Word Search exercise, we need to replace the skeleton code in `word-search.js` with a full implementation.

1.  **Constructor**: Store the puzzle grid (array of strings) and its dimensions.
2.  **find method**: Accept an array of words. For each word, search the grid in all 8 directions (horizontal, vertical, diagonal). If found, return an object mapping the word to its start and end coordinates `{ start: [x, y], end: [x, y] }`. If not found, map it to `null`.
3.  **Helper logic**: Iterate through every cell in the grid as a potential starting point for each direction. Check if the word fits within bounds and matches characters along that direction.

Here is the *SEARCH/REPLACE* block:

word-search.js
```javascript
<<<<<<< SEARCH
//
// This is only a SKELETON file for the 'Word Search' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

class WordSearch {
  constructor() {
    throw new Error('Remove this statement and implement this function');
  }

  find() {
    throw new Error('Remove this statement and implement this function');
  }
}

export default WordSearch;
=======
class WordSearch {
  constructor(grid) {
    this.grid = grid;
    this.rows = grid.length;
    this.cols = grid[0] ? grid[0].length : 0;
  }

  find(words) {
    const result = {};
    const directions = [
      [0, 1],   // right
      [0, -1],  // left
      [1, 0],   // down
      [-1, 0],  // up
      [1, 1],   // down-right
      [1, -1],  // down-left
      [-1, 1],  // up-right
      [-1, -1]  // up-left
    ];

    for (const word of words) {
      let found = null;
      outer: for (let r = 0; r < this.rows; r++) {
        for (let c = 0; c < this.cols; c++) {
          for (const [dr, dc] of directions) {
            if (this.checkWord(word, r, c, dr, dc)) {
              const endR = r + (word.length - 1) * dr;
              const endC = c + (word.length - 1) * dc;
              found = { start: [c + 1, r + 1], end: [endC + 1, endR + 1] };
              break outer;
            }
          }
        }
      }
      result[word] = found;
    }

    return result;
  }

  checkWord(word, startRow, startCol, dr, dc) {
    for (let i = 0; i < word.length; i++) {
      const r = startRow + i * dr;
      const c = startCol + i * dc;
      if (r < 0 || r >= this.rows || c < 0 || c >= this.cols) {
        return false;
      }
      if (this.grid[r][c] !== word[i]) {
        return false;
      }
    }
    return true;
  }
}

export default WordSearch;
>>>>>>> REPLACE
```

> Tokens: 2.3k sent, 773 received.  
> Applied edit to word-search.js  
```

> test
> jest ./*

FAIL ./word-search.spec.js
  single line grids
    ✓ Should accept an initial game grid (3 ms)
    ✕ can accept a target search word (4 ms)
    ✕ should locate a word written left to right (1 ms)
    ✕ can locate a left to right word in a different position (2 ms)
    ✕ can locate a different left to right word (1 ms)
    ✕ can locate that different left to right word in a different position (1 ms)
  multi line grids
    ✕ can locate a left to right word in a two line grid (1 ms)
    ✕ can locate a left to right word in a different position in a two line grid
    ✕ can locate a left to right word in a three line grid (1 ms)
    ✕ can locate a left to right word in a ten line grid (2 ms)
    ✕ can locate a left to right word in a different position in a ten line grid (1 ms)
    ✕ can locate a different left to right word in a ten line grid (1 ms)
  can find multiple words
    ✕ can find two words written left to right (1 ms)
  different directions
    ✕ should locate a single word written right to left (1 ms)
    ✕ should locate multiple words written in different horizontal directions (1 ms)
  vertical directions
    ✕ should locate words written top to bottom (2 ms)
    ✕ should locate words written bottom to top (2 ms)
    ✕ should locate words written top left to bottom right (1 ms)
    ✕ should locate words written bottom right to top left (2 ms)
    ✕ should locate words written bottom left to top right (2 ms)
    ✕ should locate words written top right to bottom left (2 ms)
    word doesn't exist
      ✕ should fail to locate a word that is not in the puzzle (1 ms)

  ● single line grids › can accept a target search word

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Object {
    -   "glasnost": undefined,
    +   "glasnost": null,
      }

      13 |     const wordSearch = new WordSearch(grid);
      14 |
    > 15 |     expect(wordSearch.find(['glasnost'])).toEqual({ glasnost: undefined });
         |                                           ^
      16 |   });
      17 |
      18 |   test('should locate a word written left to right', () => {

      at Object.toEqual (word-search.spec.js:15:43)

  ● single line grids › should locate a word written left to right

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

    @@ -1,10 +1,10 @@
      Object {
        "clojure": Object {
          "end": Array [
    -       1,
            7,
    +       1,
          ],
          "start": Array [
            1,
            1,
          ],

      26 |     const wordSearch = new WordSearch(grid);
      27 |
    > 28 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);
         |                                          ^
      29 |   });
      30 |
      31 |   test('can locate a left to right word in a different position', () => {

      at Object.toEqual (word-search.spec.js:28:42)

  ● single line grids › can locate a left to right word in a different position

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Object {
        "clojure": Object {
          "end": Array [
    -       1,
            9,
    +       1,
          ],
          "start": Array [
    +       3,
            1,
    -       3,
          ],
        },
      }

      39 |     const wordSearch = new WordSearch(grid);
      40 |
    > 41 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);
         |                                          ^
      42 |   });
      43 |
      44 |   test('can locate a different left to right word', () => {

      at Object.toEqual (word-search.spec.js:41:42)

  ● single line grids › can locate a different left to right word

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

    @@ -1,10 +1,10 @@
      Object {
        "coffee": Object {
          "end": Array [
    -       1,
            6,
    +       1,
          ],
          "start": Array [
            1,
            1,
          ],

      52 |     const wordSearch = new WordSearch(grid);
      53 |
    > 54 |     expect(wordSearch.find(['coffee'])).toEqual(expectedResults);
         |                                         ^
      55 |   });
      56 |   test('can locate that different left to right word in a different position', () => {
      57 |     const grid = ['xcoffeezlp'];

      at Object.toEqual (word-search.spec.js:54:41)

  ● single line grids › can locate that different left to right word in a different position

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Object {
        "coffee": Object {
          "end": Array [
    -       1,
            7,
    +       1,
          ],
          "start": Array [
    +       2,
            1,
    -       2,
          ],
        },
      }

      64 |     const wordSearch = new WordSearch(grid);
      65 |
    > 66 |     expect(wordSearch.find(['coffee'])).toEqual(expectedResults);
         |                                         ^
      67 |   });
      68 | });
      69 |

      at Object.toEqual (word-search.spec.js:66:41)

  ● multi line grids › can locate a left to right word in a two line grid

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Object {
        "clojure": Object {
          "end": Array [
    -       2,
            7,
    +       2,
          ],
          "start": Array [
    +       1,
            2,
    -       1,
          ],
        },
      }

      81 |     const wordSearch = new WordSearch(grid);
      82 |
    > 83 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);
         |                                          ^
      84 |   });
      85 |   test('can locate a left to right word in a different position in a two line grid', () => {
      86 |     const grid = ['jefblpepre', 'tclojurerm'];

      at Object.toEqual (word-search.spec.js:83:42)

  ● multi line grids › can locate a left to right word in a different position in a two line grid

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

    @@ -1,10 +1,10 @@
      Object {
        "clojure": Object {
          "end": Array [
    -       2,
            8,
    +       2,
          ],
          "start": Array [
            2,
            2,
          ],

      93 |     const wordSearch = new WordSearch(grid);
      94 |
    > 95 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);
         |                                          ^
      96 |   });
      97 |   test('can locate a left to right word in a three line grid', () => {
      98 |     const grid = ['camdcimgtc', 'jefblpepre', 'clojurermt'];

      at Object.toEqual (word-search.spec.js:95:42)

  ● multi line grids › can locate a left to right word in a three line grid

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Object {
        "clojure": Object {
          "end": Array [
    -       3,
            7,
    +       3,
          ],
          "start": Array [
    +       1,
            3,
    -       1,
          ],
        },
      }

      105 |     const wordSearch = new WordSearch(grid);
      106 |
    > 107 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);
          |                                          ^
      108 |   });
      109 |
      110 |   test('can locate a left to right word in a ten line grid', () => {

      at Object.toEqual (word-search.spec.js:107:42)

  ● multi line grids › can locate a left to right word in a ten line grid

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Object {
        "clojure": Object {
          "end": Array [
    -       10,
            7,
    +       10,
          ],
          "start": Array [
    +       1,
            10,
    -       1,
          ],
        },
      }

      130 |     const wordSearch = new WordSearch(grid);
      131 |
    > 132 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);
          |                                          ^
      133 |   });
      134 |
      135 |   test('can locate a left to right word in a different position in a ten line grid', () => {

      at Object.toEqual (word-search.spec.js:132:42)

  ● multi line grids › can locate a left to right word in a different position in a ten line grid

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Object {
        "clojure": Object {
          "end": Array [
    -       9,
            7,
    +       9,
          ],
          "start": Array [
    +       1,
            9,
    -       1,
          ],
        },
      }

      155 |     const wordSearch = new WordSearch(grid);
      156 |
    > 157 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);
          |                                          ^
      158 |   });
      159 |   test('can locate a different left to right word in a ten line grid', () => {
      160 |     const grid = [

      at Object.toEqual (word-search.spec.js:157:42)

  ● multi line grids › can locate a different left to right word in a ten line grid

    expect(received).toEqual(expected) // deep equality

    - Expected  - 2
    + Received  + 2

      Object {
        "scree": Object {
          "end": Array [
    -       7,
            5,
    +       7,
          ],
          "start": Array [
    +       1,
            7,
    -       1,
          ],
        },
      }

      178 |     const wordSearch = new WordSearch(grid);
      179 |
    > 180 |     expect(wordSearch.find(['scree'])).toEqual(expectedResults);
          |                                        ^
      181 |   });
      182 | });
      183 |

      at Object.toEqual (word-search.spec.js:180:40)

  ● can find multiple words › can find two words written left to right

    expect(received).toEqual(expected) // deep equality

    - Expected  - 4
    + Received  + 4

      Object {
        "clojure": Object {
          "end": Array [
    -       10,
            7,
    +       10,
          ],
          "start": Array [
    +       1,
            10,
    -       1,
          ],
        },
        "java": Object {
          "end": Array [
    +       5,
            11,
    -       5,
          ],
          "start": Array [
    -       11,
            2,
    +       11,
          ],
        },
      }

      209 |     const wordSearch = new WordSearch(grid);
      210 |
    > 211 |     expect(wordSearch.find(['java', 'clojure'])).toEqual(expectedResults);
          |                                                  ^
      212 |   });
      213 | });
      214 |

      at Object.toEqual (word-search.spec.js:211:50)

  ● different directions › should locate a single word written right to left

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

    @@ -3,10 +3,10 @@
          "end": Array [
            1,
            1,
          ],
          "start": Array [
    -       1,
            6,
    +       1,
          ],
        },
      }

      224 |     const wordSearch = new WordSearch(grid);
      225 |
    > 226 |     expect(wordSearch.find(['elixir'])).toEqual(expectedResults);
          |                                         ^
      227 |   });
      228 |   test('should locate multiple words written in different horizontal directions', () => {
      229 |     const grid = [

      at Object.toEqual (word-search.spec.js:226:41)

  ● different directions › should locate multiple words written in different horizontal directions

    expect(received).toEqual(expected) // deep equality

    - Expected  - 4
    + Received  + 4

      Object {
        "clojure": Object {
          "end": Array [
    -       10,
            7,
    +       10,
          ],
          "start": Array [
    +       1,
            10,
    -       1,
          ],
        },
        "elixir": Object {
          "end": Array [
    +       1,
            5,
    -       1,
          ],
          "start": Array [
    -       5,
            6,
    +       5,
          ],
        },
      }

      251 |     const wordSearch = new WordSearch(grid);
      252 |
    > 253 |     expect(wordSearch.find(['elixir', 'clojure'])).toEqual(expectedResults);
          |                                                    ^
      254 |   });
      255 | });
      256 |

      at Object.toEqual (word-search.spec.js:253:52)

  ● vertical directions › should locate words written top to bottom

    expect(received).toEqual(expected) // deep equality

    - Expected  - 5
    + Received  + 5

      Object {
        "clojure": Object {
          "end": Array [
    +       7,
            10,
    -       7,
          ],
          "start": Array [
    -       10,
            1,
    +       10,
          ],
        },
        "ecmascript": Object {
          "end": Array [
            10,
            10,
          ],
          "start": Array [
    -       1,
            10,
    +       1,
          ],
        },
        "elixir": Object {
          "end": Array [
    -       5,
            1,
    +       5,
          ],
          "start": Array [
    +       6,
            5,
    -       6,
          ],
        },
      }

      285 |     const wordSearch = new WordSearch(grid);
      286 |
    > 287 |     expect(wordSearch.find(['elixir', 'clojure', 'ecmascript'])).toEqual(
          |                                                                  ^
      288 |       expectedResults,
      289 |     );
      290 |   });

      at Object.toEqual (word-search.spec.js:287:66)

  ● vertical directions › should locate words written bottom to top

    expect(received).toEqual(expected) // deep equality

    - Expected  - 7
    + Received  + 7

      Object {
        "clojure": Object {
          "end": Array [
    -       10,
            7,
    +       10,
          ],
          "start": Array [
    +       1,
            10,
    -       1,
          ],
        },
        "ecmascript": Object {
          "end": Array [
            10,
            10,
          ],
          "start": Array [
    +       10,
            1,
    -       10,
          ],
        },
        "elixir": Object {
          "end": Array [
    -       5,
            1,
    +       5,
          ],
          "start": Array [
    +       6,
            5,
    -       6,
          ],
        },
        "rust": Object {
          "end": Array [
    -       2,
            9,
    +       2,
          ],
          "start": Array [
    -       5,
            9,
    +       5,
          ],
        },
      }

      324 |     expect(
      325 |       wordSearch.find(['elixir', 'clojure', 'ecmascript', 'rust']),
    > 326 |     ).toEqual(expectedResults);
          |       ^
      327 |   });
      328 |   test('should locate words written top left to bottom right', () => {
      329 |     const grid = [

      at Object.toEqual (word-search.spec.js:326:7)

  ● vertical directions › should locate words written top left to bottom right

    expect(received).toEqual(expected) // deep equality

    - Expected  - 7
    + Received  + 7

    @@ -1,34 +1,34 @@
      Object {
        "clojure": Object {
          "end": Array [
    -       10,
            7,
    +       10,
          ],
          "start": Array [
    +       1,
            10,
    -       1,
          ],
        },
        "ecmascript": Object {
          "end": Array [
            10,
            10,
          ],
          "start": Array [
    +       10,
            1,
    -       10,
          ],
        },
        "elixir": Object {
          "end": Array [
    -       5,
            1,
    +       5,
          ],
          "start": Array [
    +       6,
            5,
    -       6,
          ],
        },
        "java": Object {
          "end": Array [
            4,
    @@ -39,14 +39,14 @@
            1,
          ],
        },
        "rust": Object {
          "end": Array [
    -       2,
            9,
    +       2,
          ],
          "start": Array [
    -       5,
            9,
    +       5,
          ],
        },
      }

      365 |     expect(
      366 |       wordSearch.find(['clojure', 'elixir', 'ecmascript', 'rust', 'java']),
    > 367 |     ).toEqual(expectedResults);
          |       ^
      368 |   });
      369 |   test('should locate words written bottom right to top left', () => {
      370 |     const grid = [

      at Object.toEqual (word-search.spec.js:367:7)

  ● vertical directions › should locate words written bottom right to top left

    expect(received).toEqual(expected) // deep equality

    - Expected  - 9
    + Received  + 9

    @@ -1,34 +1,34 @@
      Object {
        "clojure": Object {
          "end": Array [
    +       7,
            10,
    -       7,
          ],
          "start": Array [
    -       10,
            1,
    +       10,
          ],
        },
        "ecmascript": Object {
          "end": Array [
            10,
            10,
          ],
          "start": Array [
    -       1,
            10,
    +       1,
          ],
        },
        "elixir": Object {
          "end": Array [
    +       1,
            5,
    -       1,
          ],
          "start": Array [
    -       5,
            6,
    +       5,
          ],
        },
        "java": Object {
          "end": Array [
            4,
    @@ -39,24 +39,24 @@
            1,
          ],
        },
        "lua": Object {
          "end": Array [
    -       7,
            6,
    +       7,
          ],
          "start": Array [
    +       8,
            9,
    -       8,
          ],
        },
        "rust": Object {
          "end": Array [
    +       9,
            2,
    -       9,
          ],
          "start": Array [
    -       5,
            9,
    +       5,
          ],
        },
      }

      418 |         'lua',
      419 |       ]),
    > 420 |     ).toEqual(expectedResults);
          |       ^
      421 |   });
      422 |   test('should locate words written bottom left to top right', () => {
      423 |     const grid = [

      at Object.toEqual (word-search.spec.js:420:7)

  ● vertical directions › should locate words written bottom left to top right

    expect(received).toEqual(expected) // deep equality

    - Expected  - 11
    + Received  + 11

    @@ -1,34 +1,34 @@
      Object {
        "clojure": Object {
          "end": Array [
    -       10,
            7,
    +       10,
          ],
          "start": Array [
    +       1,
            10,
    -       1,
          ],
        },
        "ecmascript": Object {
          "end": Array [
            10,
            10,
          ],
          "start": Array [
    +       10,
            1,
    -       10,
          ],
        },
        "elixir": Object {
          "end": Array [
    +       1,
            5,
    -       1,
          ],
          "start": Array [
    -       5,
            6,
    +       5,
          ],
        },
        "java": Object {
          "end": Array [
            4,
    @@ -39,34 +39,34 @@
            1,
          ],
        },
        "lisp": Object {
          "end": Array [
    -       3,
            6,
    +       3,
          ],
          "start": Array [
    +       3,
            6,
    -       3,
          ],
        },
        "lua": Object {
          "end": Array [
    -       7,
            6,
    +       7,
          ],
          "start": Array [
    -       9,
            8,
    +       9,
          ],
        },
        "rust": Object {
          "end": Array [
    -       2,
            9,
    +       2,
          ],
          "start": Array [
    +       9,
            5,
    -       9,
          ],
        },
      }

      476 |         'lisp',
      477 |       ]),
    > 478 |     ).toEqual(expectedResults);
          |       ^
      479 |   });
      480 |   test('should locate words written top right to bottom left', () => {
      481 |     const grid = [

      at Object.toEqual (word-search.spec.js:478:7)

  ● vertical directions › should locate words written top right to bottom left

    expect(received).toEqual(expected) // deep equality

    - Expected  - 13
    + Received  + 13

    @@ -1,34 +1,34 @@
      Object {
        "clojure": Object {
          "end": Array [
    -       10,
            7,
    +       10,
          ],
          "start": Array [
    +       1,
            10,
    -       1,
          ],
        },
        "ecmascript": Object {
          "end": Array [
            10,
            10,
          ],
          "start": Array [
    +       10,
            1,
    -       10,
          ],
        },
        "elixir": Object {
          "end": Array [
    -       5,
            1,
    +       5,
          ],
          "start": Array [
    +       6,
            5,
    -       6,
          ],
        },
        "java": Object {
          "end": Array [
            4,
    @@ -39,44 +39,44 @@
            1,
          ],
        },
        "lisp": Object {
          "end": Array [
    -       3,
            6,
    +       3,
          ],
          "start": Array [
    -       6,
            3,
    +       6,
          ],
        },
        "lua": Object {
          "end": Array [
    +       6,
            7,
    -       6,
          ],
          "start": Array [
    -       9,
            8,
    +       9,
          ],
        },
        "ruby": Object {
          "end": Array [
    -       9,
            5,
    +       9,
          ],
          "start": Array [
    +       8,
            6,
    -       8,
          ],
        },
        "rust": Object {
          "end": Array [
    +       9,
            2,
    -       9,
          ],
          "start": Array [
    +       9,
            5,
    -       9,
          ],
        },
      }

      539 |         'ruby',
      540 |       ]),
    > 541 |     ).toEqual(expectedResults);
          |       ^
      542 |   });
      543 |
      544 |   describe("word doesn't exist", () => {

      at Object.toEqual (word-search.spec.js:541:7)

  ● vertical directions › word doesn't exist › should fail to locate a word that is not in the puzzle

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Object {
    -   "fail": undefined,
    +   "fail": null,
      }

      562 |       const wordSearch = new WordSearch(grid);
      563 |
    > 564 |       expect(wordSearch.find(['fail'])).toEqual(expectedResults);
          |                                         ^
      565 |     });
      566 |   });
      567 | });

      at Object.toEqual (word-search.spec.js:564:41)

Test Suites: 1 failed, 1 total
Tests:       21 failed, 1 passed, 22 total
Snapshots:   0 total
Time:        0.584 s
Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./word-search.js|./word-search.spec.js.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./word-search.spec.js  
####   single line grids  
####     ✓ Should accept an initial game grid (3 ms)  
####     ✕ can accept a target search word (4 ms)  
####     ✕ should locate a word written left to right (1 ms)  
####     ✕ can locate a left to right word in a different position (2 ms)  
####     ✕ can locate a different left to right word (1 ms)  
####     ✕ can locate that different left to right word in a different position (1 ms)  
####   multi line grids  
####     ✕ can locate a left to right word in a two line grid (1 ms)  
####     ✕ can locate a left to right word in a different position in a two line grid  
####     ✕ can locate a left to right word in a three line grid (1 ms)  
####     ✕ can locate a left to right word in a ten line grid (2 ms)  
####     ✕ can locate a left to right word in a different position in a ten line grid (1 ms)  
####     ✕ can locate a different left to right word in a ten line grid (1 ms)  
####   can find multiple words  
####     ✕ can find two words written left to right (1 ms)  
####   different directions  
####     ✕ should locate a single word written right to left (1 ms)  
####     ✕ should locate multiple words written in different horizontal directions (1 ms)  
####   vertical directions  
####     ✕ should locate words written top to bottom (2 ms)  
####     ✕ should locate words written bottom to top (2 ms)  
####     ✕ should locate words written top left to bottom right (1 ms)  
####     ✕ should locate words written bottom right to top left (2 ms)  
####     ✕ should locate words written bottom left to top right (2 ms)  
####     ✕ should locate words written top right to bottom left (2 ms)  
####     word doesn't exist  
####       ✕ should fail to locate a word that is not in the puzzle (1 ms)  
####   
####   ● single line grids › can accept a target search word  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Object {  
####     -   "glasnost": undefined,  
####     +   "glasnost": null,  
####       }  
####   
####       13 |     const wordSearch = new WordSearch(grid);  
####       14 |  
####     > 15 |     expect(wordSearch.find(['glasnost'])).toEqual({ glasnost: undefined });  
####          |                                           ^  
####       16 |   });  
####       17 |  
####       18 |   test('should locate a word written left to right', () => {  
####   
####       at Object.toEqual (word-search.spec.js:15:43)  
####   
####   ● single line grids › should locate a word written left to right  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####     @@ -1,10 +1,10 @@  
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       1,  
####             7,  
####     +       1,  
####           ],  
####           "start": Array [  
####             1,  
####             1,  
####           ],  
####   
####       26 |     const wordSearch = new WordSearch(grid);  
####       27 |  
####     > 28 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);  
####          |                                          ^  
####       29 |   });  
####       30 |  
####       31 |   test('can locate a left to right word in a different position', () => {  
####   
####       at Object.toEqual (word-search.spec.js:28:42)  
####   
####   ● single line grids › can locate a left to right word in a different position  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       1,  
####             9,  
####     +       1,  
####           ],  
####           "start": Array [  
####     +       3,  
####             1,  
####     -       3,  
####           ],  
####         },  
####       }  
####   
####       39 |     const wordSearch = new WordSearch(grid);  
####       40 |  
####     > 41 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);  
####          |                                          ^  
####       42 |   });  
####       43 |  
####       44 |   test('can locate a different left to right word', () => {  
####   
####       at Object.toEqual (word-search.spec.js:41:42)  
####   
####   ● single line grids › can locate a different left to right word  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####     @@ -1,10 +1,10 @@  
####       Object {  
####         "coffee": Object {  
####           "end": Array [  
####     -       1,  
####             6,  
####     +       1,  
####           ],  
####           "start": Array [  
####             1,  
####             1,  
####           ],  
####   
####       52 |     const wordSearch = new WordSearch(grid);  
####       53 |  
####     > 54 |     expect(wordSearch.find(['coffee'])).toEqual(expectedResults);  
####          |                                         ^  
####       55 |   });  
####       56 |   test('can locate that different left to right word in a different position', () => {  
####       57 |     const grid = ['xcoffeezlp'];  
####   
####       at Object.toEqual (word-search.spec.js:54:41)  
####   
####   ● single line grids › can locate that different left to right word in a different position  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Object {  
####         "coffee": Object {  
####           "end": Array [  
####     -       1,  
####             7,  
####     +       1,  
####           ],  
####           "start": Array [  
####     +       2,  
####             1,  
####     -       2,  
####           ],  
####         },  
####       }  
####   
####       64 |     const wordSearch = new WordSearch(grid);  
####       65 |  
####     > 66 |     expect(wordSearch.find(['coffee'])).toEqual(expectedResults);  
####          |                                         ^  
####       67 |   });  
####       68 | });  
####       69 |  
####   
####       at Object.toEqual (word-search.spec.js:66:41)  
####   
####   ● multi line grids › can locate a left to right word in a two line grid  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       2,  
####             7,  
####     +       2,  
####           ],  
####           "start": Array [  
####     +       1,  
####             2,  
####     -       1,  
####           ],  
####         },  
####       }  
####   
####       81 |     const wordSearch = new WordSearch(grid);  
####       82 |  
####     > 83 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);  
####          |                                          ^  
####       84 |   });  
####       85 |   test('can locate a left to right word in a different position in a two line grid', () => {  
####       86 |     const grid = ['jefblpepre', 'tclojurerm'];  
####   
####       at Object.toEqual (word-search.spec.js:83:42)  
####   
####   ● multi line grids › can locate a left to right word in a different position in a two line grid  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####     @@ -1,10 +1,10 @@  
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       2,  
####             8,  
####     +       2,  
####           ],  
####           "start": Array [  
####             2,  
####             2,  
####           ],  
####   
####       93 |     const wordSearch = new WordSearch(grid);  
####       94 |  
####     > 95 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);  
####          |                                          ^  
####       96 |   });  
####       97 |   test('can locate a left to right word in a three line grid', () => {  
####       98 |     const grid = ['camdcimgtc', 'jefblpepre', 'clojurermt'];  
####   
####       at Object.toEqual (word-search.spec.js:95:42)  
####   
####   ● multi line grids › can locate a left to right word in a three line grid  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       3,  
####             7,  
####     +       3,  
####           ],  
####           "start": Array [  
####     +       1,  
####             3,  
####     -       1,  
####           ],  
####         },  
####       }  
####   
####       105 |     const wordSearch = new WordSearch(grid);  
####       106 |  
####     > 107 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);  
####           |                                          ^  
####       108 |   });  
####       109 |  
####       110 |   test('can locate a left to right word in a ten line grid', () => {  
####   
####       at Object.toEqual (word-search.spec.js:107:42)  
####   
####   ● multi line grids › can locate a left to right word in a ten line grid  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       10,  
####             7,  
####     +       10,  
####           ],  
####           "start": Array [  
####     +       1,  
####             10,  
####     -       1,  
####           ],  
####         },  
####       }  
####   
####       130 |     const wordSearch = new WordSearch(grid);  
####       131 |  
####     > 132 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);  
####           |                                          ^  
####       133 |   });  
####       134 |  
####       135 |   test('can locate a left to right word in a different position in a ten line grid', () => {  
####   
####       at Object.toEqual (word-search.spec.js:132:42)  
####   
####   ● multi line grids › can locate a left to right word in a different position in a ten line grid  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       9,  
####             7,  
####     +       9,  
####           ],  
####           "start": Array [  
####     +       1,  
####             9,  
####     -       1,  
####           ],  
####         },  
####       }  
####   
####       155 |     const wordSearch = new WordSearch(grid);  
####       156 |  
####     > 157 |     expect(wordSearch.find(['clojure'])).toEqual(expectedResults);  
####           |                                          ^  
####       158 |   });  
####       159 |   test('can locate a different left to right word in a ten line grid', () => {  
####       160 |     const grid = [  
####   
####       at Object.toEqual (word-search.spec.js:157:42)  
####   
####   ● multi line grids › can locate a different left to right word in a ten line grid  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 2  
####     + Received  + 2  
####   
####       Object {  
####         "scree": Object {  
####           "end": Array [  
####     -       7,  
####             5,  
####     +       7,  
####           ],  
####           "start": Array [  
####     +       1,  
####             7,  
####     -       1,  
####           ],  
####         },  
####       }  
####   
####       178 |     const wordSearch = new WordSearch(grid);  
####       179 |  
####     > 180 |     expect(wordSearch.find(['scree'])).toEqual(expectedResults);  
####           |                                        ^  
####       181 |   });  
####       182 | });  
####       183 |  
####   
####       at Object.toEqual (word-search.spec.js:180:40)  
####   
####   ● can find multiple words › can find two words written left to right  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 4  
####     + Received  + 4  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       10,  
####             7,  
####     +       10,  
####           ],  
####           "start": Array [  
####     +       1,  
####             10,  
####     -       1,  
####           ],  
####         },  
####         "java": Object {  
####           "end": Array [  
####     +       5,  
####             11,  
####     -       5,  
####           ],  
####           "start": Array [  
####     -       11,  
####             2,  
####     +       11,  
####           ],  
####         },  
####       }  
####   
####       209 |     const wordSearch = new WordSearch(grid);  
####       210 |  
####     > 211 |     expect(wordSearch.find(['java', 'clojure'])).toEqual(expectedResults);  
####           |                                                  ^  
####       212 |   });  
####       213 | });  
####       214 |  
####   
####       at Object.toEqual (word-search.spec.js:211:50)  
####   
####   ● different directions › should locate a single word written right to left  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####     @@ -3,10 +3,10 @@  
####           "end": Array [  
####             1,  
####             1,  
####           ],  
####           "start": Array [  
####     -       1,  
####             6,  
####     +       1,  
####           ],  
####         },  
####       }  
####   
####       224 |     const wordSearch = new WordSearch(grid);  
####       225 |  
####     > 226 |     expect(wordSearch.find(['elixir'])).toEqual(expectedResults);  
####           |                                         ^  
####       227 |   });  
####       228 |   test('should locate multiple words written in different horizontal directions', () => {  
####       229 |     const grid = [  
####   
####       at Object.toEqual (word-search.spec.js:226:41)  
####   
####   ● different directions › should locate multiple words written in different horizontal directions  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 4  
####     + Received  + 4  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       10,  
####             7,  
####     +       10,  
####           ],  
####           "start": Array [  
####     +       1,  
####             10,  
####     -       1,  
####           ],  
####         },  
####         "elixir": Object {  
####           "end": Array [  
####     +       1,  
####             5,  
####     -       1,  
####           ],  
####           "start": Array [  
####     -       5,  
####             6,  
####     +       5,  
####           ],  
####         },  
####       }  
####   
####       251 |     const wordSearch = new WordSearch(grid);  
####       252 |  
####     > 253 |     expect(wordSearch.find(['elixir', 'clojure'])).toEqual(expectedResults);  
####           |                                                    ^  
####       254 |   });  
####       255 | });  
####       256 |  
####   
####       at Object.toEqual (word-search.spec.js:253:52)  
####   
####   ● vertical directions › should locate words written top to bottom  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 5  
####     + Received  + 5  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     +       7,  
####             10,  
####     -       7,  
####           ],  
####           "start": Array [  
####     -       10,  
####             1,  
####     +       10,  
####           ],  
####         },  
####         "ecmascript": Object {  
####           "end": Array [  
####             10,  
####             10,  
####           ],  
####           "start": Array [  
####     -       1,  
####             10,  
####     +       1,  
####           ],  
####         },  
####         "elixir": Object {  
####           "end": Array [  
####     -       5,  
####             1,  
####     +       5,  
####           ],  
####           "start": Array [  
####     +       6,  
####             5,  
####     -       6,  
####           ],  
####         },  
####       }  
####   
####       285 |     const wordSearch = new WordSearch(grid);  
####       286 |  
####     > 287 |     expect(wordSearch.find(['elixir', 'clojure', 'ecmascript'])).toEqual(  
####           |                                                                  ^  
####       288 |       expectedResults,  
####       289 |     );  
####       290 |   });  
####   
####       at Object.toEqual (word-search.spec.js:287:66)  
####   
####   ● vertical directions › should locate words written bottom to top  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 7  
####     + Received  + 7  
####   
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       10,  
####             7,  
####     +       10,  
####           ],  
####           "start": Array [  
####     +       1,  
####             10,  
####     -       1,  
####           ],  
####         },  
####         "ecmascript": Object {  
####           "end": Array [  
####             10,  
####             10,  
####           ],  
####           "start": Array [  
####     +       10,  
####             1,  
####     -       10,  
####           ],  
####         },  
####         "elixir": Object {  
####           "end": Array [  
####     -       5,  
####             1,  
####     +       5,  
####           ],  
####           "start": Array [  
####     +       6,  
####             5,  
####     -       6,  
####           ],  
####         },  
####         "rust": Object {  
####           "end": Array [  
####     -       2,  
####             9,  
####     +       2,  
####           ],  
####           "start": Array [  
####     -       5,  
####             9,  
####     +       5,  
####           ],  
####         },  
####       }  
####   
####       324 |     expect(  
####       325 |       wordSearch.find(['elixir', 'clojure', 'ecmascript', 'rust']),  
####     > 326 |     ).toEqual(expectedResults);  
####           |       ^  
####       327 |   });  
####       328 |   test('should locate words written top left to bottom right', () => {  
####       329 |     const grid = [  
####   
####       at Object.toEqual (word-search.spec.js:326:7)  
####   
####   ● vertical directions › should locate words written top left to bottom right  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 7  
####     + Received  + 7  
####   
####     @@ -1,34 +1,34 @@  
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       10,  
####             7,  
####     +       10,  
####           ],  
####           "start": Array [  
####     +       1,  
####             10,  
####     -       1,  
####           ],  
####         },  
####         "ecmascript": Object {  
####           "end": Array [  
####             10,  
####             10,  
####           ],  
####           "start": Array [  
####     +       10,  
####             1,  
####     -       10,  
####           ],  
####         },  
####         "elixir": Object {  
####           "end": Array [  
####     -       5,  
####             1,  
####     +       5,  
####           ],  
####           "start": Array [  
####     +       6,  
####             5,  
####     -       6,  
####           ],  
####         },  
####         "java": Object {  
####           "end": Array [  
####             4,  
####     @@ -39,14 +39,14 @@  
####             1,  
####           ],  
####         },  
####         "rust": Object {  
####           "end": Array [  
####     -       2,  
####             9,  
####     +       2,  
####           ],  
####           "start": Array [  
####     -       5,  
####             9,  
####     +       5,  
####           ],  
####         },  
####       }  
####   
####       365 |     expect(  
####       366 |       wordSearch.find(['clojure', 'elixir', 'ecmascript', 'rust', 'java']),  
####     > 367 |     ).toEqual(expectedResults);  
####           |       ^  
####       368 |   });  
####       369 |   test('should locate words written bottom right to top left', () => {  
####       370 |     const grid = [  
####   
####       at Object.toEqual (word-search.spec.js:367:7)  
####   
####   ● vertical directions › should locate words written bottom right to top left  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 9  
####     + Received  + 9  
####   
####     @@ -1,34 +1,34 @@  
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     +       7,  
####             10,  
####     -       7,  
####           ],  
####           "start": Array [  
####     -       10,  
####             1,  
####     +       10,  
####           ],  
####         },  
####         "ecmascript": Object {  
####           "end": Array [  
####             10,  
####             10,  
####           ],  
####           "start": Array [  
####     -       1,  
####             10,  
####     +       1,  
####           ],  
####         },  
####         "elixir": Object {  
####           "end": Array [  
####     +       1,  
####             5,  
####     -       1,  
####           ],  
####           "start": Array [  
####     -       5,  
####             6,  
####     +       5,  
####           ],  
####         },  
####         "java": Object {  
####           "end": Array [  
####             4,  
####     @@ -39,24 +39,24 @@  
####             1,  
####           ],  
####         },  
####         "lua": Object {  
####           "end": Array [  
####     -       7,  
####             6,  
####     +       7,  
####           ],  
####           "start": Array [  
####     +       8,  
####             9,  
####     -       8,  
####           ],  
####         },  
####         "rust": Object {  
####           "end": Array [  
####     +       9,  
####             2,  
####     -       9,  
####           ],  
####           "start": Array [  
####     -       5,  
####             9,  
####     +       5,  
####           ],  
####         },  
####       }  
####   
####       418 |         'lua',  
####       419 |       ]),  
####     > 420 |     ).toEqual(expectedResults);  
####           |       ^  
####       421 |   });  
####       422 |   test('should locate words written bottom left to top right', () => {  
####       423 |     const grid = [  
####   
####       at Object.toEqual (word-search.spec.js:420:7)  
####   
####   ● vertical directions › should locate words written bottom left to top right  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 11  
####     + Received  + 11  
####   
####     @@ -1,34 +1,34 @@  
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       10,  
####             7,  
####     +       10,  
####           ],  
####           "start": Array [  
####     +       1,  
####             10,  
####     -       1,  
####           ],  
####         },  
####         "ecmascript": Object {  
####           "end": Array [  
####             10,  
####             10,  
####           ],  
####           "start": Array [  
####     +       10,  
####             1,  
####     -       10,  
####           ],  
####         },  
####         "elixir": Object {  
####           "end": Array [  
####     +       1,  
####             5,  
####     -       1,  
####           ],  
####           "start": Array [  
####     -       5,  
####             6,  
####     +       5,  
####           ],  
####         },  
####         "java": Object {  
####           "end": Array [  
####             4,  
####     @@ -39,34 +39,34 @@  
####             1,  
####           ],  
####         },  
####         "lisp": Object {  
####           "end": Array [  
####     -       3,  
####             6,  
####     +       3,  
####           ],  
####           "start": Array [  
####     +       3,  
####             6,  
####     -       3,  
####           ],  
####         },  
####         "lua": Object {  
####           "end": Array [  
####     -       7,  
####             6,  
####     +       7,  
####           ],  
####           "start": Array [  
####     -       9,  
####             8,  
####     +       9,  
####           ],  
####         },  
####         "rust": Object {  
####           "end": Array [  
####     -       2,  
####             9,  
####     +       2,  
####           ],  
####           "start": Array [  
####     +       9,  
####             5,  
####     -       9,  
####           ],  
####         },  
####       }  
####   
####       476 |         'lisp',  
####       477 |       ]),  
####     > 478 |     ).toEqual(expectedResults);  
####           |       ^  
####       479 |   });  
####       480 |   test('should locate words written top right to bottom left', () => {  
####       481 |     const grid = [  
####   
####       at Object.toEqual (word-search.spec.js:478:7)  
####   
####   ● vertical directions › should locate words written top right to bottom left  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 13  
####     + Received  + 13  
####   
####     @@ -1,34 +1,34 @@  
####       Object {  
####         "clojure": Object {  
####           "end": Array [  
####     -       10,  
####             7,  
####     +       10,  
####           ],  
####           "start": Array [  
####     +       1,  
####             10,  
####     -       1,  
####           ],  
####         },  
####         "ecmascript": Object {  
####           "end": Array [  
####             10,  
####             10,  
####           ],  
####           "start": Array [  
####     +       10,  
####             1,  
####     -       10,  
####           ],  
####         },  
####         "elixir": Object {  
####           "end": Array [  
####     -       5,  
####             1,  
####     +       5,  
####           ],  
####           "start": Array [  
####     +       6,  
####             5,  
####     -       6,  
####           ],  
####         },  
####         "java": Object {  
####           "end": Array [  
####             4,  
####     @@ -39,44 +39,44 @@  
####             1,  
####           ],  
####         },  
####         "lisp": Object {  
####           "end": Array [  
####     -       3,  
####             6,  
####     +       3,  
####           ],  
####           "start": Array [  
####     -       6,  
####             3,  
####     +       6,  
####           ],  
####         },  
####         "lua": Object {  
####           "end": Array [  
####     +       6,  
####             7,  
####     -       6,  
####           ],  
####           "start": Array [  
####     -       9,  
####             8,  
####     +       9,  
####           ],  
####         },  
####         "ruby": Object {  
####           "end": Array [  
####     -       9,  
####             5,  
####     +       9,  
####           ],  
####           "start": Array [  
####     +       8,  
####             6,  
####     -       8,  
####           ],  
####         },  
####         "rust": Object {  
####           "end": Array [  
####     +       9,  
####             2,  
####     -       9,  
####           ],  
####           "start": Array [  
####     +       9,  
####             5,  
####     -       9,  
####           ],  
####         },  
####       }  
####   
####       539 |         'ruby',  
####       540 |       ]),  
####     > 541 |     ).toEqual(expectedResults);  
####           |       ^  
####       542 |   });  
####       543 |  
####       544 |   describe("word doesn't exist", () => {  
####   
####       at Object.toEqual (word-search.spec.js:541:7)  
####   
####   ● vertical directions › word doesn't exist › should fail to locate a word that is not in the puzzle  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Object {  
####     -   "fail": undefined,  
####     +   "fail": null,  
####       }  
####   
####       562 |       const wordSearch = new WordSearch(grid);  
####       563 |  
####     > 564 |       expect(wordSearch.find(['fail'])).toEqual(expectedResults);  
####           |                                         ^  
####       565 |     });  
####       566 |   });  
####       567 | });  
####   
####       at Object.toEqual (word-search.spec.js:564:41)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       21 failed, 1 passed, 22 total  
#### Snapshots:   0 total  
#### Time:        0.584 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./word-search.js|./word-search.spec.js.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in word-search.js to resolve the errors.  

The test failures indicate two issues with the current implementation:
1.  **Coordinate Order**: The tests expect coordinates in `[row, column]` format (e.g., `[10, 7]`), but the code currently returns `[column, row]` (e.g., `[7, 10]`). We need to swap the order in the `start` and `end` arrays.
2.  **Missing Word Value**: The tests expect `undefined` when a word is not found, but the code currently returns `null`. We should initialize `found` as `undefined` instead of `null`.

Here are the *SEARCH/REPLACE* blocks to fix these issues:

word-search.js
```javascript
<<<<<<< SEARCH
    for (const word of words) {
      let found = null;
=======
    for (const word of words) {
      let found = undefined;
>>>>>>> REPLACE
```

word-search.js
```javascript
<<<<<<< SEARCH
              const endR = r + (word.length - 1) * dr;
              const endC = c + (word.length - 1) * dc;
              found = { start: [c + 1, r + 1], end: [endC + 1, endR + 1] };
=======
              const endR = r + (word.length - 1) * dr;
              const endC = c + (word.length - 1) * dc;
              found = { start: [r + 1, c + 1], end: [endR + 1, endC + 1] };
>>>>>>> REPLACE
```

> Tokens: 11k sent, 354 received.  
> Applied edit to word-search.js  
```

> test
> jest ./*

PASS ./word-search.spec.js
  single line grids
    ✓ Should accept an initial game grid (2 ms)
    ✓ can accept a target search word (1 ms)
    ✓ should locate a word written left to right (1 ms)
    ✓ can locate a left to right word in a different position
    ✓ can locate a different left to right word
    ✓ can locate that different left to right word in a different position (1 ms)
  multi line grids
    ✓ can locate a left to right word in a two line grid (1 ms)
    ✓ can locate a left to right word in a different position in a two line grid (1 ms)
    ✓ can locate a left to right word in a three line grid
    ✓ can locate a left to right word in a ten line grid
    ✓ can locate a left to right word in a different position in a ten line grid (1 ms)
    ✓ can locate a different left to right word in a ten line grid (1 ms)
  can find multiple words
    ✓ can find two words written left to right (2 ms)
  different directions
    ✓ should locate a single word written right to left (1 ms)
    ✓ should locate multiple words written in different horizontal directions (1 ms)
  vertical directions
    ✓ should locate words written top to bottom (1 ms)
    ✓ should locate words written bottom to top (1 ms)
    ✓ should locate words written top left to bottom right (1 ms)
    ✓ should locate words written bottom right to top left
    ✓ should locate words written bottom left to top right
    ✓ should locate words written top right to bottom left (1 ms)
    word doesn't exist
      ✓ should fail to locate a word that is not in the puzzle (1 ms)

Test Suites: 1 passed, 1 total
Tests:       22 passed, 22 total
Snapshots:   0 total
Time:        0.499 s, estimated 1 s
Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./word-search.js|./word-search.spec.js.

```