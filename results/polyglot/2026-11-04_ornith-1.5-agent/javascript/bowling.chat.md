
# aider chat started at 2026-11-04 12:06:53

> Aider v0.86.3.dev+less  
> Model: ollama_chat/ornith-1.5-agent with diff edit format  
> Git repo: none  
> Repo-map: disabled  
> Added bowling.js to the chat.  

#### # Instructions  
####   
#### Score a bowling game.  
####   
#### Bowling is a game where players roll a heavy ball to knock down pins arranged in a triangle.  
#### Write code to keep track of the score of a game of bowling.  
####   
#### ## Scoring Bowling  
####   
#### The game consists of 10 frames.  
#### A frame is composed of one or two ball throws with 10 pins standing at frame initialization.  
#### There are three cases for the tabulation of a frame.  
####   
#### - An open frame is where a score of less than 10 is recorded for the frame.  
####   In this case the score for the frame is the number of pins knocked down.  
####   
#### - A spare is where all ten pins are knocked down by the second throw.  
####   The total value of a spare is 10 plus the number of pins knocked down in their next throw.  
####   
#### - A strike is where all ten pins are knocked down by the first throw.  
####   The total value of a strike is 10 plus the number of pins knocked down in the next two throws.  
####   If a strike is immediately followed by a second strike, then the value of the first strike cannot be determined until the ball is thrown one more time.  
####   
#### Here is a three frame example:  
####   
#### |  Frame 1   |  Frame 2   |     Frame 3      |  
#### | :--------: | :--------: | :--------------: |  
#### | X (strike) | 5/ (spare) | 9 0 (open frame) |  
####   
#### Frame 1 is (10 + 5 + 5) = 20  
####   
#### Frame 2 is (5 + 5 + 9) = 19  
####   
#### Frame 3 is (9 + 0) = 9  
####   
#### This means the current running total is 48.  
####   
#### The tenth frame in the game is a special case.  
#### If someone throws a spare or a strike then they get one or two fill balls respectively.  
#### Fill balls exist to calculate the total of the 10th frame.  
#### Scoring a strike or spare on the fill ball does not give the player more fill balls.  
#### The total value of the 10th frame is the total number of pins knocked down.  
####   
#### For a tenth frame of X1/ (strike and a spare), the total value is 20.  
####   
#### For a tenth frame of XXX (three strikes), the total value is 30.  
####   
#### ## Requirements  
####   
#### Write code to keep track of the score of a game of bowling.  
#### It should support two operations:  
####   
#### - `roll(pins : int)` is called each time the player rolls a ball.  
####   The argument is the number of pins knocked down.  
#### - `score() : int` is called only at the very end of the game.  
####   It returns the total score for that game.  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: bowling.js  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

I'll implement the bowling scoring logic. Let me replace the skeleton with a full implementation that tracks rolls, validates them, and computes the score including strikes, spares, and fill balls.

```javascript
<<<<<<< SEARCH
export class Bowling {
  roll() {
    throw new Error('Remove this statement and implement this function');
  }

  score() {
    throw new Error('Remove this statement and implement this function');
  }
}
=======
export class Bowling {
  constructor() {
    this.rolls = [];
  }

  roll(pins) {
    if (pins < 0) {
      throw new Error('Roll cannot knock down a negative number of pins');
    }
    if (pins > 10) {
      throw new Error('Roll cannot knock down more than 10 pins');
    }
    if (this._gameComplete()) {
      throw new Error('Cannot roll after the game is complete');
    }
    this._validateRoll(pins);
    this.rolls.push(pins);
  }

  score() {
    if (!this._gameComplete()) {
      throw new Error('Score cannot be calculated until the game is complete');
    }

    let score = 0;
    let rollIndex = 0;

    for (let frame = 0; frame < 10; frame++) {
      if (this.rolls[rollIndex] === 10) {
        // Strike
        score += 10 + this.rolls[rollIndex + 1] + this.rolls[rollIndex + 2];
        rollIndex++;
      } else if (this.rolls[rollIndex] + this.rolls[rollIndex + 1] === 10) {
        // Spare
        score += 10 + this.rolls[rollIndex + 2];
        rollIndex += 2;
      } else {
        // Open frame
        score += this.rolls[rollIndex] + this.rolls[rollIndex + 1];
        rollIndex += 2;
      }
    }

    return score;
  }

  _gameComplete() {
    if (this.rolls.length < 10) {
      return false;
    }

    let rollIndex = 0;
    for (let frame = 0; frame < 9; frame++) {
      if (this.rolls[rollIndex] === 10) {
        rollIndex++;
      } else {
        rollIndex += 2;
      }
    }

    const first = this.rolls[rollIndex];
    const second = this.rolls[rollIndex + 1];
    const third = this.rolls[rollIndex + 2];

    if (first === 10) {
      return second !== undefined && third !== undefined;
    }

    if (second !== undefined && first + second === 10) {
      return third !== undefined;
    }

    return second !== undefined && first + second < 10;
  }

  _validateRoll(pins) {
    let rollIndex = 0;

    for (let frame = 0; frame < 9; frame++) {
      if (this.rolls[rollIndex] === 10) {
        rollIndex++;
      } else {
        const first = this.rolls[rollIndex];
        const second = this.rolls[rollIndex + 1];
        if (second === undefined) {
          if (first + pins > 10) {
            throw new Error('Roll cannot knock down more than the remaining pins');
          }
          return;
        }
        rollIndex += 2;
      }
    }

    const first = this.rolls[rollIndex];
    const second = this.rolls[rollIndex + 1];

    if (first === 10) {
      if (second === undefined) {
        return;
      }
      if (second === 10) {
        return;
      }
      if (second + pins > 10) {
        throw new Error('Roll cannot knock down more than the remaining pins');
      }
      return;
    }

    if (second === undefined) {
      if (first + pins > 10) {
        throw new Error('Roll cannot knock down more than the remaining pins');
      }
      return;
    }

    if (first + second === 10) {
      return;
    }

    throw new Error('Cannot roll after the game is complete');
  }
}
>>>>>>> REPLACE
```

