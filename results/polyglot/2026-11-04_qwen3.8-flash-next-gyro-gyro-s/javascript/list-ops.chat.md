
# aider chat started at 2026-11-04 17:11:23

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-flash-next-gyro-gyro-s with diff edit format, reasoning none  
> Git repo: none  
> Repo-map: disabled  
> Added list-ops.js to the chat.  

#### # Instructions  
####   
#### Implement basic list operations.  
####   
#### In functional languages list operations like `length`, `map`, and `reduce` are very common.  
#### Implement a series of basic list operations, without using existing functions.  
####   
#### The precise number and names of the operations to be implemented will be track dependent to avoid conflicts with existing names, but the general operations you will implement include:  
####   
#### - `append` (_given two lists, add all items in the second list to the end of the first list_);  
#### - `concatenate` (_given a series of lists, combine all items in all lists into one flattened list_);  
#### - `filter` (_given a predicate and a list, return the list of all items for which `predicate(item)` is True_);  
#### - `length` (_given a list, return the total number of items within it_);  
#### - `map` (_given a function and a list, return the list of the results of applying `function(item)` on all items_);  
#### - `foldl` (_given a function, a list, and initial accumulator, fold (reduce) each item into the accumulator from the left_);  
#### - `foldr` (_given a function, a list, and an initial accumulator, fold (reduce) each item into the accumulator from the right_);  
#### - `reverse` (_given a list, return a list with all the original items, but in reversed order_).  
####   
#### Note, the ordering in which arguments are passed to the fold functions (`foldl`, `foldr`) is significant.  
#### # Instructions append  
####   
#### Using core language features to build and deconstruct arrays via destructuring, and using the array literal `[]` are allowed, but no functions from the `Array.prototype` should be used.  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: list-ops.js  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

To implement the list operations without using `Array.prototype` methods, we will use destructuring and array literals. The class needs to store items internally (likely in an array) and implement each method by iterating or destructuring manually.

Here are the changes for `list-ops.js`:

1.  **Constructor**: Initialize an empty array to hold list items.
2.  **append**: Takes another List, iterates through its items, and adds them to the current list using destructuring/concatenation via array literals.
3.  **concat**: Takes multiple Lists, flattens them into a new List.
4.  **filter**: Iterates through items, checks predicate, builds new list.
5.  **map**: Iterates through items, applies function, builds new list.
6.  **length**: Counts items by iterating or destructuring.
7.  **foldl**: Reduces from left to right using a loop.
8.  **foldr**: Reduces from right to left using a loop (iterating backwards).
9.  **reverse**: Builds a new list with items in reverse order.

list-ops.js
```javascript
<<<<<<< SEARCH
export class List {
  constructor() {
    throw new Error('Remove this statement and implement this function');
  }

  append() {
    throw new Error('Remove this statement and implement this function');
  }

  concat() {
    throw new Error('Remove this statement and implement this function');
  }

  filter() {
    throw new Error('Remove this statement and implement this function');
  }

  map() {
    throw new Error('Remove this statement and implement this function');
  }

  length() {
    throw new Error('Remove this statement and implement this function');
  }

  foldl() {
    throw new Error('Remove this statement and implement this function');
  }

  foldr() {
    throw new Error('Remove this statement and implement this function');
  }

  reverse() {
    throw new Error('Remove this statement and implement this function');
  }
}
=======
export class List {
  constructor(items = []) {
    this.items = items;
  }

  append(list) {
    const result = [];
    for (const item of this.items) {
      result[result.length] = item;
    }
    for (const item of list.items) {
      result[result.length] = item;
    }
    return new List(result);
  }

  concat(lists) {
    const result = [];
    for (const list of lists) {
      for (const item of list.items) {
        result[result.length] = item;
      }
    }
    return new List(result);
  }

  filter(predicate) {
    const result = [];
    for (const item of this.items) {
      if (predicate(item)) {
        result[result.length] = item;
      }
    }
    return new List(result);
  }

  map(fn) {
    const result = [];
    for (const item of this.items) {
      result[result.length] = fn(item);
    }
    return new List(result);
  }

  length() {
    let count = 0;
    for (const _ of this.items) {
      count++;
    }
    return count;
  }

  foldl(fn, initial) {
    let accumulator = initial;
    for (const item of this.items) {
      accumulator = fn(accumulator, item);
    }
    return accumulator;
  }

  foldr(fn, initial) {
    let accumulator = initial;
    // Iterate backwards manually since we can't use reverse() or pop() easily without Array.prototype
    const len = this.length();
    for (let i = len - 1; i >= 0; i--) {
      accumulator = fn(accumulator, this.items[i]);
    }
    return accumulator;
  }

  reverse() {
    const result = [];
    const len = this.length();
    for (let i = len - 1; i >= 0; i--) {
      result[result.length] = this.items[i];
    }
    return new List(result);
  }
}
>>>>>>> REPLACE
```

