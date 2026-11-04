
# aider chat started at 2026-11-04 17:59:47

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-27b-agent with diff edit format, reasoning none  
> Git repo: none  
> Repo-map: disabled  
> Added forth.js to the chat.  

#### # Instructions  
####   
#### Implement an evaluator for a very simple subset of Forth.  
####   
#### [Forth][forth]  
#### is a stack-based programming language.  
#### Implement a very basic evaluator for a small subset of Forth.  
####   
#### Your evaluator has to support the following words:  
####   
#### - `+`, `-`, `*`, `/` (integer arithmetic)  
#### - `DUP`, `DROP`, `SWAP`, `OVER` (stack manipulation)  
####   
#### Your evaluator also has to support defining new words using the customary syntax: `: word-name definition ;`.  
####   
#### To keep things simple the only data type you need to support is signed integers of at least 16 bits size.  
####   
#### You should use the following rules for the syntax: a number is a sequence of one or more (ASCII) digits, a word is a sequence of one or more letters, digits, symbols or punctuation that is not a number.  
#### (Forth probably uses slightly different rules, but this is close enough.)  
####   
#### Words are case-insensitive.  
####   
#### [forth]: https://en.wikipedia.org/wiki/Forth_%28programming_language%29  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: forth.js  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

To implement the Forth evaluator, I will replace the skeleton code in `forth.js` with a full implementation.

The implementation will:
1.  Initialize a stack and a dictionary of words.
2.  Pre-define the arithmetic and stack manipulation words (`+`, `-`, `*`, `/`, `DUP`, `DROP`, `SWAP`, `OVER`).
3.  Implement `evaluate` to parse input, handle number literals, execute words, and handle word definitions (`: name ... ;`).
4.  Handle case-insensitivity by normalizing keys and tokens to lowercase.
5.  Implement `get stack` to return the current stack.

Here is the *SEARCH/REPLACE* block for `forth.js`:

forth.js
```javascript
<<<<<<< SEARCH
//
// This is only a SKELETON file for the 'Forth' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Forth {
  constructor() {
    throw Error('Remove this statement and implement this function');
  }

  evaluate() {
    throw Error('Remove this statement and implement this function');
  }

  get stack() {
    throw Error('Remove this statement and implement this function');
  }
}
=======
//
// This is only a SKELETON file for the 'Forth' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Forth {
  constructor() {
    this._stack = [];
    this._words = new Map();
    
    // Define built-in words
    this._words.set('+', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a + b);
    });
    this._words.set('-', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a - b);
    });
    this._words.set('*', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a * b);
    });
    this._words.set('/', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(Math.trunc(a / b));
    });
    this._words.set('dup', (stack) => {
      const a = stack[stack.length - 1];
      stack.push(a);
    });
    this._words.set('drop', (stack) => {
      stack.pop();
    });
    this._words.set('swap', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(b);
      stack.push(a);
    });
    this._words.set('over', (stack) => {
      const b = stack[stack.length - 1];
      const a = stack[stack.length - 2];
      stack.push(a);
    });
  }

  evaluate(input) {
    const tokens = input.trim().split(/\s+/);
    let i = 0;
    
    while (i < tokens.length) {
      const token = tokens[i];
      const lowerToken = token.toLowerCase();
      
      if (/^-?\d+$/.test(token)) {
        this._stack.push(parseInt(token, 10));
        i++;
      } else if (lowerToken === ':') {
        // Definition
        const name = tokens[i + 1].toLowerCase();
        if (/^-?\d+$/.test(tokens[i + 1])) {
          throw new Error('Invalid word name');
        }
        
        const defTokens = [];
        i += 2;
        while (i < tokens.length && tokens[i].toLowerCase() !== ';') {
          defTokens.push(tokens[i]);
          i++;
        }
        if (i >= tokens.length) {
          throw new Error('Unterminated definition');
        }
        i++; // Skip ';'
        
        this._words.set(name, (stack) => {
          // Execute the definition
          for (const t of defTokens) {
            this._executeToken(t, stack);
          }
        });
      } else {
        this._executeToken(token, this._stack);
        i++;
      }
    }
  }

  _executeToken(token, stack) {
    const lowerToken = token.toLowerCase();
    
    if (/^-?\d+$/.test(token)) {
      stack.push(parseInt(token, 10));
      return;
    }
    
    const word = this._words.get(lowerToken);
    if (word) {
      word(stack);
    } else {
      throw new Error(`Unknown word: ${token}`);
    }
  }

  get stack() {
    return this._stack;
  }
}
>>>>>>> REPLACE
```