> Tokens: 2.7k sent, 11k received.  
> The LLM did not conform to the edit format.  
> https://aider.chat/docs/troubleshooting/edit-errors.html  
> I'll implement the bowling scoring logic. Let me replace the skeleton with a full implementation that tracks rolls, validates them, and computes the score including strikes, spares, and fill balls.

```javascript
<<<<<<< SEARCH

^^^ Bad/missing filename. The filename must be alone on the line before the opening fence ```  

You're right, let me provide the edits in the correct format.

bowling.js
```javascript
<<<<<<< SEARCH
export class Bowling {
  roll() {
    throw new Error('Remove this statement and implement this function');
  }

  score() {
    throw new Error('Remove this statement and implement this function');
  }
}
=======
export class Bowling {
  constructor() {
    this.rolls = [];
  }

  roll(pins) {
    if (pins < 0) {
      throw new Error('Roll cannot knock down a negative number of pins');
    }
    if (pins > 10) {
      throw new Error('Roll cannot knock down more than 10 pins');
    }
    if (this._gameComplete()) {
      throw new Error('Cannot roll after the game is complete');
    }
    this._validateRoll(pins);
    this.rolls.push(pins);
  }

  score() {
    if (!this._gameComplete()) {
      throw new Error('Score cannot be calculated until the game is complete');
    }

    let score = 0;
    let rollIndex = 0;

    for (let frame = 0; frame < 10; frame++) {
      if (this.rolls[rollIndex] === 10) {
        // Strike
        score += 10 + this.rolls[rollIndex + 1] + this.rolls[rollIndex + 2];
        rollIndex++;
      } else if (this.rolls[rollIndex] + this.rolls[rollIndex + 1] === 10) {
        // Spare
        score += 10 + this.rolls[rollIndex + 2];
        rollIndex += 2;
      } else {
        // Open frame
        score += this.rolls[rollIndex] + this.rolls[rollIndex + 1];
        rollIndex += 2;
      }
    }

    return score;
  }

  _gameComplete() {
    if (this.rolls.length < 10) {
      return false;
    }

    let rollIndex = 0;
    for (let frame = 0; frame < 9; frame++) {
      if (this.rolls[rollIndex] === 10) {
        rollIndex++;
      } else {
        rollIndex += 2;
      }
    }

    const first = this.rolls[rollIndex];
    const second = this.rolls[rollIndex + 1];
    const third = this.rolls[rollIndex + 2];

    if (first === 10) {
      return second !== undefined && third !== undefined;
    }

    if (second !== undefined && first + second === 10) {
      return third !== undefined;
    }

    return second !== undefined && first + second < 10;
  }

  _validateRoll(pins) {
    let rollIndex = 0;

    for (let frame = 0; frame < 9; frame++) {
      if (this.rolls[rollIndex] === 10) {
        rollIndex++;
      } else {
        const first = this.rolls[rollIndex];
        const second = this.rolls[rollIndex + 1];
        if (second === undefined) {
          if (first + pins > 10) {
            throw new Error('Roll cannot knock down more than the remaining pins');
          }
          return;
        }
        rollIndex += 2;
      }
    }

    const first = this.rolls[rollIndex];
    const second = this.rolls[rollIndex + 1];

    if (first === 10) {
      if (second === undefined) {
        return;
      }
      if (second === 10) {
        return;
      }
      if (second + pins > 10) {
        throw new Error('Roll cannot knock down more than the remaining pins');
      }
      return;
    }

    if (second === undefined) {
      if (first + pins > 10) {
        throw new Error('Roll cannot knock down more than the remaining pins');
      }
      return;
    }

    if (first + second === 10) {
      return;
    }

    throw new Error('Cannot roll after the game is complete');
  }
}
>>>>>>> REPLACE
```

