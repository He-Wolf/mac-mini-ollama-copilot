
# aider chat started at 2026-11-04 20:54:13

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-27b-agent with diff edit format, reasoning none  
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

To implement the bowling game logic, I will replace the skeleton `Bowling` class in `bowling.js` with a complete implementation.

The implementation will:
1.  Track the rolls in an array.
2.  Validate each roll (pins must be 0-10, and frame rules must be respected).
3.  Calculate the score by iterating through frames, applying strike/spare bonuses.
4.  Handle the special 10th frame rules.

Here is the *SEARCH/REPLACE* block for `bowling.js`:

bowling.js
```javascript
<<<<<<< SEARCH
//
// This is only a SKELETON file for the 'Bowling' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Bowling {
  roll() {
    throw new Error('Remove this statement and implement this function');
  }

  score() {
    throw new Error('Remove this statement and implement this function');
  }
}
=======
//
// This is only a SKELETON file for the 'Bowling' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Bowling {
  constructor() {
    this.rolls = [];
    this.frames = [];
    this.currentFrame = 0;
    this.currentFrameRolls = 0;
    this.currentFrameScore = 0;
    this.gameOver = false;
  }

  roll(pins) {
    if (this.gameOver) {
      throw new Error('Cannot roll after game is over');
    }
    if (pins < 0 || pins > 10) {
      throw new Error('Cannot roll negative pins');
    }
    if (this.currentFrameScore + pins > 10) {
      throw new Error('Cannot roll more than 10 pins');
    }

    this.rolls.push(pins);
    this.currentFrameScore += pins;
    this.currentFrameRolls++;

    if (this.currentFrame < 9) {
      if (this.currentFrameScore === 10) {
        this.frames.push(this.rolls.slice(-this.currentFrameRolls));
        this.currentFrame++;
        this.currentFrameRolls = 0;
        this.currentFrameScore = 0;
      }
    } else {
      // 10th frame
      if (this.currentFrameRolls === 1) {
        if (this.currentFrameScore === 10) {
          // Strike in 10th frame, get 2 more rolls
          this.currentFrameRolls = 0;
          this.currentFrameScore = 0;
        }
      } else if (this.currentFrameRolls === 2) {
        if (this.currentFrameScore === 10) {
          // Spare in 10th frame, get 1 more roll
          this.currentFrameRolls = 0;
          this.currentFrameScore = 0;
        } else {
          // Open frame in 10th frame, game over
          this.frames.push(this.rolls.slice(-2));
          this.gameOver = true;
        }
      } else {
        // 3rd roll in 10th frame (after strike or spare)
        this.frames.push(this.rolls.slice(-3));
        this.gameOver = true;
      }
    }
  }

  score() {
    if (!this.gameOver) {
      throw new Error('Score cannot be taken until the end of the game');
    }

    let totalScore = 0;
    let rollIndex = 0;

    for (let frame = 0; frame < 10; frame++) {
      if (this.rolls[rollIndex] === 10) {
        // Strike
        totalScore += 10 + this.rolls[rollIndex + 1] + this.rolls[rollIndex + 2];
        rollIndex += 1;
      } else if (this.rolls[rollIndex] + this.rolls[rollIndex + 1] === 10) {
        // Spare
        totalScore += 10 + this.rolls[rollIndex + 2];
        rollIndex += 2;
      } else {
        // Open frame
        totalScore += this.rolls[rollIndex] + this.rolls[rollIndex + 1];
        rollIndex += 2;
      }
    }

    return totalScore;
  }
}
>>>>>>> REPLACE
```