> Tokens: 2.4k sent, 1.1k received.  
> Applied edit to forth.js  
```

> test
> jest ./*

FAIL ./forth.spec.js
  Forth
    parsing and numbers
      ✓ numbers just get pushed onto the stack (3 ms)
      ✓ pushes negative numbers onto the stack (1 ms)
    addition
      ✓ can add two numbers
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (1 ms)
    subtraction
      ✓ can subtract two numbers (1 ms)
      ✕ errors if there is nothing on the stack (1 ms)
      ✕ errors if there is only one value on the stack
    multiplication
      ✓ can multiply two numbers (1 ms)
      ✕ errors if there is nothing on the stack
      ✕ errors if there is only one value on the stack
    division
      ✓ can divide two numbers
      ✓ performs integer division
      ✕ errors if dividing by zero (1 ms)
      ✕ errors if there is nothing on the stack (1 ms)
      ✕ errors if there is only one value on the stack
    combined arithmetic
      ✓ addition and subtraction (1 ms)
      ✓ multiplication and division
    dup
      ✓ copies a value on the stack
      ✓ copies the top value on the stack (1 ms)
      ✕ errors if there is nothing on the stack
    drop
      ✓ removes the top value on the stack if it is the only one (1 ms)
      ✓ removes the top value on the stack if it is not the only one
      ✕ errors if there is nothing on the stack
    swap
      ✓ swaps the top two values on the stack if they are the only ones
      ✓ swaps the top two values on the stack if they are not the only ones
      ✕ errors if there is nothing on the stack (1 ms)
      ✕ errors if there is only one value on the stack
    over
      ✓ copies the second element if there are only two
      ✓ copies the second element if there are more than two
      ✕ errors if there is nothing on the stack (1 ms)
      ✕ errors if there is only one value on the stack (1 ms)
    user-defined words
      ✓ can consist of built-in words (1 ms)
      ✓ execute in the right order
      ✓ can override other user-defined words
      ✓ can override built-in words (1 ms)
      ✓ can override built-in operators
      ✕ can use different words with the same name (2 ms)
      ✕ can define word that uses word with the same name (3 ms)
      ✕ cannot redefine numbers (10 ms)
      ✕ cannot redefine negative numbers (2 ms)
      ✕ errors if executing a non-existent word (1 ms)
      ✓ only defines locally
    case-insensitivity
      ✓ DUP is case-insensitive (3 ms)
      ✓ DROP is case-insensitive
      ✓ SWAP is case-insensitive
      ✓ OVER is case-insensitive (1 ms)
      ✓ user-defined words are case-insensitive
      ✓ definitions are case-insensitive

  ● Forth › addition › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      29 |       expect(() => {
      30 |         forth.evaluate('+');
    > 31 |       }).toThrow(new Error('Stack empty'));
         |          ^
      32 |     });
      33 |
      34 |     test('errors if there is only one value on the stack', () => {

      at Object.toThrow (forth.spec.js:31:10)

  ● Forth › addition › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      35 |       expect(() => {
      36 |         forth.evaluate('1 +');
    > 37 |       }).toThrow(new Error('Stack empty'));
         |          ^
      38 |     });
      39 |   });
      40 |

      at Object.toThrow (forth.spec.js:37:10)

  ● Forth › subtraction › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      48 |       expect(() => {
      49 |         forth.evaluate('-');
    > 50 |       }).toThrow(new Error('Stack empty'));
         |          ^
      51 |     });
      52 |
      53 |     test('errors if there is only one value on the stack', () => {

      at Object.toThrow (forth.spec.js:50:10)

  ● Forth › subtraction › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      54 |       expect(() => {
      55 |         forth.evaluate('1 -');
    > 56 |       }).toThrow(new Error('Stack empty'));
         |          ^
      57 |     });
      58 |   });
      59 |

      at Object.toThrow (forth.spec.js:56:10)

  ● Forth › multiplication › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      67 |       expect(() => {
      68 |         forth.evaluate('*');
    > 69 |       }).toThrow(new Error('Stack empty'));
         |          ^
      70 |     });
      71 |
      72 |     test('errors if there is only one value on the stack', () => {

      at Object.toThrow (forth.spec.js:69:10)

  ● Forth › multiplication › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      73 |       expect(() => {
      74 |         forth.evaluate('1 *');
    > 75 |       }).toThrow(new Error('Stack empty'));
         |          ^
      76 |     });
      77 |   });
      78 |

      at Object.toThrow (forth.spec.js:75:10)

  ● Forth › division › errors if dividing by zero

    expect(received).toThrow(expected)

    Expected message: "Division by zero"

    Received function did not throw

      91 |       expect(() => {
      92 |         forth.evaluate('4 0 /');
    > 93 |       }).toThrow(new Error('Division by zero'));
         |          ^
      94 |     });
      95 |
      96 |     test('errors if there is nothing on the stack', () => {

      at Object.toThrow (forth.spec.js:93:10)

  ● Forth › division › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

       97 |       expect(() => {
       98 |         forth.evaluate('/');
    >  99 |       }).toThrow(new Error('Stack empty'));
          |          ^
      100 |     });
      101 |
      102 |     test('errors if there is only one value on the stack', () => {

      at Object.toThrow (forth.spec.js:99:10)

  ● Forth › division › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      103 |       expect(() => {
      104 |         forth.evaluate('1 /');
    > 105 |       }).toThrow(new Error('Stack empty'));
          |          ^
      106 |     });
      107 |   });
      108 |

      at Object.toThrow (forth.spec.js:105:10)

  ● Forth › dup › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      133 |       expect(() => {
      134 |         forth.evaluate('dup');
    > 135 |       }).toThrow(new Error('Stack empty'));
          |          ^
      136 |     });
      137 |   });
      138 |

      at Object.toThrow (forth.spec.js:135:10)

  ● Forth › drop › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      151 |       expect(() => {
      152 |         forth.evaluate('drop');
    > 153 |       }).toThrow(new Error('Stack empty'));
          |          ^
      154 |     });
      155 |   });
      156 |

      at Object.toThrow (forth.spec.js:153:10)

  ● Forth › swap › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      169 |       expect(() => {
      170 |         forth.evaluate('swap');
    > 171 |       }).toThrow(new Error('Stack empty'));
          |          ^
      172 |     });
      173 |
      174 |     test('errors if there is only one value on the stack', () => {

      at Object.toThrow (forth.spec.js:171:10)

  ● Forth › swap › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      175 |       expect(() => {
      176 |         forth.evaluate('1 swap');
    > 177 |       }).toThrow(new Error('Stack empty'));
          |          ^
      178 |     });
      179 |   });
      180 |

      at Object.toThrow (forth.spec.js:177:10)

  ● Forth › over › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      193 |       expect(() => {
      194 |         forth.evaluate('over');
    > 195 |       }).toThrow(new Error('Stack empty'));
          |          ^
      196 |     });
      197 |
      198 |     test('errors if there is only one value on the stack', () => {

      at Object.toThrow (forth.spec.js:195:10)

  ● Forth › over › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"

    Received function did not throw

      199 |       expect(() => {
      200 |         forth.evaluate('1 over');
    > 201 |       }).toThrow(new Error('Stack empty'));
          |          ^
      202 |     });
      203 |   });
      204 |

      at Object.toThrow (forth.spec.js:201:10)

  ● Forth › user-defined words › can use different words with the same name

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   5,
    +   6,
        6,
      ]

      240 |       forth.evaluate(': foo 6 ;');
      241 |       forth.evaluate('bar foo');
    > 242 |       expect(forth.stack).toEqual([5, 6]);
          |                           ^
      243 |     });
      244 |
      245 |     test('can define word that uses word with the same name', () => {

      at Object.toEqual (forth.spec.js:242:27)

  ● Forth › user-defined words › can define word that uses word with the same name

    RangeError: Maximum call stack size exceeded
        at Array.values (<anonymous>)

      81 |         this._words.set(name, (stack) => {
      82 |           // Execute the definition
    > 83 |           for (const t of defTokens) {
         |                           ^
      84 |             this._executeToken(t, stack);
      85 |           }
      86 |         });

      at defTokens (forth.js:83:27)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)
      at Forth.word [as _executeToken] (forth.js:104:7)
      at _executeToken (forth.js:84:18)

  ● Forth › user-defined words › cannot redefine numbers

    expect(received).toThrow(expected)

    Expected message: "Invalid definition"
    Received message: "Invalid word name"

          65 |         const name = tokens[i + 1].toLowerCase();
          66 |         if (/^-?\d+$/.test(tokens[i + 1])) {
        > 67 |           throw new Error('Invalid word name');
             |                 ^
          68 |         }
          69 |         
          70 |         const defTokens = [];

      at Forth.evaluate (forth.js:67:17)
      at evaluate (forth.spec.js:254:15)
      at Object.toThrow (forth.spec.js:255:10)
      at Object.toThrow (forth.spec.js:255:10)

  ● Forth › user-defined words › cannot redefine negative numbers

    expect(received).toThrow(expected)

    Expected message: "Invalid definition"
    Received message: "Invalid word name"

          65 |         const name = tokens[i + 1].toLowerCase();
          66 |         if (/^-?\d+$/.test(tokens[i + 1])) {
        > 67 |           throw new Error('Invalid word name');
             |                 ^
          68 |         }
          69 |         
          70 |         const defTokens = [];

      at Forth.evaluate (forth.js:67:17)
      at evaluate (forth.spec.js:259:15)
      at Object.toThrow (forth.spec.js:260:10)
      at Object.toThrow (forth.spec.js:260:10)

  ● Forth › user-defined words › errors if executing a non-existent word

    expect(received).toThrow(expected)

    Expected message: "Unknown command"
    Received message: "Unknown word: foo"

          104 |       word(stack);
          105 |     } else {
        > 106 |       throw new Error(`Unknown word: ${token}`);
              |             ^
          107 |     }
          108 |   }
          109 |

      at Forth._executeToken (forth.js:106:13)
      at Forth._executeToken [as evaluate] (forth.js:88:14)
      at evaluate (forth.spec.js:265:15)
      at Object.toThrow (forth.spec.js:266:10)
      at Object.toThrow (forth.spec.js:266:10)

Test Suites: 1 failed, 1 total
Tests:       20 failed, 29 passed, 49 total
Snapshots:   0 total
Time:        1.047 s
Ran all test suites matching ./LICENSE|./babel.config.js|./forth.js|./forth.spec.js|./node_modules|./package-lock.json|./package.json.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./forth.spec.js  
####   Forth  
####     parsing and numbers  
####       ✓ numbers just get pushed onto the stack (3 ms)  
####       ✓ pushes negative numbers onto the stack (1 ms)  
####     addition  
####       ✓ can add two numbers  
####       ✕ errors if there is nothing on the stack (2 ms)  
####       ✕ errors if there is only one value on the stack (1 ms)  
####     subtraction  
####       ✓ can subtract two numbers (1 ms)  
####       ✕ errors if there is nothing on the stack (1 ms)  
####       ✕ errors if there is only one value on the stack  
####     multiplication  
####       ✓ can multiply two numbers (1 ms)  
####       ✕ errors if there is nothing on the stack  
####       ✕ errors if there is only one value on the stack  
####     division  
####       ✓ can divide two numbers  
####       ✓ performs integer division  
####       ✕ errors if dividing by zero (1 ms)  
####       ✕ errors if there is nothing on the stack (1 ms)  
####       ✕ errors if there is only one value on the stack  
####     combined arithmetic  
####       ✓ addition and subtraction (1 ms)  
####       ✓ multiplication and division  
####     dup  
####       ✓ copies a value on the stack  
####       ✓ copies the top value on the stack (1 ms)  
####       ✕ errors if there is nothing on the stack  
####     drop  
####       ✓ removes the top value on the stack if it is the only one (1 ms)  
####       ✓ removes the top value on the stack if it is not the only one  
####       ✕ errors if there is nothing on the stack  
####     swap  
####       ✓ swaps the top two values on the stack if they are the only ones  
####       ✓ swaps the top two values on the stack if they are not the only ones  
####       ✕ errors if there is nothing on the stack (1 ms)  
####       ✕ errors if there is only one value on the stack  
####     over  
####       ✓ copies the second element if there are only two  
####       ✓ copies the second element if there are more than two  
####       ✕ errors if there is nothing on the stack (1 ms)  
####       ✕ errors if there is only one value on the stack (1 ms)  
####     user-defined words  
####       ✓ can consist of built-in words (1 ms)  
####       ✓ execute in the right order  
####       ✓ can override other user-defined words  
####       ✓ can override built-in words (1 ms)  
####       ✓ can override built-in operators  
####       ✕ can use different words with the same name (2 ms)  
####       ✕ can define word that uses word with the same name (3 ms)  
####       ✕ cannot redefine numbers (10 ms)  
####       ✕ cannot redefine negative numbers (2 ms)  
####       ✕ errors if executing a non-existent word (1 ms)  
####       ✓ only defines locally  
####     case-insensitivity  
####       ✓ DUP is case-insensitive (3 ms)  
####       ✓ DROP is case-insensitive  
####       ✓ SWAP is case-insensitive  
####       ✓ OVER is case-insensitive (1 ms)  
####       ✓ user-defined words are case-insensitive  
####       ✓ definitions are case-insensitive  
####   
####   ● Forth › addition › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       29 |       expect(() => {  
####       30 |         forth.evaluate('+');  
####     > 31 |       }).toThrow(new Error('Stack empty'));  
####          |          ^  
####       32 |     });  
####       33 |  
####       34 |     test('errors if there is only one value on the stack', () => {  
####   
####       at Object.toThrow (forth.spec.js:31:10)  
####   
####   ● Forth › addition › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       35 |       expect(() => {  
####       36 |         forth.evaluate('1 +');  
####     > 37 |       }).toThrow(new Error('Stack empty'));  
####          |          ^  
####       38 |     });  
####       39 |   });  
####       40 |  
####   
####       at Object.toThrow (forth.spec.js:37:10)  
####   
####   ● Forth › subtraction › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       48 |       expect(() => {  
####       49 |         forth.evaluate('-');  
####     > 50 |       }).toThrow(new Error('Stack empty'));  
####          |          ^  
####       51 |     });  
####       52 |  
####       53 |     test('errors if there is only one value on the stack', () => {  
####   
####       at Object.toThrow (forth.spec.js:50:10)  
####   
####   ● Forth › subtraction › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       54 |       expect(() => {  
####       55 |         forth.evaluate('1 -');  
####     > 56 |       }).toThrow(new Error('Stack empty'));  
####          |          ^  
####       57 |     });  
####       58 |   });  
####       59 |  
####   
####       at Object.toThrow (forth.spec.js:56:10)  
####   
####   ● Forth › multiplication › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       67 |       expect(() => {  
####       68 |         forth.evaluate('*');  
####     > 69 |       }).toThrow(new Error('Stack empty'));  
####          |          ^  
####       70 |     });  
####       71 |  
####       72 |     test('errors if there is only one value on the stack', () => {  
####   
####       at Object.toThrow (forth.spec.js:69:10)  
####   
####   ● Forth › multiplication › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       73 |       expect(() => {  
####       74 |         forth.evaluate('1 *');  
####     > 75 |       }).toThrow(new Error('Stack empty'));  
####          |          ^  
####       76 |     });  
####       77 |   });  
####       78 |  
####   
####       at Object.toThrow (forth.spec.js:75:10)  
####   
####   ● Forth › division › errors if dividing by zero  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Division by zero"  
####   
####     Received function did not throw  
####   
####       91 |       expect(() => {  
####       92 |         forth.evaluate('4 0 /');  
####     > 93 |       }).toThrow(new Error('Division by zero'));  
####          |          ^  
####       94 |     });  
####       95 |  
####       96 |     test('errors if there is nothing on the stack', () => {  
####   
####       at Object.toThrow (forth.spec.js:93:10)  
####   
####   ● Forth › division › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####        97 |       expect(() => {  
####        98 |         forth.evaluate('/');  
####     >  99 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       100 |     });  
####       101 |  
####       102 |     test('errors if there is only one value on the stack', () => {  
####   
####       at Object.toThrow (forth.spec.js:99:10)  
####   
####   ● Forth › division › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       103 |       expect(() => {  
####       104 |         forth.evaluate('1 /');  
####     > 105 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       106 |     });  
####       107 |   });  
####       108 |  
####   
####       at Object.toThrow (forth.spec.js:105:10)  
####   
####   ● Forth › dup › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       133 |       expect(() => {  
####       134 |         forth.evaluate('dup');  
####     > 135 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       136 |     });  
####       137 |   });  
####       138 |  
####   
####       at Object.toThrow (forth.spec.js:135:10)  
####   
####   ● Forth › drop › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       151 |       expect(() => {  
####       152 |         forth.evaluate('drop');  
####     > 153 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       154 |     });  
####       155 |   });  
####       156 |  
####   
####       at Object.toThrow (forth.spec.js:153:10)  
####   
####   ● Forth › swap › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       169 |       expect(() => {  
####       170 |         forth.evaluate('swap');  
####     > 171 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       172 |     });  
####       173 |  
####       174 |     test('errors if there is only one value on the stack', () => {  
####   
####       at Object.toThrow (forth.spec.js:171:10)  
####   
####   ● Forth › swap › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       175 |       expect(() => {  
####       176 |         forth.evaluate('1 swap');  
####     > 177 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       178 |     });  
####       179 |   });  
####       180 |  
####   
####       at Object.toThrow (forth.spec.js:177:10)  
####   
####   ● Forth › over › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       193 |       expect(() => {  
####       194 |         forth.evaluate('over');  
####     > 195 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       196 |     });  
####       197 |  
####       198 |     test('errors if there is only one value on the stack', () => {  
####   
####       at Object.toThrow (forth.spec.js:195:10)  
####   
####   ● Forth › over › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####   
####     Received function did not throw  
####   
####       199 |       expect(() => {  
####       200 |         forth.evaluate('1 over');  
####     > 201 |       }).toThrow(new Error('Stack empty'));  
####           |          ^  
####       202 |     });  
####       203 |   });  
####       204 |  
####   
####       at Object.toThrow (forth.spec.js:201:10)  
####   
####   ● Forth › user-defined words › can use different words with the same name  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     - Expected  - 1  
####     + Received  + 1  
####   
####       Array [  
####     -   5,  
####     +   6,  
####         6,  
####       ]  
####   
####       240 |       forth.evaluate(': foo 6 ;');  
####       241 |       forth.evaluate('bar foo');  
####     > 242 |       expect(forth.stack).toEqual([5, 6]);  
####           |                           ^  
####       243 |     });  
####       244 |  
####       245 |     test('can define word that uses word with the same name', () => {  
####   
####       at Object.toEqual (forth.spec.js:242:27)  
####   
####   ● Forth › user-defined words › can define word that uses word with the same name  
####   
####     RangeError: Maximum call stack size exceeded  
####         at Array.values (<anonymous>)  
####   
####       81 |         this._words.set(name, (stack) => {  
####       82 |           // Execute the definition  
####     > 83 |           for (const t of defTokens) {  
####          |                           ^  
####       84 |             this._executeToken(t, stack);  
####       85 |           }  
####       86 |         });  
####   
####       at defTokens (forth.js:83:27)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####       at Forth.word [as _executeToken] (forth.js:104:7)  
####       at _executeToken (forth.js:84:18)  
####   
####   ● Forth › user-defined words › cannot redefine numbers  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Invalid definition"  
####     Received message: "Invalid word name"  
####   
####           65 |         const name = tokens[i + 1].toLowerCase();  
####           66 |         if (/^-?\d+$/.test(tokens[i + 1])) {  
####         > 67 |           throw new Error('Invalid word name');  
####              |                 ^  
####           68 |         }  
####           69 |           
####           70 |         const defTokens = [];  
####   
####       at Forth.evaluate (forth.js:67:17)  
####       at evaluate (forth.spec.js:254:15)  
####       at Object.toThrow (forth.spec.js:255:10)  
####       at Object.toThrow (forth.spec.js:255:10)  
####   
####   ● Forth › user-defined words › cannot redefine negative numbers  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Invalid definition"  
####     Received message: "Invalid word name"  
####   
####           65 |         const name = tokens[i + 1].toLowerCase();  
####           66 |         if (/^-?\d+$/.test(tokens[i + 1])) {  
####         > 67 |           throw new Error('Invalid word name');  
####              |                 ^  
####           68 |         }  
####           69 |           
####           70 |         const defTokens = [];  
####   
####       at Forth.evaluate (forth.js:67:17)  
####       at evaluate (forth.spec.js:259:15)  
####       at Object.toThrow (forth.spec.js:260:10)  
####       at Object.toThrow (forth.spec.js:260:10)  
####   
####   ● Forth › user-defined words › errors if executing a non-existent word  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Unknown command"  
####     Received message: "Unknown word: foo"  
####   
####           104 |       word(stack);  
####           105 |     } else {  
####         > 106 |       throw new Error(`Unknown word: ${token}`);  
####               |             ^  
####           107 |     }  
####           108 |   }  
####           109 |  
####   
####       at Forth._executeToken (forth.js:106:13)  
####       at Forth._executeToken [as evaluate] (forth.js:88:14)  
####       at evaluate (forth.spec.js:265:15)  
####       at Object.toThrow (forth.spec.js:266:10)  
####       at Object.toThrow (forth.spec.js:266:10)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       20 failed, 29 passed, 49 total  
#### Snapshots:   0 total  
#### Time:        1.047 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./forth.js|./forth.spec.js|./node_modules|./package-lock.json|./package.json.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in forth.js to resolve the errors.  

To fix the failing tests, I need to update `forth.js` to:
1.  Add stack underflow checks for arithmetic and stack manipulation operations, throwing `Error('Stack empty')`.
2.  Add a division by zero check, throwing `Error('Division by zero')`.
3.  Change the error message for unknown words to `Error('Unknown command')`.
4.  Change the error message for invalid word names (numbers) to `Error('Invalid definition')`.
5.  Fix the word definition logic to capture the current state of the dictionary at definition time. This prevents infinite recursion when a word references itself and ensures that words defined later don't affect earlier definitions (lexical scoping for Forth words).

Here are the changes for `forth.js`:

forth.js
```javascript
<<<<<<< SEARCH
    // Define built-in words
    this._words.set('+', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a + b);
    });
    this._words.set('-', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a - b);
    });
    this._words.set('*', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a * b);
    });
    this._words.set('/', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(Math.trunc(a / b));
    });
    this._words.set('dup', (stack) => {
      const a = stack[stack.length - 1];
      stack.push(a);
    });
    this._words.set('drop', (stack) => {
      stack.pop();
    });
    this._words.set('swap', (stack) => {
      const b = stack.pop();
      const a = stack.pop();
      stack.push(b);
      stack.push(a);
    });
    this._words.set('over', (stack) => {
      const b = stack[stack.length - 1];
      const a = stack[stack.length - 2];
      stack.push(a);
    });
