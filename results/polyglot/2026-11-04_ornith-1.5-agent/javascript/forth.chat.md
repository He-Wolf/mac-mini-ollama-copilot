
# aider chat started at 2026-11-04 13:08:27

> Aider v0.86.3.dev+less  
> Model: ollama_chat/ornith-1.5-agent with diff edit format  
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

I'll implement the Forth evaluator. Let me think through the requirements:

1. Arithmetic operations (`+`, `-`, `*`, `/`) that pop two values and push one
2. Stack manipulation (`DUP`, `DROP`, `SWAP`, `OVER`)
3. Word definitions using `: name ;` syntax
4. Case-insensitive words, case-insensitive definitions
5. Error handling for stack underflow and division by zero

Let me implement the full class:

forth.js
```javascript
<<<<<<< SEARCH
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
export class Forth {
  constructor() {
    this._stack = [];
    this._definitions = {};
    this._builtins = {
      '+': this._add,
      '-': this._subtract,
      '*': this._multiply,
      '/': this._divide,
      'dup': this._dup,
      'drop': this._drop,
      'swap': this._swap,
      'over': this._over,
    };
  }

  get stack() {
    return [...this._stack];
  }

  evaluate(input) {
    if (typeof input !== 'string') {
      throw Error('invalid input');
    }
    const tokens = input.trim().split(/\s+/).filter((t) => t.length > 0);
    let i = 0;
    while (i < tokens.length) {
      const token = tokens[i].toLowerCase();
      if (token === ':') {
        let j = i + 1;
        const def = [];
        for (; j < tokens.length; j++) {
          if (tokens[j].toLowerCase() === ';') break;
          def.push(tokens[j].toLowerCase());
        }
        if (j >= tokens.length) {
          throw Error('missing ;');
        }
        const name = def.shift();
        if (this._isNumber(name)) {
          throw Error('invalid syntax');
        }
        this._definitions[name] = def;
        i = j + 1;
      } else {
        this._execute(token);
        i++;
      }
    }
  }

  _execute(token) {
    if (Object.prototype.hasOwnProperty.call(this._definitions, token)) {
      this._definitions[token].forEach((w) => this._execute(w));
      return;
    }
    const op = this._builtins[token];
    if (op) {
      op.call(this);
      return;
    }
    if (this._isNumber(token)) {
      this._stack.push(parseInt(token, 10));
      return;
    }
    throw Error('unknown word');
  }

  _add() {
    this._binaryOp((a, b) => a + b);
  }

  _subtract() {
    this._binaryOp((a, b) => a - b);
  }

  _multiply() {
    this._binaryOp((a, b) => a * b);
  }

  _divide() {
    if (this._stack.length < 2) {
      throw Error('stack empty');
    }
    const b = this._stack.pop();
    const a = this._stack.pop();
    if (b === 0) {
      throw Error('division by zero');
    }
    this._stack.push(Math.trunc(a / b));
  }

  _binaryOp(fn) {
    if (this._stack.length < 2) {
      throw Error('stack empty');
    }
    const b = this._stack.pop();
    const a = this._stack.pop();
    this._stack.push(fn(a, b));
  }

  _dup() {
    if (this._stack.length < 1) {
      throw Error('stack empty');
    }
    const a = this._stack[this._stack.length - 1];
    this._stack.push(a);
  }

  _drop() {
    if (this._stack.length < 1) {
      throw Error('stack empty');
    }
    this._stack.pop();
  }

  _swap() {
    if (this._stack.length < 2) {
      throw Error('stack empty');
    }
    const a = this._stack.pop();
    const b = this._stack.pop();
    this._stack.push(a);
    this._stack.push(b);
  }

  _over() {
    if (this._stack.length < 2) {
      throw Error('stack empty');
    }
    const a = this._stack.pop();
    const b = this._stack.pop();
    this._stack.push(b);
    this._stack.push(a);
    this._stack.push(b);
  }

  _isNumber(token) {
    return /^-?\d+$/.test(token);
  }
}
>>>>>>> REPLACE
```