> Tokens: 2.7k sent, 1.0k received.  
> Applied edit to bowling.js  
```

> test
> jest ./*

FAIL ./bowling.spec.js
  Bowling
    Check game can be scored correctly.
      ✕ should be able to score a game with all zeros (2 ms)
      ✕ should be able to score a game with no strikes or spares (1 ms)
      ✕ a spare followed by zeros is worth ten points (1 ms)
      ✕ points scored in the roll after a spare are counted twice (1 ms)
      ✕ consecutive spares each get a one roll bonus
      ✕ a spare in the last frame gets a one roll bonus that is counted once
      ✕ a strike earns ten points in a frame with a single roll
      ✕ points scored in the two rolls after a strike are counted twice as a bonus (1 ms)
      ✕ consecutive strikes each get the two roll bonus (1 ms)
      ✕ a strike in the last frame gets a two roll bonuses that is counted once (1 ms)
      ✕ rolling a spare with the two roll bonus does not get a bonus roll (1 ms)
      ✕ strikes with the two roll bonus do not get bonus rolls
      ✕ a strike with the one roll bonus after a spare in the last frame does not get a bonus
      ✕ all strikes is a perfect game
    Check game rules.
      ✕ rolls cannot score negative points (13 ms)
      ✕ a roll cannot score more than 10 points (2 ms)
      ✕ two rolls in a frame cannot score more than 10 points (2 ms)
      ✕ bonus roll after a strike in the last frame cannot score more than 10 points (2 ms)
      ✕ two bonus rolls after a strike in the last frame cannot score more than 10 points (2 ms)
      ✕ two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike (1 ms)
      ✕ the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike (2 ms)
      ✕ second bonus roll after a strike in the last frame cannot score more than 10 points (3 ms)
      ✓ an unstarted game cannot be scored (1 ms)
      ✓ an incomplete game cannot be scored (1 ms)
      ✕ cannot roll if game already has ten frames
      ✓ bonus rolls for a strike in the last frame must be rolled before score can be calculated (1 ms)
      ✓ both bonus rolls for a strike in the last frame must be rolled before score can be calculated
      ✓ bonus roll for a spare in the last frame must be rolled before score can be calculated
      ✕ cannot roll after bonus roll for spare
      ✕ cannot roll after bonus rolls for strike

  ● Bowling › Check game can be scored correctly. › should be able to score a game with all zeros

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:13:22)

  ● Bowling › Check game can be scored correctly. › should be able to score a game with no strikes or spares

    Cannot roll more than 10 pins

      22 |     }
      23 |     if (this.currentFrameScore + pins > 10) {
    > 24 |       throw new Error('Cannot roll more than 10 pins');
         |             ^
      25 |     }
      26 |
      27 |     this.rolls.push(pins);

      at Bowling.roll (bowling.js:24:13)
      at roll (bowling.spec.js:22:17)
          at Array.forEach (<anonymous>)
      at Object.forEach (bowling.spec.js:21:13)

  ● Bowling › Check game can be scored correctly. › a spare followed by zeros is worth ten points

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:35:22)

  ● Bowling › Check game can be scored correctly. › points scored in the roll after a spare are counted twice

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:46:22)

  ● Bowling › Check game can be scored correctly. › consecutive spares each get a one roll bonus

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:57:22)

  ● Bowling › Check game can be scored correctly. › a spare in the last frame gets a one roll bonus that is counted once

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:68:22)

  ● Bowling › Check game can be scored correctly. › a strike earns ten points in a frame with a single roll

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:77:22)

  ● Bowling › Check game can be scored correctly. › points scored in the two rolls after a strike are counted twice as a bonus

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:86:22)

  ● Bowling › Check game can be scored correctly. › consecutive strikes each get the two roll bonus

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:95:22)

  ● Bowling › Check game can be scored correctly. › a strike in the last frame gets a two roll bonuses that is counted once

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:106:22)

  ● Bowling › Check game can be scored correctly. › rolling a spare with the two roll bonus does not get a bonus roll

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:117:22)

  ● Bowling › Check game can be scored correctly. › strikes with the two roll bonus do not get bonus rolls

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:128:22)

  ● Bowling › Check game can be scored correctly. › a strike with the one roll bonus after a spare in the last frame does not get a bonus

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:139:22)

  ● Bowling › Check game can be scored correctly. › all strikes is a perfect game

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:148:22)

  ● Bowling › Check game rules. › rolls cannot score negative points

    expect(received).toThrow(expected)

    Expected message: "Negative roll is invalid"
    Received message: "Cannot roll negative pins"

          19 |     }
          20 |     if (pins < 0 || pins > 10) {
        > 21 |       throw new Error('Cannot roll negative pins');
             |             ^
          22 |     }
          23 |     if (this.currentFrameScore + pins > 10) {
          24 |       throw new Error('Cannot roll more than 10 pins');

      at Bowling.roll (bowling.js:21:13)
      at roll (bowling.spec.js:156:17)
      at Object.toThrow (bowling.spec.js:157:10)
      at Object.toThrow (bowling.spec.js:157:10)

  ● Bowling › Check game rules. › a roll cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Cannot roll negative pins"

          19 |     }
          20 |     if (pins < 0 || pins > 10) {
        > 21 |       throw new Error('Cannot roll negative pins');
             |             ^
          22 |     }
          23 |     if (this.currentFrameScore + pins > 10) {
          24 |       throw new Error('Cannot roll more than 10 pins');

      at Bowling.roll (bowling.js:21:13)
      at roll (bowling.spec.js:163:17)
      at Object.toThrow (bowling.spec.js:164:10)
      at Object.toThrow (bowling.spec.js:164:10)

  ● Bowling › Check game rules. › two rolls in a frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Cannot roll more than 10 pins"

          22 |     }
          23 |     if (this.currentFrameScore + pins > 10) {
        > 24 |       throw new Error('Cannot roll more than 10 pins');
             |             ^
          25 |     }
          26 |
          27 |     this.rolls.push(pins);

      at Bowling.roll (bowling.js:24:13)
      at roll (bowling.spec.js:171:17)
      at Object.toThrow (bowling.spec.js:172:10)
      at Object.toThrow (bowling.spec.js:172:10)

  ● Bowling › Check game rules. › bonus roll after a strike in the last frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Cannot roll negative pins"

          19 |     }
          20 |     if (pins < 0 || pins > 10) {
        > 21 |       throw new Error('Cannot roll negative pins');
             |             ^
          22 |     }
          23 |     if (this.currentFrameScore + pins > 10) {
          24 |       throw new Error('Cannot roll more than 10 pins');

      at Bowling.roll (bowling.js:21:13)
      at roll (bowling.spec.js:182:17)
      at Object.toThrow (bowling.spec.js:183:10)
      at Object.toThrow (bowling.spec.js:183:10)

  ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Cannot roll more than 10 pins"

          22 |     }
          23 |     if (this.currentFrameScore + pins > 10) {
        > 24 |       throw new Error('Cannot roll more than 10 pins');
             |             ^
          25 |     }
          26 |
          27 |     this.rolls.push(pins);

      at Bowling.roll (bowling.js:24:13)
      at roll (bowling.spec.js:195:17)
      at Object.toThrow (bowling.spec.js:196:10)
      at Object.toThrow (bowling.spec.js:196:10)

  ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike

    Score cannot be taken until the end of the game

      64 |   score() {
      65 |     if (!this.gameOver) {
    > 66 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      67 |     }
      68 |
      69 |     let totalScore = 0;

      at Bowling.score (bowling.js:66:13)
      at Object.score (bowling.spec.js:207:22)

  ● Bowling › Check game rules. › the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Cannot roll more than 10 pins"

          22 |     }
          23 |     if (this.currentFrameScore + pins > 10) {
        > 24 |       throw new Error('Cannot roll more than 10 pins');
             |             ^
          25 |     }
          26 |
          27 |     this.rolls.push(pins);

      at Bowling.roll (bowling.js:24:13)
      at roll (bowling.spec.js:219:17)
      at Object.toThrow (bowling.spec.js:220:10)
      at Object.toThrow (bowling.spec.js:220:10)

  ● Bowling › Check game rules. › second bonus roll after a strike in the last frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"
    Received message: "Cannot roll negative pins"

          19 |     }
          20 |     if (pins < 0 || pins > 10) {
        > 21 |       throw new Error('Cannot roll negative pins');
             |             ^
          22 |     }
          23 |     if (this.currentFrameScore + pins > 10) {
          24 |       throw new Error('Cannot roll more than 10 pins');

      at Bowling.roll (bowling.js:21:13)
      at roll (bowling.spec.js:232:17)
      at Object.toThrow (bowling.spec.js:233:10)
      at Object.toThrow (bowling.spec.js:233:10)

  ● Bowling › Check game rules. › cannot roll if game already has ten frames

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"

    Received function did not throw

      262 |       expect(() => {
      263 |         bowling.roll(0);
    > 264 |       }).toThrow(new Error('Cannot roll after game is over'));
          |          ^
      265 |     });
      266 |
      267 |     test('bonus rolls for a strike in the last frame must be rolled before score can be calculated', () => {

      at Object.toThrow (bowling.spec.js:264:10)

  ● Bowling › Check game rules. › cannot roll after bonus roll for spare

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"

    Received function did not throw

      312 |       expect(() => {
      313 |         bowling.roll(2);
    > 314 |       }).toThrow(new Error('Cannot roll after game is over'));
          |          ^
      315 |     });
      316 |
      317 |     test('cannot roll after bonus rolls for strike', () => {

      at Object.toThrow (bowling.spec.js:314:10)

  ● Bowling › Check game rules. › cannot roll after bonus rolls for strike

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"

    Received function did not throw

      325 |       expect(() => {
      326 |         bowling.roll(2);
    > 327 |       }).toThrow(new Error('Cannot roll after game is over'));
          |          ^
      328 |     });
      329 |   });
      330 | });

      at Object.toThrow (bowling.spec.js:327:10)

Test Suites: 1 failed, 1 total
Tests:       25 failed, 5 passed, 30 total
Snapshots:   0 total
Time:        1.159 s
Ran all test suites matching ./LICENSE|./babel.config.js|./bowling.js|./bowling.spec.js|./node_modules|./package-lock.json|./package.json.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./bowling.spec.js  
####   Bowling  
####     Check game can be scored correctly.  
####       ✕ should be able to score a game with all zeros (2 ms)  
####       ✕ should be able to score a game with no strikes or spares (1 ms)  
####       ✕ a spare followed by zeros is worth ten points (1 ms)  
####       ✕ points scored in the roll after a spare are counted twice (1 ms)  
####       ✕ consecutive spares each get a one roll bonus  
####       ✕ a spare in the last frame gets a one roll bonus that is counted once  
####       ✕ a strike earns ten points in a frame with a single roll  
####       ✕ points scored in the two rolls after a strike are counted twice as a bonus (1 ms)  
####       ✕ consecutive strikes each get the two roll bonus (1 ms)  
####       ✕ a strike in the last frame gets a two roll bonuses that is counted once (1 ms)  
####       ✕ rolling a spare with the two roll bonus does not get a bonus roll (1 ms)  
####       ✕ strikes with the two roll bonus do not get bonus rolls  
####       ✕ a strike with the one roll bonus after a spare in the last frame does not get a bonus  
####       ✕ all strikes is a perfect game  
####     Check game rules.  
####       ✕ rolls cannot score negative points (13 ms)  
####       ✕ a roll cannot score more than 10 points (2 ms)  
####       ✕ two rolls in a frame cannot score more than 10 points (2 ms)  
####       ✕ bonus roll after a strike in the last frame cannot score more than 10 points (2 ms)  
####       ✕ two bonus rolls after a strike in the last frame cannot score more than 10 points (2 ms)  
####       ✕ two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike (1 ms)  
####       ✕ the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike (2 ms)  
####       ✕ second bonus roll after a strike in the last frame cannot score more than 10 points (3 ms)  
####       ✓ an unstarted game cannot be scored (1 ms)  
####       ✓ an incomplete game cannot be scored (1 ms)  
####       ✕ cannot roll if game already has ten frames  
####       ✓ bonus rolls for a strike in the last frame must be rolled before score can be calculated (1 ms)  
####       ✓ both bonus rolls for a strike in the last frame must be rolled before score can be calculated  
####       ✓ bonus roll for a spare in the last frame must be rolled before score can be calculated  
####       ✕ cannot roll after bonus roll for spare  
####       ✕ cannot roll after bonus rolls for strike  
####   
####   ● Bowling › Check game can be scored correctly. › should be able to score a game with all zeros  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:13:22)  
####   
####   ● Bowling › Check game can be scored correctly. › should be able to score a game with no strikes or spares  
####   
####     Cannot roll more than 10 pins  
####   
####       22 |     }  
####       23 |     if (this.currentFrameScore + pins > 10) {  
####     > 24 |       throw new Error('Cannot roll more than 10 pins');  
####          |             ^  
####       25 |     }  
####       26 |  
####       27 |     this.rolls.push(pins);  
####   
####       at Bowling.roll (bowling.js:24:13)  
####       at roll (bowling.spec.js:22:17)  
####           at Array.forEach (<anonymous>)  
####       at Object.forEach (bowling.spec.js:21:13)  
####   
####   ● Bowling › Check game can be scored correctly. › a spare followed by zeros is worth ten points  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:35:22)  
####   
####   ● Bowling › Check game can be scored correctly. › points scored in the roll after a spare are counted twice  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:46:22)  
####   
####   ● Bowling › Check game can be scored correctly. › consecutive spares each get a one roll bonus  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:57:22)  
####   
####   ● Bowling › Check game can be scored correctly. › a spare in the last frame gets a one roll bonus that is counted once  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:68:22)  
####   
####   ● Bowling › Check game can be scored correctly. › a strike earns ten points in a frame with a single roll  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:77:22)  
####   
####   ● Bowling › Check game can be scored correctly. › points scored in the two rolls after a strike are counted twice as a bonus  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:86:22)  
####   
####   ● Bowling › Check game can be scored correctly. › consecutive strikes each get the two roll bonus  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:95:22)  
####   
####   ● Bowling › Check game can be scored correctly. › a strike in the last frame gets a two roll bonuses that is counted once  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:106:22)  
####   
####   ● Bowling › Check game can be scored correctly. › rolling a spare with the two roll bonus does not get a bonus roll  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:117:22)  
####   
####   ● Bowling › Check game can be scored correctly. › strikes with the two roll bonus do not get bonus rolls  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:128:22)  
####   
####   ● Bowling › Check game can be scored correctly. › a strike with the one roll bonus after a spare in the last frame does not get a bonus  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:139:22)  
####   
####   ● Bowling › Check game can be scored correctly. › all strikes is a perfect game  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:148:22)  
####   
####   ● Bowling › Check game rules. › rolls cannot score negative points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Negative roll is invalid"  
####     Received message: "Cannot roll negative pins"  
####   
####           19 |     }  
####           20 |     if (pins < 0 || pins > 10) {  
####         > 21 |       throw new Error('Cannot roll negative pins');  
####              |             ^  
####           22 |     }  
####           23 |     if (this.currentFrameScore + pins > 10) {  
####           24 |       throw new Error('Cannot roll more than 10 pins');  
####   
####       at Bowling.roll (bowling.js:21:13)  
####       at roll (bowling.spec.js:156:17)  
####       at Object.toThrow (bowling.spec.js:157:10)  
####       at Object.toThrow (bowling.spec.js:157:10)  
####   
####   ● Bowling › Check game rules. › a roll cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Cannot roll negative pins"  
####   
####           19 |     }  
####           20 |     if (pins < 0 || pins > 10) {  
####         > 21 |       throw new Error('Cannot roll negative pins');  
####              |             ^  
####           22 |     }  
####           23 |     if (this.currentFrameScore + pins > 10) {  
####           24 |       throw new Error('Cannot roll more than 10 pins');  
####   
####       at Bowling.roll (bowling.js:21:13)  
####       at roll (bowling.spec.js:163:17)  
####       at Object.toThrow (bowling.spec.js:164:10)  
####       at Object.toThrow (bowling.spec.js:164:10)  
####   
####   ● Bowling › Check game rules. › two rolls in a frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Cannot roll more than 10 pins"  
####   
####           22 |     }  
####           23 |     if (this.currentFrameScore + pins > 10) {  
####         > 24 |       throw new Error('Cannot roll more than 10 pins');  
####              |             ^  
####           25 |     }  
####           26 |  
####           27 |     this.rolls.push(pins);  
####   
####       at Bowling.roll (bowling.js:24:13)  
####       at roll (bowling.spec.js:171:17)  
####       at Object.toThrow (bowling.spec.js:172:10)  
####       at Object.toThrow (bowling.spec.js:172:10)  
####   
####   ● Bowling › Check game rules. › bonus roll after a strike in the last frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Cannot roll negative pins"  
####   
####           19 |     }  
####           20 |     if (pins < 0 || pins > 10) {  
####         > 21 |       throw new Error('Cannot roll negative pins');  
####              |             ^  
####           22 |     }  
####           23 |     if (this.currentFrameScore + pins > 10) {  
####           24 |       throw new Error('Cannot roll more than 10 pins');  
####   
####       at Bowling.roll (bowling.js:21:13)  
####       at roll (bowling.spec.js:182:17)  
####       at Object.toThrow (bowling.spec.js:183:10)  
####       at Object.toThrow (bowling.spec.js:183:10)  
####   
####   ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Cannot roll more than 10 pins"  
####   
####           22 |     }  
####           23 |     if (this.currentFrameScore + pins > 10) {  
####         > 24 |       throw new Error('Cannot roll more than 10 pins');  
####              |             ^  
####           25 |     }  
####           26 |  
####           27 |     this.rolls.push(pins);  
####   
####       at Bowling.roll (bowling.js:24:13)  
####       at roll (bowling.spec.js:195:17)  
####       at Object.toThrow (bowling.spec.js:196:10)  
####       at Object.toThrow (bowling.spec.js:196:10)  
####   
####   ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike  
####   
####     Score cannot be taken until the end of the game  
####   
####       64 |   score() {  
####       65 |     if (!this.gameOver) {  
####     > 66 |       throw new Error('Score cannot be taken until the end of the game');  
####          |             ^  
####       67 |     }  
####       68 |  
####       69 |     let totalScore = 0;  
####   
####       at Bowling.score (bowling.js:66:13)  
####       at Object.score (bowling.spec.js:207:22)  
####   
####   ● Bowling › Check game rules. › the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Cannot roll more than 10 pins"  
####   
####           22 |     }  
####           23 |     if (this.currentFrameScore + pins > 10) {  
####         > 24 |       throw new Error('Cannot roll more than 10 pins');  
####              |             ^  
####           25 |     }  
####           26 |  
####           27 |     this.rolls.push(pins);  
####   
####       at Bowling.roll (bowling.js:24:13)  
####       at roll (bowling.spec.js:219:17)  
####       at Object.toThrow (bowling.spec.js:220:10)  
####       at Object.toThrow (bowling.spec.js:220:10)  
####   
####   ● Bowling › Check game rules. › second bonus roll after a strike in the last frame cannot score more than 10 points  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Pin count exceeds pins on the lane"  
####     Received message: "Cannot roll negative pins"  
####   
####           19 |     }  
####           20 |     if (pins < 0 || pins > 10) {  
####         > 21 |       throw new Error('Cannot roll negative pins');  
####              |             ^  
####           22 |     }  
####           23 |     if (this.currentFrameScore + pins > 10) {  
####           24 |       throw new Error('Cannot roll more than 10 pins');  
####   
####       at Bowling.roll (bowling.js:21:13)  
####       at roll (bowling.spec.js:232:17)  
####       at Object.toThrow (bowling.spec.js:233:10)  
####       at Object.toThrow (bowling.spec.js:233:10)  
####   
####   ● Bowling › Check game rules. › cannot roll if game already has ten frames  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Cannot roll after game is over"  
####   
####     Received function did not throw  
####   
####       262 |       expect(() => {  
####       263 |         bowling.roll(0);  
####     > 264 |       }).toThrow(new Error('Cannot roll after game is over'));  
####           |          ^  
####       265 |     });  
####       266 |  
####       267 |     test('bonus rolls for a strike in the last frame must be rolled before score can be calculated', () => {  
####   
####       at Object.toThrow (bowling.spec.js:264:10)  
####   
####   ● Bowling › Check game rules. › cannot roll after bonus roll for spare  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Cannot roll after game is over"  
####   
####     Received function did not throw  
####   
####       312 |       expect(() => {  
####       313 |         bowling.roll(2);  
####     > 314 |       }).toThrow(new Error('Cannot roll after game is over'));  
####           |          ^  
####       315 |     });  
####       316 |  
####       317 |     test('cannot roll after bonus rolls for strike', () => {  
####   
####       at Object.toThrow (bowling.spec.js:314:10)  
####   
####   ● Bowling › Check game rules. › cannot roll after bonus rolls for strike  
####   
####     expect(received).toThrow(expected)  
####   
####     Expected message: "Cannot roll after game is over"  
####   
####     Received function did not throw  
####   
####       325 |       expect(() => {  
####       326 |         bowling.roll(2);  
####     > 327 |       }).toThrow(new Error('Cannot roll after game is over'));  
####           |          ^  
####       328 |     });  
####       329 |   });  
####       330 | });  
####   
####       at Object.toThrow (bowling.spec.js:327:10)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       25 failed, 5 passed, 30 total  
#### Snapshots:   0 total  
#### Time:        1.159 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./bowling.js|./bowling.spec.js|./node_modules|./package-lock.json|./package.json.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in bowling.js to resolve the errors.  

To fix the failing tests, I need to rewrite the `Bowling` class in `bowling.js`. The current implementation has several issues:
1.  It doesn't correctly handle the 10th frame logic (bonus rolls).
2.  It uses incorrect error messages (e.g., "Cannot roll negative pins" instead of "Negative roll is invalid").
3.  It fails to mark the game as over in many scenarios, causing `score()` to throw "Score cannot be taken until the end of the game".
4.  It doesn't correctly validate pin counts in the 10th frame (e.g., allowing a strike after a non-strike bonus roll).

I will replace the entire class with a robust implementation that tracks frames and handles the 10th frame special cases correctly.

bowling.js
```javascript
<<<<<<< SEARCH
//
// This is only a SKELETON file for the 'Bowling' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Bowling {
  constructor() {
    this.rolls = [];
    this.frames = [];
    this.currentFrame = 0;
    this.currentFrameRolls = 0;
    this.currentFrameScore = 0;
    this.gameOver = false;
  }

  roll(pins) {
    if (this.gameOver) {
      throw new Error('Cannot roll after game is over');
    }
    if (pins < 0 || pins > 10) {
      throw new Error('Cannot roll negative pins');
    }
    if (this.currentFrameScore + pins > 10) {
      throw new Error('Cannot roll more than 10 pins');
    }

    this.rolls.push(pins);
    this.currentFrameScore += pins;
    this.currentFrameRolls++;

    if (this.currentFrame < 9) {
      if (this.currentFrameScore === 10) {
        this.frames.push(this.rolls.slice(-this.currentFrameRolls));
        this.currentFrame++;
        this.currentFrameRolls = 0;
        this.currentFrameScore = 0;
      }
    } else {
      // 10th frame
      if (this.currentFrameRolls === 1) {
        if (this.currentFrameScore === 10) {
          // Strike in 10th frame, get 2 more rolls
          this.currentFrameRolls = 0;
          this.currentFrameScore = 0;
        }
      } else if (this.currentFrameRolls === 2) {
        if (this.currentFrameScore === 10) {
          // Spare in 10th frame, get 1 more roll
          this.currentFrameRolls = 0;
          this.currentFrameScore = 0;
        } else {
          // Open frame in 10th frame, game over
          this.frames.push(this.rolls.slice(-2));
          this.gameOver = true;
        }
      } else {
        // 3rd roll in 10th frame (after strike or spare)
        this.frames.push(this.rolls.slice(-3));
        this.gameOver = true;
      }
    }
  }

  score() {
    if (!this.gameOver) {
      throw new Error('Score cannot be taken until the end of the game');
    }

    let totalScore = 0;
    let rollIndex = 0;

    for (let frame = 0; frame < 10; frame++) {
      if (this.rolls[rollIndex] === 10) {
        // Strike
        totalScore += 10 + this.rolls[rollIndex + 1] + this.rolls[rollIndex + 2];
        rollIndex += 1;
      } else if (this.rolls[rollIndex] + this.rolls[rollIndex + 1] === 10) {
        // Spare
        totalScore += 10 + this.rolls[rollIndex + 2];
        rollIndex += 2;
      } else {
        // Open frame
        totalScore += this.rolls[rollIndex] + this.rolls[rollIndex + 1];
        rollIndex += 2;
      }
    }

    return totalScore;
  }
}
=======
//
// This is only a SKELETON file for the 'Bowling' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Bowling {
  constructor() {
    this.rolls = [];
    this.frames = [];
    this.currentFrame = 0;
    this.currentFrameRolls = 0;
    this.currentFrameScore = 0;
    this.gameOver = false;
    this.tenthFrame = false;
    this.tenthFrameRolls = 0;
    this.tenthFrameScore = 0;
    this.tenthFrameStrike = false;
  }

  roll(pins) {
    if (this.gameOver) {
      throw new Error('Cannot roll after game is over');
    }
    if (pins < 0) {
      throw new Error('Negative roll is invalid');
    }
    if (pins > 10) {
      throw new Error('Pin count exceeds pins on the lane');
    }

    if (this.tenthFrame) {
      this.rolls.push(pins);
      this.tenthFrameScore += pins;
      this.tenthFrameRolls++;

      if (this.tenthFrameRolls === 1) {
        if (pins === 10) {
          this.tenthFrameStrike = true;
          this.tenthFrameScore = 0;
        }
      } else if (this.tenthFrameRolls === 2) {
        if (this.tenthFrameStrike) {
          this.tenthFrameScore = 0;
        } else if (this.tenthFrameScore === 10) {
          this.tenthFrameScore = 0;
        } else {
          this.gameOver = true;
        }
      } else {
        this.gameOver = true;
      }
    } else {
      this.rolls.push(pins);
      this.currentFrameScore += pins;
      this.currentFrameRolls++;

      if (this.currentFrameScore === 10) {
        this.frames.push(this.rolls.slice(-this.currentFrameRolls));
        this.currentFrame++;
        this.currentFrameRolls = 0;
        this.currentFrameScore = 0;

        if (this.currentFrame === 9) {
          this.tenthFrame = true;
        }
      }
    }
  }

  score() {
    if (!this.gameOver) {
      throw new Error('Score cannot be taken until the end of the game');
    }

    let totalScore = 0;
    let rollIndex = 0;

    for (let frame = 0; frame < 10; frame++) {
      if (this.rolls[rollIndex] === 10) {
        // Strike
        totalScore += 10 + this.rolls[rollIndex + 1] + this.rolls[rollIndex + 2];
        rollIndex += 1;
      } else if (this.rolls[rollIndex] + this.rolls[rollIndex + 1] === 10) {
        // Spare
        totalScore += 10 + this.rolls[rollIndex + 2];
        rollIndex += 2;
      } else {
        // Open frame
        totalScore += this.rolls[rollIndex] + this.rolls[rollIndex + 1];
        rollIndex += 2;
      }
    }

    return totalScore;
  }
}
>>>>>>> REPLACE
```

> Tokens: 9.5k sent, 1.8k received.  
> Applied edit to bowling.js  
```