> Tokens: 2.7k sent, 954 received.  
> Applied edit to list-ops.js  
```

> test
> jest ./*

FAIL ./list-ops.spec.js
  append entries to a list and return the new list
    ✓ empty lists (2 ms)
    ✓ empty list to list (1 ms)
    ✕ non-empty lists (2 ms)
  concat lists and lists of lists into new list
    ✕ empty list (1 ms)
    ✕ list of lists
  filter list returning only values that satisfy the filter function
    ✕ empty list (1 ms)
    ✕ non empty list (1 ms)
  returns the length of a list
    ✓ empty list
    ✓ non-empty list (1 ms)
  returns a list of elements whose values equal the list value transformed by the mapping function
    ✕ empty list (1 ms)
    ✕ non-empty list (1 ms)
  folds (reduces) the given list from the left with a function
    ✓ empty list
    ✓ direction independent function applied to non-empty list (1 ms)
    ✓ direction dependent function applied to non-empty list
  folds (reduces) the given list from the right with a function
    ✓ empty list
    ✓ direction independent function applied to non-empty list
    ✓ direction dependent function applied to non-empty list
  reverse the elements of a list
    ✕ empty list (1 ms)
    ✕ non-empty list
    ✕ list of lists is not flattened

  ● append entries to a list and return the new list › non-empty lists

    expect(received).toEqual(expected) // deep equality

    Expected: [1, 2, 2, 3, 4, 5]
    Received: undefined

      17 |     const list1 = new List([1, 2]);
      18 |     const list2 = new List([2, 3, 4, 5]);
    > 19 |     expect(list1.append(list2).values).toEqual([1, 2, 2, 3, 4, 5]);
         |                                        ^
      20 |   });
      21 | });
      22 |

      at Object.toEqual (list-ops.spec.js:19:40)

  ● concat lists and lists of lists into new list › empty list

    TypeError: lists is not iterable

      22 |   concat(lists) {
      23 |     const result = [];
    > 24 |     for (const list of lists) {
         |                        ^
      25 |       for (const item of list.items) {
      26 |         result[result.length] = item;
      27 |       }

      at List.lists [as concat] (list-ops.js:24:24)
      at Object.concat (list-ops.spec.js:27:18)

  ● concat lists and lists of lists into new list › list of lists

    TypeError: lists is not iterable

      22 |   concat(lists) {
      23 |     const result = [];
    > 24 |     for (const list of lists) {
         |                        ^
      25 |       for (const item of list.items) {
      26 |         result[result.length] = item;
      27 |       }

      at List.lists [as concat] (list-ops.js:24:24)
      at Object.concat (list-ops.spec.js:36:18)

  ● filter list returning only values that satisfy the filter function › empty list

    expect(received).toEqual(expected) // deep equality

    Expected: []
    Received: undefined

      41 |   test('empty list', () => {
      42 |     const list1 = new List([]);
    > 43 |     expect(list1.filter((el) => el % 2 === 1).values).toEqual([]);
         |                                                       ^
      44 |   });
      45 |
      46 |   test('non empty list', () => {

      at Object.toEqual (list-ops.spec.js:43:55)

  ● filter list returning only values that satisfy the filter function › non empty list

    expect(received).toEqual(expected) // deep equality

    Expected: [1, 3, 5]
    Received: undefined

      46 |   test('non empty list', () => {
      47 |     const list1 = new List([1, 2, 3, 5]);
    > 48 |     expect(list1.filter((el) => el % 2 === 1).values).toEqual([1, 3, 5]);
         |                                                       ^
      49 |   });
      50 | });
      51 |

      at Object.toEqual (list-ops.spec.js:48:55)

  ● returns a list of elements whose values equal the list value transformed by the mapping function › empty list

    expect(received).toEqual(expected) // deep equality

    Expected: []
    Received: undefined

      65 |   test('empty list', () => {
      66 |     const list1 = new List();
    > 67 |     expect(list1.map((el) => ++el).values).toEqual([]);
         |                                            ^
      68 |   });
      69 |
      70 |   test('non-empty list', () => {

      at Object.toEqual (list-ops.spec.js:67:44)

  ● returns a list of elements whose values equal the list value transformed by the mapping function › non-empty list

    expect(received).toEqual(expected) // deep equality

    Expected: [2, 4, 6, 8]
    Received: undefined

      70 |   test('non-empty list', () => {
      71 |     const list1 = new List([1, 3, 5, 7]);
    > 72 |     expect(list1.map((el) => ++el).values).toEqual([2, 4, 6, 8]);
         |                                            ^
      73 |   });
      74 | });
      75 |

      at Object.toEqual (list-ops.spec.js:72:44)

  ● reverse the elements of a list › empty list

    expect(received).toEqual(expected) // deep equality

    Expected: []
    Received: undefined

      111 |   test('empty list', () => {
      112 |     const list1 = new List();
    > 113 |     expect(list1.reverse().values).toEqual([]);
          |                                    ^
      114 |   });
      115 |
      116 |   test('non-empty list', () => {

      at Object.toEqual (list-ops.spec.js:113:36)

  ● reverse the elements of a list › non-empty list

    expect(received).toEqual(expected) // deep equality

    Expected: [7, 5, 3, 1]
    Received: undefined

      116 |   test('non-empty list', () => {
      117 |     const list1 = new List([1, 3, 5, 7]);
    > 118 |     expect(list1.reverse().values).toEqual([7, 5, 3, 1]);
          |                                    ^
      119 |   });
      120 |
      121 |   test('list of lists is not flattened', () => {

      at Object.toEqual (list-ops.spec.js:118:36)

  ● reverse the elements of a list › list of lists is not flattened

    expect(received).toEqual(expected) // deep equality

    Expected: [[4, 5, 6], [], [3], [1, 2]]
    Received: undefined

      121 |   test('list of lists is not flattened', () => {
      122 |     const list1 = new List([[1, 2], [3], [], [4, 5, 6]]);
    > 123 |     expect(list1.reverse().values).toEqual([[4, 5, 6], [], [3], [1, 2]]);
          |                                    ^
      124 |   });
      125 | });
      126 |

      at Object.toEqual (list-ops.spec.js:123:36)

Test Suites: 1 failed, 1 total
Tests:       10 failed, 10 passed, 20 total
Snapshots:   0 total
Time:        0.558 s
Ran all test suites matching ./LICENSE|./babel.config.js|./list-ops.js|./list-ops.spec.js|./node_modules|./package-lock.json|./package.json.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./list-ops.spec.js  
####   append entries to a list and return the new list  
####     ✓ empty lists (2 ms)  
####     ✓ empty list to list (1 ms)  
####     ✕ non-empty lists (2 ms)  
####   concat lists and lists of lists into new list  
####     ✕ empty list (1 ms)  
####     ✕ list of lists  
####   filter list returning only values that satisfy the filter function  
####     ✕ empty list (1 ms)  
####     ✕ non empty list (1 ms)  
####   returns the length of a list  
####     ✓ empty list  
####     ✓ non-empty list (1 ms)  
####   returns a list of elements whose values equal the list value transformed by the mapping function  
####     ✕ empty list (1 ms)  
####     ✕ non-empty list (1 ms)  
####   folds (reduces) the given list from the left with a function  
####     ✓ empty list  
####     ✓ direction independent function applied to non-empty list (1 ms)  
####     ✓ direction dependent function applied to non-empty list  
####   folds (reduces) the given list from the right with a function  
####     ✓ empty list  
####     ✓ direction independent function applied to non-empty list  
####     ✓ direction dependent function applied to non-empty list  
####   reverse the elements of a list  
####     ✕ empty list (1 ms)  
####     ✕ non-empty list  
####     ✕ list of lists is not flattened  
####   
####   ● append entries to a list and return the new list › non-empty lists  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: [1, 2, 2, 3, 4, 5]  
####     Received: undefined  
####   
####       17 |     const list1 = new List([1, 2]);  
####       18 |     const list2 = new List([2, 3, 4, 5]);  
####     > 19 |     expect(list1.append(list2).values).toEqual([1, 2, 2, 3, 4, 5]);  
####          |                                        ^  
####       20 |   });  
####       21 | });  
####       22 |  
####   
####       at Object.toEqual (list-ops.spec.js:19:40)  
####   
####   ● concat lists and lists of lists into new list › empty list  
####   
####     TypeError: lists is not iterable  
####   
####       22 |   concat(lists) {  
####       23 |     const result = [];  
####     > 24 |     for (const list of lists) {  
####          |                        ^  
####       25 |       for (const item of list.items) {  
####       26 |         result[result.length] = item;  
####       27 |       }  
####   
####       at List.lists [as concat] (list-ops.js:24:24)  
####       at Object.concat (list-ops.spec.js:27:18)  
####   
####   ● concat lists and lists of lists into new list › list of lists  
####   
####     TypeError: lists is not iterable  
####   
####       22 |   concat(lists) {  
####       23 |     const result = [];  
####     > 24 |     for (const list of lists) {  
####          |                        ^  
####       25 |       for (const item of list.items) {  
####       26 |         result[result.length] = item;  
####       27 |       }  
####   
####       at List.lists [as concat] (list-ops.js:24:24)  
####       at Object.concat (list-ops.spec.js:36:18)  
####   
####   ● filter list returning only values that satisfy the filter function › empty list  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: []  
####     Received: undefined  
####   
####       41 |   test('empty list', () => {  
####       42 |     const list1 = new List([]);  
####     > 43 |     expect(list1.filter((el) => el % 2 === 1).values).toEqual([]);  
####          |                                                       ^  
####       44 |   });  
####       45 |  
####       46 |   test('non empty list', () => {  
####   
####       at Object.toEqual (list-ops.spec.js:43:55)  
####   
####   ● filter list returning only values that satisfy the filter function › non empty list  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: [1, 3, 5]  
####     Received: undefined  
####   
####       46 |   test('non empty list', () => {  
####       47 |     const list1 = new List([1, 2, 3, 5]);  
####     > 48 |     expect(list1.filter((el) => el % 2 === 1).values).toEqual([1, 3, 5]);  
####          |                                                       ^  
####       49 |   });  
####       50 | });  
####       51 |  
####   
####       at Object.toEqual (list-ops.spec.js:48:55)  
####   
####   ● returns a list of elements whose values equal the list value transformed by the mapping function › empty list  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: []  
####     Received: undefined  
####   
####       65 |   test('empty list', () => {  
####       66 |     const list1 = new List();  
####     > 67 |     expect(list1.map((el) => ++el).values).toEqual([]);  
####          |                                            ^  
####       68 |   });  
####       69 |  
####       70 |   test('non-empty list', () => {  
####   
####       at Object.toEqual (list-ops.spec.js:67:44)  
####   
####   ● returns a list of elements whose values equal the list value transformed by the mapping function › non-empty list  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: [2, 4, 6, 8]  
####     Received: undefined  
####   
####       70 |   test('non-empty list', () => {  
####       71 |     const list1 = new List([1, 3, 5, 7]);  
####     > 72 |     expect(list1.map((el) => ++el).values).toEqual([2, 4, 6, 8]);  
####          |                                            ^  
####       73 |   });  
####       74 | });  
####       75 |  
####   
####       at Object.toEqual (list-ops.spec.js:72:44)  
####   
####   ● reverse the elements of a list › empty list  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: []  
####     Received: undefined  
####   
####       111 |   test('empty list', () => {  
####       112 |     const list1 = new List();  
####     > 113 |     expect(list1.reverse().values).toEqual([]);  
####           |                                    ^  
####       114 |   });  
####       115 |  
####       116 |   test('non-empty list', () => {  
####   
####       at Object.toEqual (list-ops.spec.js:113:36)  
####   
####   ● reverse the elements of a list › non-empty list  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: [7, 5, 3, 1]  
####     Received: undefined  
####   
####       116 |   test('non-empty list', () => {  
####       117 |     const list1 = new List([1, 3, 5, 7]);  
####     > 118 |     expect(list1.reverse().values).toEqual([7, 5, 3, 1]);  
####           |                                    ^  
####       119 |   });  
####       120 |  
####       121 |   test('list of lists is not flattened', () => {  
####   
####       at Object.toEqual (list-ops.spec.js:118:36)  
####   
####   ● reverse the elements of a list › list of lists is not flattened  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: [[4, 5, 6], [], [3], [1, 2]]  
####     Received: undefined  
####   
####       121 |   test('list of lists is not flattened', () => {  
####       122 |     const list1 = new List([[1, 2], [3], [], [4, 5, 6]]);  
####     > 123 |     expect(list1.reverse().values).toEqual([[4, 5, 6], [], [3], [1, 2]]);  
####           |                                    ^  
####       124 |   });  
####       125 | });  
####       126 |  
####   
####       at Object.toEqual (list-ops.spec.js:123:36)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       10 failed, 10 passed, 20 total  
#### Snapshots:   0 total  
#### Time:        0.558 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./list-ops.js|./list-ops.spec.js|./node_modules|./package-lock.json|./package.json.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in list-ops.js to resolve the errors.  

The test failures indicate two main issues:
1. The tests expect a `values` property on the returned `List` objects, but our implementation uses `items`. We need to rename `items` to `values` or expose it as `values`. Looking at the constructor `new List([1, 2])`, it seems the internal storage should be named `values` to match the test expectations (`list.values`).
2. The `concat` method expects an array of lists (or iterable), but the error says "lists is not iterable". This suggests that when calling `concat`, we might need to handle cases where arguments are passed differently, or simply ensure we iterate correctly. However, looking at typical Exercism list-ops tests, `concat` usually takes a single argument which is an array of lists, or sometimes multiple arguments. The error "lists is not iterable" happens when `lists` is undefined or not iterable. In the test `new List().concat(new List())`, it passes a single List object, not an array of Lists. Wait, looking at the test file snippet provided in the errors:
   - `list1.append(list2)` works fine if `append` takes a List.
   - `list1.concat(...)` fails. The error says `lists is not iterable`. If the test calls `concat(new List())`, then `lists` is a List object, which isn't directly iterable unless we implement an iterator or access its values. But usually `concat` in these exercises takes an array of lists. Let's look closer at the error context.
   - Actually, many Exercism implementations expect `concat` to take multiple arguments (spread) or an array. If the test calls `new List().concat(new List())`, then `lists` is a single List object. Iterating over it fails because List doesn't implement Symbol.iterator.
   - However, looking at standard solutions for this exercise, `concat` often accepts variadic arguments: `concat(...lists)`. Or it accepts an array of lists. Let's assume the tests pass arrays of lists or multiple list objects. If `concat(new List())` is called, `lists` is a List. We need to handle both cases or check how the test calls it.
   - The error trace shows `list1.concat(...)` failing with "lists is not iterable". This implies the argument passed isn't an array. If the test passes multiple arguments like `concat(listA, listB)`, then `lists` would be undefined if we don't use rest parameters. Let's change `concat` to accept rest parameters `...lists`.

   Also, the property name mismatch (`items` vs `values`) is critical. The tests check `.values`. So we must store data in `this.values`.

Let's fix:
1. Rename `this.items` to `this.values` throughout the class.
2. Update `concat` to accept rest parameters `...lists` so it can handle multiple list arguments or an array (if spread). Actually, if tests call `concat([list1, list2])`, rest params won't work directly unless we flatten. But usually these exercises use variadic args: `concat(list1, list2)`. Let's assume variadic.

Wait, looking at the error again:
`TypeError: lists is not iterable`
If the test calls `new List().concat(new List())`, and our signature is `concat(lists)`, then `lists` is a List object. A List object is not iterable by default. If we change signature to `concat(...lists)`, then `lists` becomes an array of arguments `[List]`. Then iterating over `lists` works.

So:
1. Change constructor and internal storage to use `values`.
2. Change `append` to access `list.values`.
3. Change `concat` to use rest parameters `...lists`.
4. Update all methods to use `this.values`.

list-ops.js
```javascript
<<<<<<< SEARCH
export class List {
  constructor(items = []) {
    this.items = items;
  }