> Tokens: 3.9k sent, 1.1k received.  
> Applied edit to bowling.js  
```

> test
> jest ./*

FAIL ./bowling.spec.js
  Bowling
    Check game can be scored correctly.
      ✓ should be able to score a game with all zeros (3 ms)
      ✓ should be able to score a game with no strikes or spares
      ✓ a spare followed by zeros is worth ten points
      ✓ points scored in the roll after a spare are counted twice (1 ms)
      ✓ consecutive spares each get a one roll bonus (2 ms)
      ✓ a spare in the last frame gets a one roll bonus that is counted once (1 ms)
      ✓ a strike earns ten points in a frame with a single roll
      ✓ points scored in the two rolls after a strike are counted twice as a bonus
      ✓ consecutive strikes each get the two roll bonus (1 ms)
      ✓ a strike in the last frame gets a two roll bonuses that is counted once (1 ms)
      ✓ rolling a spare with the two roll bonus does not get a bonus roll (1 ms)
      ✓ strikes with the two roll bonus do not get bonus rolls
      ✓ a strike with the one roll bonus after a spare in the last frame does not get a bonus (1 ms)
      ✓ all strikes is a perfect game
    Check game rules.
      ✕ rolls cannot score negative points (16 ms)
      ✕ a roll cannot score more than 10 points (2 ms)
      ✕ two rolls in a frame cannot score more than 10 points (2 ms)
      ✕ bonus roll after a strike in the last frame cannot score more than 10 points (2 ms)
      ✕ two bonus rolls after a strike in the last frame cannot score more than 10 points (4 ms)
      ✓ two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike
      ✕ the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike (1 ms)
      ✕ second bonus roll after a strike in the last frame cannot score more than 10 points (2 ms)
      ✕ an unstarted game cannot be scored (1 ms)
      ✕ an incomplete game cannot be scored (1 ms)
      ✕ cannot roll if game already has ten frames (2 ms)
      ✕ bonus rolls for a strike in the last frame must be rolled before score can be calculated (1 ms)
      ✕ both bonus rolls for a strike in the last frame must be rolled before score can be calculated (1 ms)
      ✕ bonus roll for a spare in the last frame must be rolled before score can be calculated (2 ms)
      ✕ cannot roll after bonus roll for spare (1 ms)
      ✕ cannot roll after bonus rolls for strike (1 ms)

  ● Bowling › Check game rules. › rolls cannot score negative points

    expect(received).toThrow(expected)

    Expected message: "Negative roll is invalid"
    Received message: "Roll cannot knock down a negative number of pins"

          11 |   roll(pins) {
          12 |     if (pins < 0) {
        > 13 |       throw new Error('Roll cannot knock down a negative number of pins');
             |             ^
          14 |     }
          15 |     if (pins > 10) {
          16 |       throw new Error('Roll cannot knock down more than 10 pins');

      at Bowling.roll (bowling.js:13:13)
      at roll (bowling.spec.js:156:17)
      at Object.toThrow (bowling.spec.js:157:10)
      at Object.toThrow (bowling.spec.js:157:10)

  ● Bowling › Check game rules. › a roll cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Roll cannot knock down more than 10 pins"

          14 |     }
          15 |     if (pins > 10) {
        > 16 |       throw new Error('Roll cannot knock down more than 10 pins');
             |             ^
          17 |     }
          18 |     if (this._gameComplete()) {
          19 |       throw new Error('Cannot roll after the game is complete');

      at Bowling.roll (bowling.js:16:13)
      at roll (bowling.spec.js:163:17)
      at Object.toThrow (bowling.spec.js:164:10)
      at Object.toThrow (bowling.spec.js:164:10)

  ● Bowling › Check game rules. › two rolls in a frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Roll cannot knock down more than the remaining pins"

          90 |         if (second === undefined) {
          91 |           if (first + pins > 10) {
        > 92 |             throw new Error('Roll cannot knock down more than the remaining pins');
             |                   ^
          93 |           }
          94 |           return;
          95 |         }

      at Bowling._validateRoll (bowling.js:92:19)
      at Bowling._validateRoll [as roll] (bowling.js:21:10)
      at roll (bowling.spec.js:171:17)
      at Object.toThrow (bowling.spec.js:172:10)
      at Object.toThrow (bowling.spec.js:172:10)

  ● Bowling › Check game rules. › bonus roll after a strike in the last frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Roll cannot knock down more than 10 pins"

          14 |     }
          15 |     if (pins > 10) {
        > 16 |       throw new Error('Roll cannot knock down more than 10 pins');
             |             ^
          17 |     }
          18 |     if (this._gameComplete()) {
          19 |       throw new Error('Cannot roll after the game is complete');

      at Bowling.roll (bowling.js:16:13)
      at roll (bowling.spec.js:182:17)
      at Object.toThrow (bowling.spec.js:183:10)
      at Object.toThrow (bowling.spec.js:183:10)

  ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Roll cannot knock down more than the remaining pins"

          109 |       }
          110 |       if (second + pins > 10) {
        > 111 |         throw new Error('Roll cannot knock down more than the remaining pins');
              |               ^
          112 |       }
          113 |       return;
          114 |     }

      at Bowling._validateRoll (bowling.js:111:15)
      at Bowling._validateRoll [as roll] (bowling.js:21:10)
      at roll (bowling.spec.js:195:17)
      at Object.toThrow (bowling.spec.js:196:10)
      at Object.toThrow (bowling.spec.js:196:10)

  ● Bowling › Check game rules. › the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Roll cannot knock down more than the remaining pins"

          109 |       }
          110 |       if (second + pins > 10) {
        > 111 |         throw new Error('Roll cannot knock down more than the remaining pins');
              |               ^
          112 |       }
          113 |       return;
          114 |     }

      at Bowling._validateRoll (bowling.js:111:15)
      at Bowling._validateRoll [as roll] (bowling.js:21:10)
      at roll (bowling.spec.js:219:17)
      at Object.toThrow (bowling.spec.js:220:10)
      at Object.toThrow (bowling.spec.js:220:10)

  ● Bowling › Check game rules. › second bonus roll after a strike in the last frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Roll cannot knock down more than 10 pins"

          14 |     }
          15 |     if (pins > 10) {
        > 16 |       throw new Error('Roll cannot knock down more than 10 pins');
             |             ^
          17 |     }
          18 |     if (this._gameComplete()) {
          19 |       throw new Error('Cannot roll after the game is complete');

      at Bowling.roll (bowling.js:16:13)
      at roll (bowling.spec.js:232:17)
      at Object.toThrow (bowling.spec.js:233:10)
      at Object.toThrow (bowling.spec.js:233:10)

  ● Bowling › Check game rules. › an unstarted game cannot be scored

    expect(received).toThrow(expected)

    Expected message: "Score cannot be taken until the end of the game"
    Received message: "Score cannot be calculated until the game is complete"

          25 |   score() {
          26 |     if (!this._gameComplete()) {
        > 27 |       throw new Error('Score cannot be calculated until the game is complete');
             |             ^
          28 |     }
          29 |
          30 |     let score = 0;

      at Bowling.score (bowling.js:27:13)
      at score (bowling.spec.js:239:17)
      at Object.toThrow (bowling.spec.js:240:10)
      at Object.toThrow (bowling.spec.js:240:10)

  ● Bowling › Check game rules. › an incomplete game cannot be scored

    expect(received).toThrow(expected)

    Expected message: "Score cannot be taken until the end of the game"
    Received message: "Score cannot be calculated until the game is complete"

          25 |   score() {
          26 |     if (!this._gameComplete()) {
        > 27 |       throw new Error('Score cannot be calculated until the game is complete');
             |             ^
          28 |     }
          29 |
          30 |     let score = 0;

      at Bowling.score (bowling.js:27:13)
      at score (bowling.spec.js:250:17)
      at Object.toThrow (bowling.spec.js:251:10)
      at Object.toThrow (bowling.spec.js:251:10)

  ● Bowling › Check game rules. › cannot roll if game already has ten frames

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"
    Received message: "Cannot roll after the game is complete"

          17 |     }
          18 |     if (this._gameComplete()) {
        > 19 |       throw new Error('Cannot roll after the game is complete');
             |             ^
          20 |     }
          21 |     this._validateRoll(pins);
          22 |     this.rolls.push(pins);

      at Bowling.roll (bowling.js:19:13)
      at roll (bowling.spec.js:263:17)
      at Object.toThrow (bowling.spec.js:264:10)
      at Object.toThrow (bowling.spec.js:264:10)

  ● Bowling › Check game rules. › bonus rolls for a strike in the last frame must be rolled before score can be calculated

    expect(received).toThrow(expected)

    Expected message: "Score cannot be taken until the end of the game"
    Received message: "Score cannot be calculated until the game is complete"

          25 |   score() {
          26 |     if (!this._gameComplete()) {
        > 27 |       throw new Error('Score cannot be calculated until the game is complete');
             |             ^
          28 |     }
          29 |
          30 |     let score = 0;

      at Bowling.score (bowling.js:27:13)
      at score (bowling.spec.js:274:17)
      at Object.toThrow (bowling.spec.js:275:10)
      at Object.toThrow (bowling.spec.js:275:10)

  ● Bowling › Check game rules. › both bonus rolls for a strike in the last frame must be rolled before score can be calculated

    expect(received).toThrow(expected)

    Expected message: "Score cannot be taken until the end of the game"
    Received message: "Score cannot be calculated until the game is complete"

          25 |   score() {
          26 |     if (!this._gameComplete()) {
        > 27 |       throw new Error('Score cannot be calculated until the game is complete');
             |             ^
          28 |     }
          29 |
          30 |     let score = 0;

      at Bowling.score (bowling.js:27:13)
      at score (bowling.spec.js:287:17)
      at Object.toThrow (bowling.spec.js:288:10)
      at Object.toThrow (bowling.spec.js:288:10)

  ● Bowling › Check game rules. › bonus roll for a spare in the last frame must be rolled before score can be calculated

    expect(received).toThrow(expected)

    Expected message: "Score cannot be taken until the end of the game"
    Received message: "Score cannot be calculated until the game is complete"

          25 |   score() {
          26 |     if (!this._gameComplete()) {
        > 27 |       throw new Error('Score cannot be calculated until the game is complete');
             |             ^
          28 |     }
          29 |
          30 |     let score = 0;

      at Bowling.score (bowling.js:27:13)
      at score (bowling.spec.js:300:17)
      at Object.toThrow (bowling.spec.js:301:10)
      at Object.toThrow (bowling.spec.js:301:10)

  ● Bowling › Check game rules. › cannot roll after bonus roll for spare

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"
    Received message: "Cannot roll after the game is complete"

          17 |     }
          18 |     if (this._gameComplete()) {
        > 19 |       throw new Error('Cannot roll after the game is complete');
             |             ^
          20 |     }
          21 |     this._validateRoll(pins);
          22 |     this.rolls.push(pins);

      at Bowling.roll (bowling.js:19:13)
      at roll (bowling.spec.js:313:17)
      at Object.toThrow (bowling.spec.js:314:10)
      at Object.toThrow (bowling.spec.js:314:10)

  ● Bowling › Check game rules. › cannot roll after bonus rolls for strike

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"
    Received message: "Cannot roll after the game is complete"

          17 |     }
          18 |     if (this._gameComplete()) {
        > 19 |       throw new Error('Cannot roll after the game is complete');
             |             ^
          20 |     }
          21 |     this._validateRoll(pins);
          22 |     this.rolls.push(pins);

      at Bowling.roll (bowling.js:19:13)
      at roll (bowling.spec.js:326:17)
      at Object.toThrow (bowling.spec.js:327:10)
      at Object.toThrow (bowling.spec.js:327:10)

Test Suites: 1 failed, 1 total
Tests:       15 failed, 15 passed, 30 total
Snapshots:   0 total
Time:        1.223 s
Ran all test suites matching ./LICENSE|./babel.config.js|./bowling.js|./bowling.spec.js|./node_modules|./package-lock.json|./package.json.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./bowling.spec.js  
####   Bowling  
####     Check game can be scored correctly.  
####       ✓ should be able to score a game with all zeros (3 ms)  
####       ✓ should be able to score a game with no strikes or spares  
####       ✓ a spare followed by zeros is worth ten points  
####       ✓ points scored in the roll after a spare are counted twice (1 ms)  
####       ✓ consecutive spares each get a one roll bonus (2 ms)  
####       ✓ a spare in the last frame gets a one roll bonus that is counted once (1 ms)  
####       ✓ a strike earns ten points in a frame with a single roll  
####       ✓ points scored in the two rolls after a strike are counted twice as a bonus  
####       ✓ consecutive strikes each get the two roll bonus (1 ms)  
####       ✓ a strike in the last frame gets a two roll bonuses that is counted once (1 ms)  
####       ✓ rolling a spare with the two roll bonus does not get a bonus roll (1 ms)  
####       ✓ strikes with the two roll bonus do not get bonus rolls  
####       ✓ a strike with the one roll bonus after a spare in the last frame does not get a bonus (1 ms)  
####       ✓ all strikes is a perfect game  
####     Check game rules.  
####       ✕ rolls cannot score negative points (16 ms)  
####       ✕ a roll cannot score more than 10 points (2 ms)  
####       ✕ two rolls in a frame cannot score more than 10 points (2 ms)  
####       ✕ bonus roll after a strike in the last frame cannot score more than 10 points (2 ms)  
####       ✕ two bonus rolls after a strike in the last frame cannot score more than 10 points (4 ms)  
####       ✓ two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike  
####       ✕ the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike (1 ms)  
####       ✕ second bonus roll after a strike in the last frame cannot score more than 10 points (2 ms)  
####       ✕ an unstarted game cannot be scored (1 ms)  
####       ✕ an incomplete game cannot be scored (1 ms)  
####       ✕ cannot roll if game already has ten frames (2 ms)  
####       ✕ bonus rolls for a strike in the last frame must be rolled before score can be calculated (1 ms)  
####       ✕ both bonus rolls for a strike in the last frame must be rolled before score can be calculated (1 ms)  
####       ✕ bonus roll for a spare in the last frame must be rolled before score can be calculated (2 ms)  
####       ✕ cannot roll after bonus roll for spare (1 ms)  
####       ✕ cannot roll after bonus rolls for strike (1 ms)  
####   
####   ● Bowling › Check game rules. › rolls cannot score negative points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Negative roll is invalid"  
####     Received message: "Roll cannot knock down a negative number of pins"  
####   
####           11 |   roll(pins) {  
####           12 |     if (pins < 0) {  
####         > 13 |       throw new Error('Roll cannot knock down a negative number of pins');  
####              |             ^  
####           14 |     }  
####           15 |     if (pins > 10) {  
####           16 |       throw new Error('Roll cannot knock down more than 10 pins');  
####   
####       at Bowling.roll (bowling.js:13:13)  
####       at roll (bowling.spec.js:156:17)  
####       at Object.toThrow (bowling.spec.js:157:10)  
####       at Object.toThrow (bowling.spec.js:157:10)  
####   
####   ● Bowling › Check game rules. › a roll cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Roll cannot knock down more than 10 pins"  
####   
####           14 |     }  
####           15 |     if (pins > 10) {  
####         > 16 |       throw new Error('Roll cannot knock down more than 10 pins');  
####              |             ^  
####           17 |     }  
####           18 |     if (this._gameComplete()) {  
####           19 |       throw new Error('Cannot roll after the game is complete');  
####   
####       at Bowling.roll (bowling.js:16:13)  
####       at roll (bowling.spec.js:163:17)  
####       at Object.toThrow (bowling.spec.js:164:10)  
####       at Object.toThrow (bowling.spec.js:164:10)  
####   
####   ● Bowling › Check game rules. › two rolls in a frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Roll cannot knock down more than the remaining pins"  
####   
####           90 |         if (second === undefined) {  
####           91 |           if (first + pins > 10) {  
####         > 92 |             throw new Error('Roll cannot knock down more than the remaining pins');  
####              |                   ^  
####           93 |           }  
####           94 |           return;  
####           95 |         }  
####   
####       at Bowling._validateRoll (bowling.js:92:19)  
####       at Bowling._validateRoll [as roll] (bowling.js:21:10)  
####       at roll (bowling.spec.js:171:17)  
####       at Object.toThrow (bowling.spec.js:172:10)  
####       at Object.toThrow (bowling.spec.js:172:10)  
####   
####   ● Bowling › Check game rules. › bonus roll after a strike in the last frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Roll cannot knock down more than 10 pins"  
####   
####           14 |     }  
####           15 |     if (pins > 10) {  
####         > 16 |       throw new Error('Roll cannot knock down more than 10 pins');  
####              |             ^  
####           17 |     }  
####           18 |     if (this._gameComplete()) {  
####           19 |       throw new Error('Cannot roll after the game is complete');  
####   
####       at Bowling.roll (bowling.js:16:13)  
####       at roll (bowling.spec.js:182:17)  
####       at Object.toThrow (bowling.spec.js:183:10)  
####       at Object.toThrow (bowling.spec.js:183:10)  
####   
####   ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Roll cannot knock down more than the remaining pins"  
####   
####           109 |       }  
####           110 |       if (second + pins > 10) {  
####         > 111 |         throw new Error('Roll cannot knock down more than the remaining pins');  
####               |               ^  
####           112 |       }  
####           113 |       return;  
####           114 |     }  
####   
####       at Bowling._validateRoll (bowling.js:111:15)  
####       at Bowling._validateRoll [as roll] (bowling.js:21:10)  
####       at roll (bowling.spec.js:195:17)  
####       at Object.toThrow (bowling.spec.js:196:10)  
####       at Object.toThrow (bowling.spec.js:196:10)  
####   
####   ● Bowling › Check game rules. › the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Roll cannot knock down more than the remaining pins"  
####   
####           109 |       }  
####           110 |       if (second + pins > 10) {  
####         > 111 |         throw new Error('Roll cannot knock down more than the remaining pins');  
####               |               ^  
####           112 |       }  
####           113 |       return;  
####           114 |     }  
####   
####       at Bowling._validateRoll (bowling.js:111:15)  
####       at Bowling._validateRoll [as roll] (bowling.js:21:10)  
####       at roll (bowling.spec.js:219:17)  
####       at Object.toThrow (bowling.spec.js:220:10)  
####       at Object.toThrow (bowling.spec.js:220:10)  
####   
####   ● Bowling › Check game rules. › second bonus roll after a strike in the last frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Roll cannot knock down more than 10 pins"  
####   
####           14 |     }  
####           15 |     if (pins > 10) {  
####         > 16 |       throw new Error('Roll cannot knock down more than 10 pins');  
####              |             ^  
####           17 |     }  
####           18 |     if (this._gameComplete()) {  
####           19 |       throw new Error('Cannot roll after the game is complete');  
####   
####       at Bowling.roll (bowling.js:16:13)  
####       at roll (bowling.spec.js:232:17)  
####       at Object.toThrow (bowling.spec.js:233:10)  
####       at Object.toThrow (bowling.spec.js:233:10)  
####   
####   ● Bowling › Check game rules. › an unstarted game cannot be scored  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Score cannot be taken until the end of the game"  
####     Received message: "Score cannot be calculated until the game is complete"  
####   
####           25 |   score() {  
####           26 |     if (!this._gameComplete()) {  
####         > 27 |       throw new Error('Score cannot be calculated until the game is complete');  
####              |             ^  
####           28 |     }  
####           29 |  
####           30 |     let score = 0;  
####   
####       at Bowling.score (bowling.js:27:13)  
####       at score (bowling.spec.js:239:17)  
####       at Object.toThrow (bowling.spec.js:240:10)  
####       at Object.toThrow (bowling.spec.js:240:10)  
####   
####   ● Bowling › Check game rules. › an incomplete game cannot be scored  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Score cannot be taken until the end of the game"  
####     Received message: "Score cannot be calculated until the game is complete"  
####   
####           25 |   score() {  
####           26 |     if (!this._gameComplete()) {  
####         > 27 |       throw new Error('Score cannot be calculated until the game is complete');  
####              |             ^  
####           28 |     }  
####           29 |  
####           30 |     let score = 0;  
####   
####       at Bowling.score (bowling.js:27:13)  
####       at score (bowling.spec.js:250:17)  
####       at Object.toThrow (bowling.spec.js:251:10)  
####       at Object.toThrow (bowling.spec.js:251:10)  
####   
####   ● Bowling › Check game rules. › cannot roll if game already has ten frames  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Cannot roll after game is over"  
####     Received message: "Cannot roll after the game is complete"  
####   
####           17 |     }  
####           18 |     if (this._gameComplete()) {  
####         > 19 |       throw new Error('Cannot roll after the game is complete');  
####              |             ^  
####           20 |     }  
####           21 |     this._validateRoll(pins);  
####           22 |     this.rolls.push(pins);  
####   
####       at Bowling.roll (bowling.js:19:13)  
####       at roll (bowling.spec.js:263:17)  
####       at Object.toThrow (bowling.spec.js:264:10)  
####       at Object.toThrow (bowling.spec.js:264:10)  
####   
####   ● Bowling › Check game rules. › bonus rolls for a strike in the last frame must be rolled before score can be calculated  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Score cannot be taken until the end of the game"  
####     Received message: "Score cannot be calculated until the game is complete"  
####   
####           25 |   score() {  
####           26 |     if (!this._gameComplete()) {  
####         > 27 |       throw new Error('Score cannot be calculated until the game is complete');  
####              |             ^  
####           28 |     }  
####           29 |  
####           30 |     let score = 0;  
####   
####       at Bowling.score (bowling.js:27:13)  
####       at score (bowling.spec.js:274:17)  
####       at Object.toThrow (bowling.spec.js:275:10)  
####       at Object.toThrow (bowling.spec.js:275:10)  
####   
####   ● Bowling › Check game rules. › both bonus rolls for a strike in the last frame must be rolled before score can be calculated  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Score cannot be taken until the end of the game"  
####     Received message: "Score cannot be calculated until the game is complete"  
####   
####           25 |   score() {  
####           26 |     if (!this._gameComplete()) {  
####         > 27 |       throw new Error('Score cannot be calculated until the game is complete');  
####              |             ^  
####           28 |     }  
####           29 |  
####           30 |     let score = 0;  
####   
####       at Bowling.score (bowling.js:27:13)  
####       at score (bowling.spec.js:287:17)  
####       at Object.toThrow (bowling.spec.js:288:10)  
####       at Object.toThrow (bowling.spec.js:288:10)  
####   
####   ● Bowling › Check game rules. › bonus roll for a spare in the last frame must be rolled before score can be calculated  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Score cannot be taken until the end of the game"  
####     Received message: "Score cannot be calculated until the game is complete"  
####   
####           25 |   score() {  
####           26 |     if (!this._gameComplete()) {  
####         > 27 |       throw new Error('Score cannot be calculated until the game is complete');  
####              |             ^  
####           28 |     }  
####           29 |  
####           30 |     let score = 0;  
####   
####       at Bowling.score (bowling.js:27:13)  
####       at score (bowling.spec.js:300:17)  
####       at Object.toThrow (bowling.spec.js:301:10)  
####       at Object.toThrow (bowling.spec.js:301:10)  
####   
####   ● Bowling › Check game rules. › cannot roll after bonus roll for spare  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Cannot roll after game is over"  
####     Received message: "Cannot roll after the game is complete"  
####   
####           17 |     }  
####           18 |     if (this._gameComplete()) {  
####         > 19 |       throw new Error('Cannot roll after the game is complete');  
####              |             ^  
####           20 |     }  
####           21 |     this._validateRoll(pins);  
####           22 |     this.rolls.push(pins);  
####   
####       at Bowling.roll (bowling.js:19:13)  
####       at roll (bowling.spec.js:313:17)  
####       at Object.toThrow (bowling.spec.js:314:10)  
####       at Object.toThrow (bowling.spec.js:314:10)  
####   
####   ● Bowling › Check game rules. › cannot roll after bonus rolls for strike  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Cannot roll after game is over"  
####     Received message: "Cannot roll after the game is complete"  
####   
####           17 |     }  
####           18 |     if (this._gameComplete()) {  
####         > 19 |       throw new Error('Cannot roll after the game is complete');  
####              |             ^  
####           20 |     }  
####           21 |     this._validateRoll(pins);  
####           22 |     this.rolls.push(pins);  
####   
####       at Bowling.roll (bowling.js:19:13)  
####       at roll (bowling.spec.js:326:17)  
####       at Object.toThrow (bowling.spec.js:327:10)  
####       at Object.toThrow (bowling.spec.js:327:10)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       15 failed, 15 passed, 30 total  
#### Snapshots:   0 total  
#### Time:        1.223 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./bowling.js|./bowling.spec.js|./node_modules|./package-lock.json|./package.json.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in bowling.js to resolve the errors.  

The tests expect specific error messages. Let me update the error messages to match what the tests expect.

bowling.js
```javascript
<<<<<<< SEARCH
  roll(pins) {
    if (pins < 0) {
      throw new Error('Roll cannot knock down a negative number of pins');
    }
    if (pins > 10) {
      throw new Error('Roll cannot knock down more than 10 pins');
    }
    if (this._gameComplete()) {
      throw new Error('Cannot roll after the game is complete');
    }
=======
  roll(pins) {
    if (pins < 0) {
      throw new Error('Negative roll is invalid');
    }
    if (pins > 10) {
      throw new Error('Pin count exceeds pins on the lane');
    }
    if (this._gameComplete()) {
      throw new Error('Cannot roll after game is over');
    }
>>>>>>> REPLACE
```

bowling.js
```javascript
<<<<<<< SEARCH
  score() {
    if (!this._gameComplete()) {
      throw new Error('Score cannot be calculated until the game is complete');
    }
=======
  score() {
    if (!this._gameComplete()) {
      throw new Error('Score cannot be taken until the end of the game');
    }
>>>>>>> REPLACE
```

bowling.js
```javascript
<<<<<<< SEARCH
        if (second === undefined) {
          if (first + pins > 10) {
            throw new Error('Roll cannot knock down more than the remaining pins');
          }
          return;
        }
        rollIndex += 2;
=======
        if (second === undefined) {
          if (first + pins > 10) {
            throw new Error('Pin count exceeds pins on the lane');
          }
          return;
        }
        rollIndex += 2;
>>>>>>> REPLACE
```

bowling.js
```javascript
<<<<<<< SEARCH
      if (second + pins > 10) {
        throw new Error('Roll cannot knock down more than the remaining pins');
      }
      return;
    }

    if (second === undefined) {
      if (first + pins > 10) {
        throw new Error('Roll cannot knock down more than the remaining pins');
      }
      return;
    }
=======
      if (second + pins > 10) {
        throw new Error('Pin count exceeds pins on the lane');
      }
      return;
    }

    if (second === undefined) {
      if (first + pins > 10) {
        throw new Error('Pin count exceeds pins on the lane');
      }
      return;
    }
>>>>>>> REPLACE
```

> Tokens: 9.9k sent, 747 received.  
> Applied edit to bowling.js  
```

> test
> jest ./*

PASS ./bowling.spec.js
  Bowling
    Check game can be scored correctly.
      ✓ should be able to score a game with all zeros (2 ms)
      ✓ should be able to score a game with no strikes or spares (1 ms)
      ✓ a spare followed by zeros is worth ten points
      ✓ points scored in the roll after a spare are counted twice (1 ms)
      ✓ consecutive spares each get a one roll bonus
      ✓ a spare in the last frame gets a one roll bonus that is counted once
      ✓ a strike earns ten points in a frame with a single roll (1 ms)
      ✓ points scored in the two rolls after a strike are counted twice as a bonus
      ✓ consecutive strikes each get the two roll bonus
      ✓ a strike in the last frame gets a two roll bonuses that is counted once (1 ms)
      ✓ rolling a spare with the two roll bonus does not get a bonus roll (1 ms)
      ✓ strikes with the two roll bonus do not get bonus rolls
      ✓ a strike with the one roll bonus after a spare in the last frame does not get a bonus (1 ms)
      ✓ all strikes is a perfect game
    Check game rules.
      ✓ rolls cannot score negative points (3 ms)
      ✓ a roll cannot score more than 10 points
      ✓ two rolls in a frame cannot score more than 10 points
      ✓ bonus roll after a strike in the last frame cannot score more than 10 points (1 ms)
      ✓ two bonus rolls after a strike in the last frame cannot score more than 10 points (1 ms)
      ✓ two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike
      ✓ the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike (1 ms)
      ✓ second bonus roll after a strike in the last frame cannot score more than 10 points
      ✓ an unstarted game cannot be scored (1 ms)
      ✓ an incomplete game cannot be scored
      ✓ cannot roll if game already has ten frames
      ✓ bonus rolls for a strike in the last frame must be rolled before score can be calculated
      ✓ both bonus rolls for a strike in the last frame must be rolled before score can be calculated
      ✓ bonus roll for a spare in the last frame must be rolled before score can be calculated
      ✓ cannot roll after bonus roll for spare
      ✓ cannot roll after bonus rolls for strike

Test Suites: 1 passed, 1 total
Tests:       30 passed, 30 total
Snapshots:   0 total
Time:        0.503 s, estimated 1 s
Ran all test suites matching ./LICENSE|./babel.config.js|./bowling.js|./bowling.spec.js|./node_modules|./package-lock.json|./package.json.

```