> test
> jest ./*

FAIL ./bowling.spec.js
  Bowling
    Check game can be scored correctly.
      ✕ should be able to score a game with all zeros (2 ms)
      ✕ should be able to score a game with no strikes or spares (1 ms)
      ✕ a spare followed by zeros is worth ten points (1 ms)
      ✕ points scored in the roll after a spare are counted twice
      ✕ consecutive spares each get a one roll bonus
      ✕ a spare in the last frame gets a one roll bonus that is counted once (1 ms)
      ✕ a strike earns ten points in a frame with a single roll (1 ms)
      ✕ points scored in the two rolls after a strike are counted twice as a bonus (1 ms)
      ✕ consecutive strikes each get the two roll bonus
      ✕ a strike in the last frame gets a two roll bonuses that is counted once (1 ms)
      ✕ rolling a spare with the two roll bonus does not get a bonus roll (1 ms)
      ✕ strikes with the two roll bonus do not get bonus rolls
      ✕ a strike with the one roll bonus after a spare in the last frame does not get a bonus
      ✓ all strikes is a perfect game (1 ms)
    Check game rules.
      ✓ rolls cannot score negative points (2 ms)
      ✓ a roll cannot score more than 10 points (1 ms)
      ✕ two rolls in a frame cannot score more than 10 points (1 ms)
      ✓ bonus roll after a strike in the last frame cannot score more than 10 points
      ✕ two bonus rolls after a strike in the last frame cannot score more than 10 points (1 ms)
      ✕ two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike
      ✕ the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike
      ✓ second bonus roll after a strike in the last frame cannot score more than 10 points (1 ms)
      ✓ an unstarted game cannot be scored (1 ms)
      ✓ an incomplete game cannot be scored
      ✕ cannot roll if game already has ten frames (1 ms)
      ✓ bonus rolls for a strike in the last frame must be rolled before score can be calculated (1 ms)
      ✓ both bonus rolls for a strike in the last frame must be rolled before score can be calculated
      ✓ bonus roll for a spare in the last frame must be rolled before score can be calculated
      ✕ cannot roll after bonus roll for spare (1 ms)
      ✕ cannot roll after bonus rolls for strike (1 ms)

  ● Bowling › Check game can be scored correctly. › should be able to score a game with all zeros

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:13:22)

  ● Bowling › Check game can be scored correctly. › should be able to score a game with no strikes or spares

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:24:22)

  ● Bowling › Check game can be scored correctly. › a spare followed by zeros is worth ten points

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:35:22)

  ● Bowling › Check game can be scored correctly. › points scored in the roll after a spare are counted twice

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:46:22)

  ● Bowling › Check game can be scored correctly. › consecutive spares each get a one roll bonus

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:57:22)

  ● Bowling › Check game can be scored correctly. › a spare in the last frame gets a one roll bonus that is counted once

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:68:22)

  ● Bowling › Check game can be scored correctly. › a strike earns ten points in a frame with a single roll

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:77:22)

  ● Bowling › Check game can be scored correctly. › points scored in the two rolls after a strike are counted twice as a bonus

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:86:22)

  ● Bowling › Check game can be scored correctly. › consecutive strikes each get the two roll bonus

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:95:22)

  ● Bowling › Check game can be scored correctly. › a strike in the last frame gets a two roll bonuses that is counted once

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:106:22)

  ● Bowling › Check game can be scored correctly. › rolling a spare with the two roll bonus does not get a bonus roll

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:117:22)

  ● Bowling › Check game can be scored correctly. › strikes with the two roll bonus do not get bonus rolls

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:128:22)

  ● Bowling › Check game can be scored correctly. › a strike with the one roll bonus after a spare in the last frame does not get a bonus

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:139:22)

  ● Bowling › Check game rules. › two rolls in a frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"

    Received function did not throw

      170 |       expect(() => {
      171 |         bowling.roll(6);
    > 172 |       }).toThrow(new Error('Pin count exceeds pins on the lane'));
          |          ^
      173 |     });
      174 |
      175 |     test('bonus roll after a strike in the last frame cannot score more than 10 points', () => {

      at Object.toThrow (bowling.spec.js:172:10)

  ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame cannot score more than 10 points

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"

    Received function did not throw

      194 |       expect(() => {
      195 |         bowling.roll(6);
    > 196 |       }).toThrow(new Error('Pin count exceeds pins on the lane'));
          |          ^
      197 |     });
      198 |
      199 |     test('two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike', () => {

      at Object.toThrow (bowling.spec.js:196:10)

  ● Bowling › Check game rules. › two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike

    Score cannot be taken until the end of the game

      70 |   score() {
      71 |     if (!this.gameOver) {
    > 72 |       throw new Error('Score cannot be taken until the end of the game');
         |             ^
      73 |     }
      74 |
      75 |     let totalScore = 0;

      at Bowling.score (bowling.js:72:13)
      at Object.score (bowling.spec.js:207:22)

  ● Bowling › Check game rules. › the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike

    expect(received).toThrow(expected)

    Expected message: "Pin count exceeds pins on the lane"

    Received function did not throw

      218 |       expect(() => {
      219 |         bowling.roll(10);
    > 220 |       }).toThrow(new Error('Pin count exceeds pins on the lane'));
          |          ^
      221 |     });
      222 |
      223 |     test('second bonus roll after a strike in the last frame cannot score more than 10 points', () => {

      at Object.toThrow (bowling.spec.js:220:10)

  ● Bowling › Check game rules. › cannot roll if game already has ten frames

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"

    Received function did not throw

      262 |       expect(() => {
      263 |         bowling.roll(0);
    > 264 |       }).toThrow(new Error('Cannot roll after game is over'));
          |          ^
      265 |     });
      266 |
      267 |     test('bonus rolls for a strike in the last frame must be rolled before score can be calculated', () => {

      at Object.toThrow (bowling.spec.js:264:10)

  ● Bowling › Check game rules. › cannot roll after bonus roll for spare

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"

    Received function did not throw

      312 |       expect(() => {
      313 |         bowling.roll(2);
    > 314 |       }).toThrow(new Error('Cannot roll after game is over'));
          |          ^
      315 |     });
      316 |
      317 |     test('cannot roll after bonus rolls for strike', () => {

      at Object.toThrow (bowling.spec.js:314:10)

  ● Bowling › Check game rules. › cannot roll after bonus rolls for strike

    expect(received).toThrow(expected)

    Expected message: "Cannot roll after game is over"

    Received function did not throw

      325 |       expect(() => {
      326 |         bowling.roll(2);
    > 327 |       }).toThrow(new Error('Cannot roll after game is over'));
          |          ^
      328 |     });
      329 |   });
      330 | });

      at Object.toThrow (bowling.spec.js:327:10)

Test Suites: 1 failed, 1 total
Tests:       20 failed, 10 passed, 30 total
Snapshots:   0 total
Time:        1.096 s
Ran all test suites matching ./LICENSE|./babel.config.js|./bowling.js|./bowling.spec.js|./node_modules|./package-lock.json|./package.json.

```