  append(list) {
    const result = [];
    for (const item of this.items) {
      result[result.length] = item;
    }
    for (const item of list.items) {
      result[result.length] = item;
    }
    return new List(result);
  }

  concat(lists) {
    const result = [];
    for (const list of lists) {
      for (const item of list.items) {
        result[result.length] = item;
      }
    }
    return new List(result);
  }

  filter(predicate) {
    const result = [];
    for (const item of this.items) {
      if (predicate(item)) {
        result[result.length] = item;
      }
    }
    return new List(result);
  }

  map(fn) {
    const result = [];
    for (const item of this.items) {
      result[result.length] = fn(item);
    }
    return new List(result);
  }

  length() {
    let count = 0;
    for (const _ of this.items) {
      count++;
    }
    return count;
  }

  foldl(fn, initial) {
    let accumulator = initial;
    for (const item of this.items) {
      accumulator = fn(accumulator, item);
    }
    return accumulator;
  }

  foldr(fn, initial) {
    let accumulator = initial;
    // Iterate backwards manually since we can't use reverse() or pop() easily without Array.prototype
    const len = this.length();
    for (let i = len - 1; i >= 0; i--) {
      accumulator = fn(accumulator, this.items[i]);
    }
    return accumulator;
  }

  reverse() {
    const result = [];
    const len = this.length();
    for (let i = len - 1; i >= 0; i--) {
      result[result.length] = this.items[i];
    }
    return new List(result);
  }
}
=======
export class List {
  constructor(values = []) {
    this.values = values;
  }