=======
    // Define built-in words
    this._words.set('+', (stack) => {
      if (stack.length < 2) throw new Error('Stack empty');
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a + b);
    });
    this._words.set('-', (stack) => {
      if (stack.length < 2) throw new Error('Stack empty');
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a - b);
    });
    this._words.set('*', (stack) => {
      if (stack.length < 2) throw new Error('Stack empty');
      const b = stack.pop();
      const a = stack.pop();
      stack.push(a * b);
    });
    this._words.set('/', (stack) => {
      if (stack.length < 2) throw new Error('Stack empty');
      const b = stack.pop();
      const a = stack.pop();
      if (b === 0) throw new Error('Division by zero');
      stack.push(Math.trunc(a / b));
    });
    this._words.set('dup', (stack) => {
      if (stack.length < 1) throw new Error('Stack empty');
      const a = stack[stack.length - 1];
      stack.push(a);
    });
    this._words.set('drop', (stack) => {
      if (stack.length < 1) throw new Error('Stack empty');
      stack.pop();
    });
    this._words.set('swap', (stack) => {
      if (stack.length < 2) throw new Error('Stack empty');
      const b = stack.pop();
      const a = stack.pop();
      stack.push(b);
      stack.push(a);
    });
    this._words.set('over', (stack) => {
      if (stack.length < 2) throw new Error('Stack empty');
      const b = stack[stack.length - 1];
      const a = stack[stack.length - 2];
      stack.push(a);
    });