> Tokens: 2.4k sent, 8.9k received.  
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
      ✓ can add two numbers (2 ms)
      ✕ errors if there is nothing on the stack (13 ms)
      ✕ errors if there is only one value on the stack (3 ms)
    subtraction
      ✓ can subtract two numbers (1 ms)
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (2 ms)
    multiplication
      ✓ can multiply two numbers
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (2 ms)
    division
      ✓ can divide two numbers (1 ms)
      ✓ performs integer division
      ✕ errors if dividing by zero (3 ms)
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (1 ms)
    combined arithmetic
      ✓ addition and subtraction
      ✓ multiplication and division (1 ms)
    dup
      ✓ copies a value on the stack
      ✓ copies the top value on the stack
      ✕ errors if there is nothing on the stack (2 ms)
    drop
      ✓ removes the top value on the stack if it is the only one
      ✓ removes the top value on the stack if it is not the only one (1 ms)
      ✕ errors if there is nothing on the stack (1 ms)
    swap
      ✓ swaps the top two values on the stack if they are the only ones (1 ms)
      ✓ swaps the top two values on the stack if they are not the only ones
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (1 ms)
    over
      ✓ copies the second element if there are only two (1 ms)
      ✓ copies the second element if there are more than two
      ✕ errors if there is nothing on the stack (5 ms)
      ✕ errors if there is only one value on the stack (1 ms)
    user-defined words
      ✓ can consist of built-in words
      ✓ execute in the right order
      ✓ can override other user-defined words
      ✓ can override built-in words
      ✓ can override built-in operators
      ✕ can use different words with the same name (2 ms)
      ✕ can define word that uses word with the same name (2 ms)
      ✕ cannot redefine numbers (3 ms)
      ✕ cannot redefine negative numbers (2 ms)
      ✕ errors if executing a non-existent word (2 ms)
      ✓ only defines locally
    case-insensitivity
      ✓ DUP is case-insensitive
      ✓ DROP is case-insensitive
      ✓ SWAP is case-insensitive
      ✓ OVER is case-insensitive
      ✓ user-defined words are case-insensitive
      ✓ definitions are case-insensitive

  ● Forth › addition › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp [as _add] (forth.js:75:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:30:15)
      at Object.toThrow (forth.spec.js:31:10)
      at Object.toThrow (forth.spec.js:31:10)

  ● Forth › addition › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp [as _add] (forth.js:75:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:36:15)
      at Object.toThrow (forth.spec.js:37:10)
      at Object.toThrow (forth.spec.js:37:10)

  ● Forth › subtraction › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:79:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:49:15)
      at Object.toThrow (forth.spec.js:50:10)
      at Object.toThrow (forth.spec.js:50:10)

  ● Forth › subtraction › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:79:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:55:15)
      at Object.toThrow (forth.spec.js:56:10)
      at Object.toThrow (forth.spec.js:56:10)

  ● Forth › multiplication › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:83:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:68:15)
      at Object.toThrow (forth.spec.js:69:10)
      at Object.toThrow (forth.spec.js:69:10)

  ● Forth › multiplication › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:83:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:74:15)
      at Object.toThrow (forth.spec.js:75:10)
      at Object.toThrow (forth.spec.js:75:10)

  ● Forth › division › errors if dividing by zero

    expect(received).toThrow(expected)

    Expected message: "Division by zero"
    Received message: "division by zero"

          91 |     const a = this._stack.pop();
          92 |     if (b === 0) {
        > 93 |       throw Error('division by zero');
             |             ^
          94 |     }
          95 |     this._stack.push(Math.trunc(a / b));
          96 |   }

      at Forth.Error [as _divide] (forth.js:93:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:92:15)
      at Object.toThrow (forth.spec.js:93:10)
      at Object.toThrow (forth.spec.js:93:10)

  ● Forth › division › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          86 |   _divide() {
          87 |     if (this._stack.length < 2) {
        > 88 |       throw Error('stack empty');
             |             ^
          89 |     }
          90 |     const b = this._stack.pop();
          91 |     const a = this._stack.pop();

      at Forth.Error [as _divide] (forth.js:88:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:98:15)
      at Object.toThrow (forth.spec.js:99:10)
      at Object.toThrow (forth.spec.js:99:10)

  ● Forth › division › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          86 |   _divide() {
          87 |     if (this._stack.length < 2) {
        > 88 |       throw Error('stack empty');
             |             ^
          89 |     }
          90 |     const b = this._stack.pop();
          91 |     const a = this._stack.pop();

      at Forth.Error [as _divide] (forth.js:88:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:104:15)
      at Object.toThrow (forth.spec.js:105:10)
      at Object.toThrow (forth.spec.js:105:10)

  ● Forth › dup › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          107 |   _dup() {
          108 |     if (this._stack.length < 1) {
        > 109 |       throw Error('stack empty');
              |             ^
          110 |     }
          111 |     const a = this._stack[this._stack.length - 1];
          112 |     this._stack.push(a);

      at Forth.Error [as _dup] (forth.js:109:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:134:15)
      at Object.toThrow (forth.spec.js:135:10)
      at Object.toThrow (forth.spec.js:135:10)

  ● Forth › drop › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          115 |   _drop() {
          116 |     if (this._stack.length < 1) {
        > 117 |       throw Error('stack empty');
              |             ^
          118 |     }
          119 |     this._stack.pop();
          120 |   }

      at Forth.Error (forth.js:117:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:152:15)
      at Object.toThrow (forth.spec.js:153:10)
      at Object.toThrow (forth.spec.js:153:10)

  ● Forth › swap › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          122 |   _swap() {
          123 |     if (this._stack.length < 2) {
        > 124 |       throw Error('stack empty');
              |             ^
          125 |     }
          126 |     const a = this._stack.pop();
          127 |     const b = this._stack.pop();

      at Forth.Error (forth.js:124:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:170:15)
      at Object.toThrow (forth.spec.js:171:10)
      at Object.toThrow (forth.spec.js:171:10)

  ● Forth › swap › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          122 |   _swap() {
          123 |     if (this._stack.length < 2) {
        > 124 |       throw Error('stack empty');
              |             ^
          125 |     }
          126 |     const a = this._stack.pop();
          127 |     const b = this._stack.pop();

      at Forth.Error (forth.js:124:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:176:15)
      at Object.toThrow (forth.spec.js:177:10)
      at Object.toThrow (forth.spec.js:177:10)

  ● Forth › over › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          132 |   _over() {
          133 |     if (this._stack.length < 2) {
        > 134 |       throw Error('stack empty');
              |             ^
          135 |     }
          136 |     const a = this._stack.pop();
          137 |     const b = this._stack.pop();

      at Forth.Error (forth.js:134:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:194:15)
      at Object.toThrow (forth.spec.js:195:10)
      at Object.toThrow (forth.spec.js:195:10)

  ● Forth › over › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          132 |   _over() {
          133 |     if (this._stack.length < 2) {
        > 134 |       throw Error('stack empty');
              |             ^
          135 |     }
          136 |     const a = this._stack.pop();
          137 |     const b = this._stack.pop();

      at Forth.Error (forth.js:134:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:200:15)
      at Object.toThrow (forth.spec.js:201:10)
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

      56 |
      57 |   _execute(token) {
    > 58 |     if (Object.prototype.hasOwnProperty.call(this._definitions, token)) {
         |     ^
      59 |       this._definitions[token].forEach((w) => this._execute(w));
      60 |       return;
      61 |     }

      at Forth._execute (forth.js:58:5)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)

  ● Forth › user-defined words › cannot redefine numbers

    expect(received).toThrow(expected)

    Expected message: "Invalid definition"
    Received message: "invalid syntax"

          44 |         const name = def.shift();
          45 |         if (this._isNumber(name)) {
        > 46 |           throw Error('invalid syntax');
             |                 ^
          47 |         }
          48 |         this._definitions[name] = def;
          49 |         i = j + 1;

      at Forth.Error [as evaluate] (forth.js:46:17)
      at evaluate (forth.spec.js:254:15)
      at Object.toThrow (forth.spec.js:255:10)
      at Object.toThrow (forth.spec.js:255:10)

  ● Forth › user-defined words › cannot redefine negative numbers

    expect(received).toThrow(expected)

    Expected message: "Invalid definition"
    Received message: "invalid syntax"

          44 |         const name = def.shift();
          45 |         if (this._isNumber(name)) {
        > 46 |           throw Error('invalid syntax');
             |                 ^
          47 |         }
          48 |         this._definitions[name] = def;
          49 |         i = j + 1;

      at Forth.Error [as evaluate] (forth.js:46:17)
      at evaluate (forth.spec.js:259:15)
      at Object.toThrow (forth.spec.js:260:10)
      at Object.toThrow (forth.spec.js:260:10)

  ● Forth › user-defined words › errors if executing a non-existent word

    expect(received).toThrow(expected)

    Expected message: "Unknown command"
    Received message: "unknown word"

          69 |       return;
          70 |     }
        > 71 |     throw Error('unknown word');
             |           ^
          72 |   }
          73 |
          74 |   _add() {

      at Forth.Error [as _execute] (forth.js:71:11)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:265:15)
      at Object.toThrow (forth.spec.js:266:10)
      at Object.toThrow (forth.spec.js:266:10)

Test Suites: 1 failed, 1 total
Tests:       20 failed, 29 passed, 49 total
Snapshots:   0 total
Time:        1.271 s
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
####       ✓ can add two numbers (2 ms)  
####       ✕ errors if there is nothing on the stack (13 ms)  
####       ✕ errors if there is only one value on the stack (3 ms)  
####     subtraction  
####       ✓ can subtract two numbers (1 ms)  
####       ✕ errors if there is nothing on the stack (2 ms)  
####       ✕ errors if there is only one value on the stack (2 ms)  
####     multiplication  
####       ✓ can multiply two numbers  
####       ✕ errors if there is nothing on the stack (2 ms)  
####       ✕ errors if there is only one value on the stack (2 ms)  
####     division  
####       ✓ can divide two numbers (1 ms)  
####       ✓ performs integer division  
####       ✕ errors if dividing by zero (3 ms)  
####       ✕ errors if there is nothing on the stack (2 ms)  
####       ✕ errors if there is only one value on the stack (1 ms)  
####     combined arithmetic  
####       ✓ addition and subtraction  
####       ✓ multiplication and division (1 ms)  
####     dup  
####       ✓ copies a value on the stack  
####       ✓ copies the top value on the stack  
####       ✕ errors if there is nothing on the stack (2 ms)  
####     drop  
####       ✓ removes the top value on the stack if it is the only one  
####       ✓ removes the top value on the stack if it is not the only one (1 ms)  
####       ✕ errors if there is nothing on the stack (1 ms)  
####     swap  
####       ✓ swaps the top two values on the stack if they are the only ones (1 ms)  
####       ✓ swaps the top two values on the stack if they are not the only ones  
####       ✕ errors if there is nothing on the stack (2 ms)  
####       ✕ errors if there is only one value on the stack (1 ms)  
####     over  
####       ✓ copies the second element if there are only two (1 ms)  
####       ✓ copies the second element if there are more than two  
####       ✕ errors if there is nothing on the stack (5 ms)  
####       ✕ errors if there is only one value on the stack (1 ms)  
####     user-defined words  
####       ✓ can consist of built-in words  
####       ✓ execute in the right order  
####       ✓ can override other user-defined words  
####       ✓ can override built-in words  
####       ✓ can override built-in operators  
####       ✕ can use different words with the same name (2 ms)  
####       ✕ can define word that uses word with the same name (2 ms)  
####       ✕ cannot redefine numbers (3 ms)  
####       ✕ cannot redefine negative numbers (2 ms)  
####       ✕ errors if executing a non-existent word (2 ms)  
####       ✓ only defines locally  
####     case-insensitivity  
####       ✓ DUP is case-insensitive  
####       ✓ DROP is case-insensitive  
####       ✓ SWAP is case-insensitive  
####       ✓ OVER is case-insensitive  
####       ✓ user-defined words are case-insensitive  
####       ✓ definitions are case-insensitive  
####   
####   ● Forth › addition › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####            98 |   _binaryOp(fn) {  
####            99 |     if (this._stack.length < 2) {  
####         > 100 |       throw Error('stack empty');  
####               |             ^  
####           101 |     }  
####           102 |     const b = this._stack.pop();  
####           103 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _binaryOp] (forth.js:100:13)  
####       at Forth._binaryOp [as _add] (forth.js:75:10)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:30:15)  
####       at Object.toThrow (forth.spec.js:31:10)  
####       at Object.toThrow (forth.spec.js:31:10)  
####   
####   ● Forth › addition › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####            98 |   _binaryOp(fn) {  
####            99 |     if (this._stack.length < 2) {  
####         > 100 |       throw Error('stack empty');  
####               |             ^  
####           101 |     }  
####           102 |     const b = this._stack.pop();  
####           103 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _binaryOp] (forth.js:100:13)  
####       at Forth._binaryOp [as _add] (forth.js:75:10)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:36:15)  
####       at Object.toThrow (forth.spec.js:37:10)  
####       at Object.toThrow (forth.spec.js:37:10)  
####   
####   ● Forth › subtraction › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####            98 |   _binaryOp(fn) {  
####            99 |     if (this._stack.length < 2) {  
####         > 100 |       throw Error('stack empty');  
####               |             ^  
####           101 |     }  
####           102 |     const b = this._stack.pop();  
####           103 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _binaryOp] (forth.js:100:13)  
####       at Forth._binaryOp (forth.js:79:10)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:49:15)  
####       at Object.toThrow (forth.spec.js:50:10)  
####       at Object.toThrow (forth.spec.js:50:10)  
####   
####   ● Forth › subtraction › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####            98 |   _binaryOp(fn) {  
####            99 |     if (this._stack.length < 2) {  
####         > 100 |       throw Error('stack empty');  
####               |             ^  
####           101 |     }  
####           102 |     const b = this._stack.pop();  
####           103 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _binaryOp] (forth.js:100:13)  
####       at Forth._binaryOp (forth.js:79:10)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:55:15)  
####       at Object.toThrow (forth.spec.js:56:10)  
####       at Object.toThrow (forth.spec.js:56:10)  
####   
####   ● Forth › multiplication › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####            98 |   _binaryOp(fn) {  
####            99 |     if (this._stack.length < 2) {  
####         > 100 |       throw Error('stack empty');  
####               |             ^  
####           101 |     }  
####           102 |     const b = this._stack.pop();  
####           103 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _binaryOp] (forth.js:100:13)  
####       at Forth._binaryOp (forth.js:83:10)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:68:15)  
####       at Object.toThrow (forth.spec.js:69:10)  
####       at Object.toThrow (forth.spec.js:69:10)  
####   
####   ● Forth › multiplication › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####            98 |   _binaryOp(fn) {  
####            99 |     if (this._stack.length < 2) {  
####         > 100 |       throw Error('stack empty');  
####               |             ^  
####           101 |     }  
####           102 |     const b = this._stack.pop();  
####           103 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _binaryOp] (forth.js:100:13)  
####       at Forth._binaryOp (forth.js:83:10)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:74:15)  
####       at Object.toThrow (forth.spec.js:75:10)  
####       at Object.toThrow (forth.spec.js:75:10)  
####   
####   ● Forth › division › errors if dividing by zero  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Division by zero"  
####     Received message: "division by zero"  
####   
####           91 |     const a = this._stack.pop();  
####           92 |     if (b === 0) {  
####         > 93 |       throw Error('division by zero');  
####              |             ^  
####           94 |     }  
####           95 |     this._stack.push(Math.trunc(a / b));  
####           96 |   }  
####   
####       at Forth.Error [as _divide] (forth.js:93:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:92:15)  
####       at Object.toThrow (forth.spec.js:93:10)  
####       at Object.toThrow (forth.spec.js:93:10)  
####   
####   ● Forth › division › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           86 |   _divide() {  
####           87 |     if (this._stack.length < 2) {  
####         > 88 |       throw Error('stack empty');  
####              |             ^  
####           89 |     }  
####           90 |     const b = this._stack.pop();  
####           91 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _divide] (forth.js:88:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:98:15)  
####       at Object.toThrow (forth.spec.js:99:10)  
####       at Object.toThrow (forth.spec.js:99:10)  
####   
####   ● Forth › division › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           86 |   _divide() {  
####           87 |     if (this._stack.length < 2) {  
####         > 88 |       throw Error('stack empty');  
####              |             ^  
####           89 |     }  
####           90 |     const b = this._stack.pop();  
####           91 |     const a = this._stack.pop();  
####   
####       at Forth.Error [as _divide] (forth.js:88:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:104:15)  
####       at Object.toThrow (forth.spec.js:105:10)  
####       at Object.toThrow (forth.spec.js:105:10)  
####   
####   ● Forth › dup › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           107 |   _dup() {  
####           108 |     if (this._stack.length < 1) {  
####         > 109 |       throw Error('stack empty');  
####               |             ^  
####           110 |     }  
####           111 |     const a = this._stack[this._stack.length - 1];  
####           112 |     this._stack.push(a);  
####   
####       at Forth.Error [as _dup] (forth.js:109:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:134:15)  
####       at Object.toThrow (forth.spec.js:135:10)  
####       at Object.toThrow (forth.spec.js:135:10)  
####   
####   ● Forth › drop › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           115 |   _drop() {  
####           116 |     if (this._stack.length < 1) {  
####         > 117 |       throw Error('stack empty');  
####               |             ^  
####           118 |     }  
####           119 |     this._stack.pop();  
####           120 |   }  
####   
####       at Forth.Error (forth.js:117:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:152:15)  
####       at Object.toThrow (forth.spec.js:153:10)  
####       at Object.toThrow (forth.spec.js:153:10)  
####   
####   ● Forth › swap › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           122 |   _swap() {  
####           123 |     if (this._stack.length < 2) {  
####         > 124 |       throw Error('stack empty');  
####               |             ^  
####           125 |     }  
####           126 |     const a = this._stack.pop();  
####           127 |     const b = this._stack.pop();  
####   
####       at Forth.Error (forth.js:124:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:170:15)  
####       at Object.toThrow (forth.spec.js:171:10)  
####       at Object.toThrow (forth.spec.js:171:10)  
####   
####   ● Forth › swap › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           122 |   _swap() {  
####           123 |     if (this._stack.length < 2) {  
####         > 124 |       throw Error('stack empty');  
####               |             ^  
####           125 |     }  
####           126 |     const a = this._stack.pop();  
####           127 |     const b = this._stack.pop();  
####   
####       at Forth.Error (forth.js:124:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:176:15)  
####       at Object.toThrow (forth.spec.js:177:10)  
####       at Object.toThrow (forth.spec.js:177:10)  
####   
####   ● Forth › over › errors if there is nothing on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           132 |   _over() {  
####           133 |     if (this._stack.length < 2) {  
####         > 134 |       throw Error('stack empty');  
####               |             ^  
####           135 |     }  
####           136 |     const a = this._stack.pop();  
####           137 |     const b = this._stack.pop();  
####   
####       at Forth.Error (forth.js:134:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:194:15)  
####       at Object.toThrow (forth.spec.js:195:10)  
####       at Object.toThrow (forth.spec.js:195:10)  
####   
####   ● Forth › over › errors if there is only one value on the stack  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Stack empty"  
####     Received message: "stack empty"  
####   
####           132 |   _over() {  
####           133 |     if (this._stack.length < 2) {  
####         > 134 |       throw Error('stack empty');  
####               |             ^  
####           135 |     }  
####           136 |     const a = this._stack.pop();  
####           137 |     const b = this._stack.pop();  
####   
####       at Forth.Error (forth.js:134:13)  
####       at Forth.call [as _execute] (forth.js:64:10)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:200:15)  
####       at Object.toThrow (forth.spec.js:201:10)  
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
####   
####       56 |  
####       57 |   _execute(token) {  
####     > 58 |     if (Object.prototype.hasOwnProperty.call(this._definitions, token)) {  
####          |     ^  
####       59 |       this._definitions[token].forEach((w) => this._execute(w));  
####       60 |       return;  
####       61 |     }  
####   
####       at Forth._execute (forth.js:58:5)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####       at _execute (forth.js:59:52)  
####           at Array.forEach (<anonymous>)  
####       at Forth.forEach [as _execute] (forth.js:59:32)  
####   
####   ● Forth › user-defined words › cannot redefine numbers  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Invalid definition"  
####     Received message: "invalid syntax"  
####   
####           44 |         const name = def.shift();  
####           45 |         if (this._isNumber(name)) {  
####         > 46 |           throw Error('invalid syntax');  
####              |                 ^  
####           47 |         }  
####           48 |         this._definitions[name] = def;  
####           49 |         i = j + 1;  
####   
####       at Forth.Error [as evaluate] (forth.js:46:17)  
####       at evaluate (forth.spec.js:254:15)  
####       at Object.toThrow (forth.spec.js:255:10)  
####       at Object.toThrow (forth.spec.js:255:10)  
####   
####   ● Forth › user-defined words › cannot redefine negative numbers  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Invalid definition"  
####     Received message: "invalid syntax"  
####   
####           44 |         const name = def.shift();  
####           45 |         if (this._isNumber(name)) {  
####         > 46 |           throw Error('invalid syntax');  
####              |                 ^  
####           47 |         }  
####           48 |         this._definitions[name] = def;  
####           49 |         i = j + 1;  
####   
####       at Forth.Error [as evaluate] (forth.js:46:17)  
####       at evaluate (forth.spec.js:259:15)  
####       at Object.toThrow (forth.spec.js:260:10)  
####       at Object.toThrow (forth.spec.js:260:10)  
####   
####   ● Forth › user-defined words › errors if executing a non-existent word  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Unknown command"  
####     Received message: "unknown word"  
####   
####           69 |       return;  
####           70 |     }  
####         > 71 |     throw Error('unknown word');  
####              |           ^  
####           72 |   }  
####           73 |  
####           74 |   _add() {  
####   
####       at Forth.Error [as _execute] (forth.js:71:11)  
####       at Forth._execute (forth.js:51:14)  
####       at evaluate (forth.spec.js:265:15)  
####       at Object.toThrow (forth.spec.js:266:10)  
####       at Object.toThrow (forth.spec.js:266:10)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       20 failed, 29 passed, 49 total  
#### Snapshots:   0 total  
#### Time:        1.271 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./forth.js|./forth.spec.js|./node_modules|./package-lock.json|./package.json.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in forth.js to resolve the errors.  
> litellm.APIConnectionError: Ollama_chatException - Server disconnected without sending a response.  
> Retrying in 0.2 seconds...  
> litellm.APIConnectionError: Ollama_chatException - [Errno 111] Connection refused  
> Retrying in 0.5 seconds...  
> litellm.APIConnectionError: Ollama_chatException - [Errno 111] Connection refused  
> Retrying in 1.0 seconds...  
> litellm.APIConnectionError: Ollama_chatException - [Errno 111] Connection refused  
> Retrying in 2.0 seconds...  
> litellm.APIConnectionError: Ollama_chatException - [Errno 111] Connection refused  
> Retrying in 4.0 seconds...  
> litellm.APIConnectionError: Ollama_chatException - [Errno 111] Connection refused  
> Retrying in 8.0 seconds...  
> Tokens: 11k sent, 16k received.  
```

> test
> jest ./*

FAIL ./forth.spec.js
  Forth
    parsing and numbers
      ✓ numbers just get pushed onto the stack (4 ms)
      ✓ pushes negative numbers onto the stack (1 ms)
    addition
      ✓ can add two numbers (1 ms)
      ✕ errors if there is nothing on the stack (31 ms)
      ✕ errors if there is only one value on the stack (8 ms)
    subtraction
      ✓ can subtract two numbers (1 ms)
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (3 ms)
    multiplication
      ✓ can multiply two numbers (1 ms)
      ✕ errors if there is nothing on the stack (3 ms)
      ✕ errors if there is only one value on the stack (3 ms)
    division
      ✓ can divide two numbers
      ✓ performs integer division
      ✕ errors if dividing by zero (2 ms)
      ✕ errors if there is nothing on the stack (1 ms)
      ✕ errors if there is only one value on the stack (3 ms)
    combined arithmetic
      ✓ addition and subtraction
      ✓ multiplication and division
    dup
      ✓ copies a value on the stack (1 ms)
      ✓ copies the top value on the stack
      ✕ errors if there is nothing on the stack (2 ms)
    drop
      ✓ removes the top value on the stack if it is the only one (1 ms)
      ✓ removes the top value on the stack if it is not the only one
      ✕ errors if there is nothing on the stack (2 ms)
    swap
      ✓ swaps the top two values on the stack if they are the only ones (1 ms)
      ✓ swaps the top two values on the stack if they are not the only ones (1 ms)
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (4 ms)
    over
      ✓ copies the second element if there are only two (1 ms)
      ✓ copies the second element if there are more than two (1 ms)
      ✕ errors if there is nothing on the stack (2 ms)
      ✕ errors if there is only one value on the stack (3 ms)
    user-defined words
      ✓ can consist of built-in words (1 ms)
      ✓ execute in the right order
      ✓ can override other user-defined words
      ✓ can override built-in words (1 ms)
      ✓ can override built-in operators
      ✕ can use different words with the same name (2 ms)
      ✕ can define word that uses word with the same name (5 ms)
      ✕ cannot redefine numbers (2 ms)
      ✕ cannot redefine negative numbers (2 ms)
      ✕ errors if executing a non-existent word (1 ms)
      ✓ only defines locally
    case-insensitivity
      ✓ DUP is case-insensitive (1 ms)
      ✓ DROP is case-insensitive (5 ms)
      ✓ SWAP is case-insensitive (1 ms)
      ✓ OVER is case-insensitive
      ✓ user-defined words are case-insensitive (1 ms)
      ✓ definitions are case-insensitive

  ● Forth › addition › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp [as _add] (forth.js:75:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:30:15)
      at Object.toThrow (forth.spec.js:31:10)
      at Object.toThrow (forth.spec.js:31:10)

  ● Forth › addition › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp [as _add] (forth.js:75:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:36:15)
      at Object.toThrow (forth.spec.js:37:10)
      at Object.toThrow (forth.spec.js:37:10)

  ● Forth › subtraction › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:79:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:49:15)
      at Object.toThrow (forth.spec.js:50:10)
      at Object.toThrow (forth.spec.js:50:10)

  ● Forth › subtraction › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:79:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:55:15)
      at Object.toThrow (forth.spec.js:56:10)
      at Object.toThrow (forth.spec.js:56:10)

  ● Forth › multiplication › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:83:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:68:15)
      at Object.toThrow (forth.spec.js:69:10)
      at Object.toThrow (forth.spec.js:69:10)

  ● Forth › multiplication › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

           98 |   _binaryOp(fn) {
           99 |     if (this._stack.length < 2) {
        > 100 |       throw Error('stack empty');
              |             ^
          101 |     }
          102 |     const b = this._stack.pop();
          103 |     const a = this._stack.pop();

      at Forth.Error [as _binaryOp] (forth.js:100:13)
      at Forth._binaryOp (forth.js:83:10)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:74:15)
      at Object.toThrow (forth.spec.js:75:10)
      at Object.toThrow (forth.spec.js:75:10)

  ● Forth › division › errors if dividing by zero

    expect(received).toThrow(expected)

    Expected message: "Division by zero"
    Received message: "division by zero"

          91 |     const a = this._stack.pop();
          92 |     if (b === 0) {
        > 93 |       throw Error('division by zero');
             |             ^
          94 |     }
          95 |     this._stack.push(Math.trunc(a / b));
          96 |   }

      at Forth.Error [as _divide] (forth.js:93:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:92:15)
      at Object.toThrow (forth.spec.js:93:10)
      at Object.toThrow (forth.spec.js:93:10)

  ● Forth › division › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          86 |   _divide() {
          87 |     if (this._stack.length < 2) {
        > 88 |       throw Error('stack empty');
             |             ^
          89 |     }
          90 |     const b = this._stack.pop();
          91 |     const a = this._stack.pop();

      at Forth.Error [as _divide] (forth.js:88:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:98:15)
      at Object.toThrow (forth.spec.js:99:10)
      at Object.toThrow (forth.spec.js:99:10)

  ● Forth › division › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          86 |   _divide() {
          87 |     if (this._stack.length < 2) {
        > 88 |       throw Error('stack empty');
             |             ^
          89 |     }
          90 |     const b = this._stack.pop();
          91 |     const a = this._stack.pop();

      at Forth.Error [as _divide] (forth.js:88:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:104:15)
      at Object.toThrow (forth.spec.js:105:10)
      at Object.toThrow (forth.spec.js:105:10)

  ● Forth › dup › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          107 |   _dup() {
          108 |     if (this._stack.length < 1) {
        > 109 |       throw Error('stack empty');
              |             ^
          110 |     }
          111 |     const a = this._stack[this._stack.length - 1];
          112 |     this._stack.push(a);

      at Forth.Error [as _dup] (forth.js:109:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:134:15)
      at Object.toThrow (forth.spec.js:135:10)
      at Object.toThrow (forth.spec.js:135:10)

  ● Forth › drop › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          115 |   _drop() {
          116 |     if (this._stack.length < 1) {
        > 117 |       throw Error('stack empty');
              |             ^
          118 |     }
          119 |     this._stack.pop();
          120 |   }

      at Forth.Error (forth.js:117:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:152:15)
      at Object.toThrow (forth.spec.js:153:10)
      at Object.toThrow (forth.spec.js:153:10)

  ● Forth › swap › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          122 |   _swap() {
          123 |     if (this._stack.length < 2) {
        > 124 |       throw Error('stack empty');
              |             ^
          125 |     }
          126 |     const a = this._stack.pop();
          127 |     const b = this._stack.pop();

      at Forth.Error (forth.js:124:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:170:15)
      at Object.toThrow (forth.spec.js:171:10)
      at Object.toThrow (forth.spec.js:171:10)

  ● Forth › swap › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          122 |   _swap() {
          123 |     if (this._stack.length < 2) {
        > 124 |       throw Error('stack empty');
              |             ^
          125 |     }
          126 |     const a = this._stack.pop();
          127 |     const b = this._stack.pop();

      at Forth.Error (forth.js:124:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:176:15)
      at Object.toThrow (forth.spec.js:177:10)
      at Object.toThrow (forth.spec.js:177:10)

  ● Forth › over › errors if there is nothing on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          132 |   _over() {
          133 |     if (this._stack.length < 2) {
        > 134 |       throw Error('stack empty');
              |             ^
          135 |     }
          136 |     const a = this._stack.pop();
          137 |     const b = this._stack.pop();

      at Forth.Error (forth.js:134:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:194:15)
      at Object.toThrow (forth.spec.js:195:10)
      at Object.toThrow (forth.spec.js:195:10)

  ● Forth › over › errors if there is only one value on the stack

    expect(received).toThrow(expected)

    Expected message: "Stack empty"
    Received message: "stack empty"

          132 |   _over() {
          133 |     if (this._stack.length < 2) {
        > 134 |       throw Error('stack empty');
              |             ^
          135 |     }
          136 |     const a = this._stack.pop();
          137 |     const b = this._stack.pop();

      at Forth.Error (forth.js:134:13)
      at Forth.call [as _execute] (forth.js:64:10)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:200:15)
      at Object.toThrow (forth.spec.js:201:10)
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

      56 |
      57 |   _execute(token) {
    > 58 |     if (Object.prototype.hasOwnProperty.call(this._definitions, token)) {
         |     ^
      59 |       this._definitions[token].forEach((w) => this._execute(w));
      60 |       return;
      61 |     }

      at Forth._execute (forth.js:58:5)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)
      at _execute (forth.js:59:52)
          at Array.forEach (<anonymous>)
      at Forth.forEach [as _execute] (forth.js:59:32)

  ● Forth › user-defined words › cannot redefine numbers

    expect(received).toThrow(expected)

    Expected message: "Invalid definition"
    Received message: "invalid syntax"

          44 |         const name = def.shift();
          45 |         if (this._isNumber(name)) {
        > 46 |           throw Error('invalid syntax');
             |                 ^
          47 |         }
          48 |         this._definitions[name] = def;
          49 |         i = j + 1;

      at Forth.Error [as evaluate] (forth.js:46:17)
      at evaluate (forth.spec.js:254:15)
      at Object.toThrow (forth.spec.js:255:10)
      at Object.toThrow (forth.spec.js:255:10)

  ● Forth › user-defined words › cannot redefine negative numbers

    expect(received).toThrow(expected)

    Expected message: "Invalid definition"
    Received message: "invalid syntax"

          44 |         const name = def.shift();
          45 |         if (this._isNumber(name)) {
        > 46 |           throw Error('invalid syntax');
             |                 ^
          47 |         }
          48 |         this._definitions[name] = def;
          49 |         i = j + 1;

      at Forth.Error [as evaluate] (forth.js:46:17)
      at evaluate (forth.spec.js:259:15)
      at Object.toThrow (forth.spec.js:260:10)
      at Object.toThrow (forth.spec.js:260:10)

  ● Forth › user-defined words › errors if executing a non-existent word

    expect(received).toThrow(expected)

    Expected message: "Unknown command"
    Received message: "unknown word"

          69 |       return;
          70 |     }
        > 71 |     throw Error('unknown word');
             |           ^
          72 |   }
          73 |
          74 |   _add() {

      at Forth.Error [as _execute] (forth.js:71:11)
      at Forth._execute (forth.js:51:14)
      at evaluate (forth.spec.js:265:15)
      at Object.toThrow (forth.spec.js:266:10)
      at Object.toThrow (forth.spec.js:266:10)

Test Suites: 1 failed, 1 total
Tests:       20 failed, 29 passed, 49 total
Snapshots:   0 total
Time:        0.72 s, estimated 2 s
Ran all test suites matching ./LICENSE|./babel.config.js|./forth.js|./forth.spec.js|./node_modules|./package-lock.json|./package.json.

```