  append(list) {
    const result = [];
    for (const item of this.values) {
      result[result.length] = item;
    }
    for (const item of list.values) {
      result[result.length] = item;
    }
    return new List(result);
  }

  concat(...lists) {
    const result = [];
    for (const list of lists) {
      for (const item of list.values) {
        result[result.length] = item;
      }
    }
    return new List(result);
  }

  filter(predicate) {
    const result = [];
    for (const item of this.values) {
      if (predicate(item)) {
        result[result.length] = item;
      }
    }
    return new List(result);
  }

  map(fn) {
    const result = [];
    for (const item of this.values) {
      result[result.length] = fn(item);
    }
    return new List(result);
  }

  length() {
    let count = 0;
    for (const _ of this.values) {
      count++;
    }
    return count;
  }

  foldl(fn, initial) {
    let accumulator = initial;
    for (const item of this.values) {
      accumulator = fn(accumulator, item);
    }
    return accumulator;
  }

  foldr(fn, initial) {
    let accumulator = initial;
    const len = this.length();
    for (let i = len - 1; i >= 0; i--) {
      accumulator = fn(accumulator, this.values[i]);
    }
    return accumulator;
  }

  reverse() {
    const result = [];
    const len = this.length();
    for (let i = len - 1; i >= 0; i--) {
      result[result.length] = this.values[i];
    }
    return new List(result);
  }
}
>>>>>>> REPLACE
```

> Tokens: 6.0k sent, 1.8k received.  
> Applied edit to list-ops.js  
```