>>>>>>> REPLACE
```

forth.js
```javascript
<<<<<<< SEARCH
        const name = tokens[i + 1].toLowerCase();
        if (/^-?\d+$/.test(tokens[i + 1])) {
          throw new Error('Invalid word name');
        }
        
        const defTokens = [];
        i += 2;
        while (i < tokens.length && tokens[i].toLowerCase() !== ';') {
          defTokens.push(tokens[i]);
          i++;
        }
        if (i >= tokens.length) {
          throw new Error('Unterminated definition');
        }
        i++; // Skip ';'
        
        this._words.set(name, (stack) => {
          // Execute the definition
          for (const t of defTokens) {
            this._executeToken(t, stack);
          }
        });
=======
        const name = tokens[i + 1].toLowerCase();
        if (/^-?\d+$/.test(tokens[i + 1])) {
          throw new Error('Invalid definition');
        }
        
        const defTokens = [];
        i += 2;
        while (i < tokens.length && tokens[i].toLowerCase() !== ';') {
          defTokens.push(tokens[i]);
          i++;
        }
        if (i >= tokens.length) {
          throw new Error('Unterminated definition');
        }
        i++; // Skip ';'
        
        // Capture the current words map to ensure lexical scoping
        const currentWords = this._words;
        this._words.set(name, (stack) => {
          // Execute the definition
          for (const t of defTokens) {
            this._executeToken(t, stack, currentWords);
          }
        });
>>>>>>> REPLACE
```

forth.js
```javascript
<<<<<<< SEARCH
  _executeToken(token, stack) {
    const lowerToken = token.toLowerCase();
    
    if (/^-?\d+$/.test(token)) {
      stack.push(parseInt(token, 10));
      return;
    }
    
    const word = this._words.get(lowerToken);
    if (word) {
      word(stack);
    } else {
      throw new Error(`Unknown word: ${token}`);
    }
  }
=======
  _executeToken(token, stack, words = this._words) {
    const lowerToken = token.toLowerCase();
    
    if (/^-?\d+$/.test(token)) {
      stack.push(parseInt(token, 10));
      return;
    }
    
    const word = words.get(lowerToken);
    if (word) {
      word(stack);
    } else {
      throw new Error('Unknown command');
    }
  }
>>>>>>> REPLACE
```

> Tokens: 9.8k sent, 1.6k received.  
> Applied edit to forth.js  
```

> test
> jest ./*

FAIL ./forth.spec.js
  Forth
    parsing and numbers
      ✓ numbers just get pushed onto the stack (2 ms)
      ✓ pushes negative numbers onto the stack (1 ms)
    addition
      ✓ can add two numbers (1 ms)
      ✓ errors if there is nothing on the stack (5 ms)
      ✓ errors if there is only one value on the stack (1 ms)
    subtraction
      ✓ can subtract two numbers (1 ms)
      ✓ errors if there is nothing on the stack (1 ms)
      ✓ errors if there is only one value on the stack (1 ms)
    multiplication
      ✓ can multiply two numbers (1 ms)
      ✓ errors if there is nothing on the stack (1 ms)
      ✓ errors if there is only one value on the stack (1 ms)
    division
      ✓ can divide two numbers (1 ms)
      ✓ performs integer division
      ✓ errors if dividing by zero
      ✓ errors if there is nothing on the stack (1 ms)
      ✓ errors if there is only one value on the stack (1 ms)
    combined arithmetic
      ✓ addition and subtraction (1 ms)
      ✓ multiplication and division
    dup
      ✓ copies a value on the stack
      ✓ copies the top value on the stack (1 ms)
      ✓ errors if there is nothing on the stack
    drop
      ✓ removes the top value on the stack if it is the only one (1 ms)
      ✓ removes the top value on the stack if it is not the only one
      ✓ errors if there is nothing on the stack
    swap
      ✓ swaps the top two values on the stack if they are the only ones
      ✓ swaps the top two values on the stack if they are not the only ones (3 ms)
      ✓ errors if there is nothing on the stack (1 ms)
      ✓ errors if there is only one value on the stack (1 ms)
    over
      ✓ copies the second element if there are only two
      ✓ copies the second element if there are more than two (1 ms)
      ✓ errors if there is nothing on the stack
      ✓ errors if there is only one value on the stack (1 ms)
    user-defined words
      ✓ can consist of built-in words
      ✓ execute in the right order
      ✓ can override other user-defined words
      ✓ can override built-in words (1 ms)
      ✓ can override built-in operators
      ✕ can use different words with the same name (3 ms)
      ✕ can define word that uses word with the same name (2 ms)
      ✓ cannot redefine numbers
      ✓ cannot redefine negative numbers
      ✓ errors if executing a non-existent word (1 ms)
      ✓ only defines locally
    case-insensitivity
      ✓ DUP is case-insensitive
      ✓ DROP is case-insensitive (1 ms)
      ✓ SWAP is case-insensitive
      ✓ OVER is case-insensitive
      ✓ user-defined words are case-insensitive
      ✓ definitions are case-insensitive

  ● Forth › user-defined words › can use different words with the same name

    expect(received).toEqual(expected) // deep equality

    - Expected  - 1
    + Received  + 1

      Array [
    -   5,
    +   6,
        6,
      ]

      240 |       forth.evaluate(': foo 6 ;');
      241 |       forth.evaluate('bar foo');
    > 242 |       expect(forth.stack).toEqual([5, 6]);
          |                           ^
      243 |     });
      244 |
      245 |     test('can define word that uses word with the same name', () => {

      at Object.toEqual (forth.spec.js:242:27)

  ● Forth › user-defined words › can define word that uses word with the same name

    RangeError: Maximum call stack size exceeded
        at RegExp.test (<anonymous>)

      106 |     const lowerToken = token.toLowerCase();
      107 |     
    > 108 |     if (/^-?\d+$/.test(token)) {
          |                   ^
      109 |       stack.push(parseInt(token, 10));
      110 |       return;
      111 |     }

      at Forth.test [as _executeToken] (forth.js:108:19)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)
      at _executeToken (forth.js:95:18)
      at Forth.word [as _executeToken] (forth.js:115:7)

Test Suites: 1 failed, 1 total
Tests:       2 failed, 47 passed, 49 total
Snapshots:   0 total
Time:        1.013 s
Ran all test suites matching ./LICENSE|./babel.config.js|./forth.js|./forth.spec.js|./node_modules|./package-lock.json|./package.json.

```