> test
> jest ./*

FAIL ./list-ops.spec.js
  append entries to a list and return the new list
    ✓ empty lists (3 ms)
    ✓ empty list to list (1 ms)
    ✓ non-empty lists (1 ms)
  concat lists and lists of lists into new list
    ✓ empty list (1 ms)
    ✕ list of lists (4 ms)
  filter list returning only values that satisfy the filter function
    ✓ empty list (1 ms)
    ✓ non empty list (1 ms)
  returns the length of a list
    ✓ empty list
    ✓ non-empty list
  returns a list of elements whose values equal the list value transformed by the mapping function
    ✓ empty list (1 ms)
    ✓ non-empty list (1 ms)
  folds (reduces) the given list from the left with a function
    ✓ empty list
    ✓ direction independent function applied to non-empty list (1 ms)
    ✓ direction dependent function applied to non-empty list
  folds (reduces) the given list from the right with a function
    ✓ empty list
    ✓ direction independent function applied to non-empty list
    ✓ direction dependent function applied to non-empty list
  reverse the elements of a list
    ✓ empty list
    ✓ non-empty list
    ✓ list of lists is not flattened

  ● concat lists and lists of lists into new list › list of lists

    expect(received).toEqual(expected) // deep equality

    - Expected  -  2
    + Received  + 11

      Array [
    -   1,
    -   2,
    +   List {
    +     "values": Array [
            3,
    +     ],
    +   },
    +   List {
    +     "values": Array [],
    +   },
    +   List {
    +     "values": Array [
            4,
            5,
            6,
    +     ],
    +   },
      ]

      34 |     const list4 = new List([4, 5, 6]);
      35 |     const listOfLists = new List([list2, list3, list4]);
    > 36 |     expect(list1.concat(listOfLists).values).toEqual([1, 2, 3, 4, 5, 6]);
         |                                              ^
      37 |   });
      38 | });
      39 |

      at Object.toEqual (list-ops.spec.js:36:46)

Test Suites: 1 failed, 1 total
Tests:       1 failed, 19 passed, 20 total
Snapshots:   0 total
Time:        0.944 s, estimated 1 s
Ran all test suites matching ./LICENSE|./babel.config.js|./list-ops.js|./list-ops.spec.js|./node_modules|./package-lock.json|./package.json.

```