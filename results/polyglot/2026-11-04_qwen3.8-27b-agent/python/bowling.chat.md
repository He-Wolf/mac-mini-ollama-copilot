
# aider chat started at 2026-11-04 18:44:23

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-27b-agent with diff edit format, reasoning none  
> Git repo: none  
> Repo-map: disabled  
> Added bowling.py to the chat.  

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
#### # Instructions append  
####   
#### ## Exception messages  
####   
#### Sometimes it is necessary to [raise an exception](https://docs.python.org/3/tutorial/errors.html#raising-exceptions). When you do this, you should always include a **meaningful error message** to indicate what the source of the error is. This makes your code more readable and helps significantly with debugging. For situations where you know that the error source will be a certain type, you can choose to raise one of the [built in error types](https://docs.python.org/3/library/exceptions.html#base-classes), but should still include a meaningful message.  
####   
#### This particular exercise requires that you use the [raise statement](https://docs.python.org/3/reference/simple_stmts.html#the-raise-statement) to "throw" an error when the scoring or playing rules are not followed. The tests will only pass if you both `raise` the `exception` and include a message with it.  
####   
#### To raise a `ValueError` with a message, write the message as an argument to the `exception` type:  
####   
#### ```python  
#### # example when a bonus is attempted with an open frame  
#### raise IndexError("cannot throw bonus with an open tenth frame")  
####   
#### # example when fill balls are invalid  
#### raise ValueError("invalid fill balls")  
#### ```  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: bowling.py  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

To implement the bowling game scoring logic, I will replace the contents of `bowling.py` with a complete implementation.

The implementation will:
1.  Track the rolls in a list.
2.  Validate each roll (0-10 pins, correct number of rolls per frame, valid 10th frame rules).
3.  Calculate the score by iterating through frames and applying strike/spare bonuses.
4.  Raise appropriate `ValueError` exceptions for invalid inputs or incomplete games.

Here is the *SEARCH/REPLACE* block for `bowling.py`:

bowling.py
```python
<<<<<<< SEARCH
class BowlingGame:
    def __init__(self):
        pass

    def roll(self, pins):
        pass

    def score(self):
        pass
=======
class BowlingGame:
    def __init__(self):
        self.rolls = []
        self.frame_scores = []
        self.current_frame = 0
        self.current_frame_rolls = []
        self.game_complete = False

    def roll(self, pins):
        if self.game_complete:
            raise ValueError("cannot roll after game is over")
        if pins < 0 or pins > 10:
            raise ValueError("pins must be between 0 and 10")

        self.rolls.append(pins)
        self.current_frame_rolls.append(pins)

        if self.current_frame < 9:
            if len(self.current_frame_rolls) == 1 and pins == 10:
                self._end_frame()
            elif len(self.current_frame_rolls) == 2:
                if sum(self.current_frame_rolls) > 10:
                    raise ValueError("invalid roll for frame")
                self._end_frame()
        else:
            self._handle_tenth_frame()

    def _end_frame(self):
        self.frame_scores.append(sum(self.current_frame_rolls))
        self.current_frame += 1
        self.current_frame_rolls = []

    def _handle_tenth_frame(self):
        rolls = self.current_frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                raise ValueError("invalid roll for tenth frame")
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
                    raise ValueError("invalid roll for tenth frame")
            else:
                raise ValueError("invalid roll for tenth frame")
        else:
            raise ValueError("invalid roll for tenth frame")

        if len(rolls) == 1 and rolls[0] < 10:
            self.game_complete = True
            self._end_frame()
        elif len(rolls) == 2:
            if rolls[0] < 10 and sum(rolls) < 10:
                self.game_complete = True
                self._end_frame()
            elif rolls[0] < 10 and sum(rolls) == 10:
                pass
            elif rolls[0] == 10 and rolls[1] < 10:
                pass
            elif rolls[0] == 10 and rolls[1] == 10:
                pass
        elif len(rolls) == 3:
            self.game_complete = True
            self._end_frame()

    def score(self):
        if not self.game_complete:
            raise ValueError("score cannot be taken until the end of the game")

        total = 0
        roll_index = 0

        for frame in range(10):
            if self.rolls[roll_index] == 10:
                if frame == 9:
                    total += sum(self.rolls[roll_index:])
                else:
                    total += 10 + self.rolls[roll_index + 1] + self.rolls[roll_index + 2]
                roll_index += 1
            elif sum(self.rolls[roll_index:roll_index + 2]) == 10:
                if frame == 9:
                    total += sum(self.rolls[roll_index:])
                else:
                    total += 10 + self.rolls[roll_index + 2]
                roll_index += 2
            else:
                total += sum(self.rolls[roll_index:roll_index + 2])
                roll_index += 2

        return total
>>>>>>> REPLACE
```

> Tokens: 3.0k sent, 1.1k received.  
> Applied edit to bowling.py  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: bowling
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 31 items

bowling_test.py .FFFFF....F..FFFFFFFF...FF.....                          [100%]

=================================== FAILURES ===================================
________ BowlingTest.test_a_spare_followed_by_zeros_is_worth_ten_points ________

self = <bowling_test.BowlingTest testMethod=test_a_spare_followed_by_zeros_is_worth_ten_points>

    def test_a_spare_followed_by_zeros_is_worth_ten_points(self):
        rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:31: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f02c9890>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
_ BowlingTest.test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once _

self = <bowling_test.BowlingTest testMethod=test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once>

    def test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:46: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96effd6010>, pins = 3

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
___ BowlingTest.test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll ___

self = <bowling_test.BowlingTest testMethod=test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll>

    def test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll(self):
        rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:51: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f0317d50>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
_ BowlingTest.test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once _

self = <bowling_test.BowlingTest testMethod=test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once>

    def test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:70: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:26: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96efffcad0>

    def _handle_tenth_frame(self):
        rolls = self.current_frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                raise ValueError("invalid roll for tenth frame")
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
>                   raise ValueError("invalid roll for tenth frame")
E                   ValueError: invalid roll for tenth frame

bowling.py:54: ValueError
_ BowlingTest.test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus _

self = <bowling_test.BowlingTest testMethod=test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus>

    def test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:92: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f02ca6d0>, pins = 3

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
_ BowlingTest.test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _

self = <bowling_test.BowlingTest testMethod=test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>

    def test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:195: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96effff0d0>, pins = 3

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
___________ BowlingTest.test_cannot_roll_after_bonus_roll_for_spare ____________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_roll_for_spare>

    def test_cannot_roll_after_bonus_roll_for_spare(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:201: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96efff9450>, pins = 3

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
__________ BowlingTest.test_cannot_roll_after_bonus_rolls_for_strike ___________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_rolls_for_strike>

    def test_cannot_roll_after_bonus_rolls_for_strike(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:207: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:26: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96effca050>

    def _handle_tenth_frame(self):
        rolls = self.current_frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                raise ValueError("invalid roll for tenth frame")
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
>                   raise ValueError("invalid roll for tenth frame")
E                   ValueError: invalid roll for tenth frame

bowling.py:54: ValueError
_________ BowlingTest.test_cannot_roll_if_game_already_has_ten_frames __________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_if_game_already_has_ten_frames>

    def test_cannot_roll_if_game_already_has_ten_frames(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:171: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f024d790>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
________ BowlingTest.test_consecutive_spares_each_get_a_one_roll_bonus _________

self = <bowling_test.BowlingTest testMethod=test_consecutive_spares_each_get_a_one_roll_bonus>

    def test_consecutive_spares_each_get_a_one_roll_bonus(self):
        rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:41: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f0001590>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
_______ BowlingTest.test_consecutive_strikes_each_get_the_two_roll_bonus _______

self = <bowling_test.BowlingTest testMethod=test_consecutive_strikes_each_get_the_two_roll_bonus>

    def test_consecutive_strikes_each_get_the_two_roll_bonus(self):
        rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:63: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f00112d0>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
_ BowlingTest.test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points _

self = <bowling_test.BowlingTest testMethod=test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points>

    def test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:85: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:26: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96efffead0>

    def _handle_tenth_frame(self):
        rolls = self.current_frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                raise ValueError("invalid roll for tenth frame")
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
>                   raise ValueError("invalid roll for tenth frame")
E                   ValueError: invalid roll for tenth frame

bowling.py:54: ValueError
__ BowlingTest.test_points_scored_in_the_roll_after_a_spare_are_counted_twice __

self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_roll_after_a_spare_are_counted_twice>

    def test_points_scored_in_the_roll_after_a_spare_are_counted_twice(self):
        rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:36: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f0018650>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
_ BowlingTest.test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus _

self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus>

    def test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus(
        self,
    ):
        rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:58: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96efffa950>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
________ BowlingTest.test_should_be_able_to_score_a_game_with_all_zeros ________

self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_all_zeros>

    def test_should_be_able_to_score_a_game_with_all_zeros(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:21: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96effcf210>, pins = 0

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
__ BowlingTest.test_should_be_able_to_score_a_game_with_no_strikes_or_spares ___

self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_no_strikes_or_spares>

    def test_should_be_able_to_score_a_game_with_no_strikes_or_spares(self):
        rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:26: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7f96f0013c10>, pins = 6

    def roll(self, pins):
        if self.game_complete:
>           raise ValueError("cannot roll after game is over")
E           ValueError: cannot roll after game is over

bowling.py:11: ValueError
=========================== short test summary info ============================
FAILED bowling_test.py::BowlingTest::test_a_spare_followed_by_zeros_is_worth_ten_points
FAILED bowling_test.py::BowlingTest::test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll
FAILED bowling_test.py::BowlingTest::test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus
FAILED bowling_test.py::BowlingTest::test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_roll_for_spare
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_rolls_for_strike
FAILED bowling_test.py::BowlingTest::test_cannot_roll_if_game_already_has_ten_frames
FAILED bowling_test.py::BowlingTest::test_consecutive_spares_each_get_a_one_roll_bonus
FAILED bowling_test.py::BowlingTest::test_consecutive_strikes_each_get_the_two_roll_bonus
FAILED bowling_test.py::BowlingTest::test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points
FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_roll_after_a_spare_are_counted_twice
FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus
FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_all_zeros
FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_no_strikes_or_spares
======================== 16 failed, 15 passed  =========================

```
#### ============================= test session starts ==============================  
#### platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0  
#### rootdir: bowling  
#### plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0  
#### collected 31 items  
####   
#### bowling_test.py .FFFFF....F..FFFFFFFF...FF.....                          [100%]  
####   
#### =================================== FAILURES ===================================  
#### ________ BowlingTest.test_a_spare_followed_by_zeros_is_worth_ten_points ________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_spare_followed_by_zeros_is_worth_ten_points>  
####   
####     def test_a_spare_followed_by_zeros_is_worth_ten_points(self):  
####         rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:31:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f02c9890>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### _ BowlingTest.test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once>  
####   
####     def test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:46:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96effd6010>, pins = 3  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### ___ BowlingTest.test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll ___  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll>  
####   
####     def test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll(self):  
####         rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:51:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f0317d50>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### _ BowlingTest.test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once>  
####   
####     def test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:70:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### bowling.py:26: in roll  
####     self._handle_tenth_frame()  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96efffcad0>  
####   
####     def _handle_tenth_frame(self):  
####         rolls = self.current_frame_rolls  
####         if len(rolls) == 1:  
####             if rolls[0] == 10:  
####                 pass  
####             else:  
####                 pass  
####         elif len(rolls) == 2:  
####             if rolls[0] == 10:  
####                 pass  
####             elif sum(rolls) == 10:  
####                 pass  
####             else:  
####                 raise ValueError("invalid roll for tenth frame")  
####         elif len(rolls) == 3:  
####             if rolls[0] == 10:  
####                 if rolls[1] == 10:  
####                     pass  
####                 elif sum(rolls[1:]) == 10:  
####                     pass  
####                 else:  
#### >                   raise ValueError("invalid roll for tenth frame")  
#### E                   ValueError: invalid roll for tenth frame  
####   
#### bowling.py:54: ValueError  
#### _ BowlingTest.test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus>  
####   
####     def test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:92:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f02ca6d0>, pins = 3  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### _ BowlingTest.test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>  
####   
####     def test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:195:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96effff0d0>, pins = 3  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### ___________ BowlingTest.test_cannot_roll_after_bonus_roll_for_spare ____________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_roll_for_spare>  
####   
####     def test_cannot_roll_after_bonus_roll_for_spare(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:201:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96efff9450>, pins = 3  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### __________ BowlingTest.test_cannot_roll_after_bonus_rolls_for_strike ___________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_rolls_for_strike>  
####   
####     def test_cannot_roll_after_bonus_rolls_for_strike(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:207:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### bowling.py:26: in roll  
####     self._handle_tenth_frame()  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96effca050>  
####   
####     def _handle_tenth_frame(self):  
####         rolls = self.current_frame_rolls  
####         if len(rolls) == 1:  
####             if rolls[0] == 10:  
####                 pass  
####             else:  
####                 pass  
####         elif len(rolls) == 2:  
####             if rolls[0] == 10:  
####                 pass  
####             elif sum(rolls) == 10:  
####                 pass  
####             else:  
####                 raise ValueError("invalid roll for tenth frame")  
####         elif len(rolls) == 3:  
####             if rolls[0] == 10:  
####                 if rolls[1] == 10:  
####                     pass  
####                 elif sum(rolls[1:]) == 10:  
####                     pass  
####                 else:  
#### >                   raise ValueError("invalid roll for tenth frame")  
#### E                   ValueError: invalid roll for tenth frame  
####   
#### bowling.py:54: ValueError  
#### _________ BowlingTest.test_cannot_roll_if_game_already_has_ten_frames __________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_cannot_roll_if_game_already_has_ten_frames>  
####   
####     def test_cannot_roll_if_game_already_has_ten_frames(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:171:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f024d790>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### ________ BowlingTest.test_consecutive_spares_each_get_a_one_roll_bonus _________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_consecutive_spares_each_get_a_one_roll_bonus>  
####   
####     def test_consecutive_spares_each_get_a_one_roll_bonus(self):  
####         rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:41:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f0001590>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### _______ BowlingTest.test_consecutive_strikes_each_get_the_two_roll_bonus _______  
####   
#### self = <bowling_test.BowlingTest testMethod=test_consecutive_strikes_each_get_the_two_roll_bonus>  
####   
####     def test_consecutive_strikes_each_get_the_two_roll_bonus(self):  
####         rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:63:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f00112d0>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### _ BowlingTest.test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points>  
####   
####     def test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:85:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### bowling.py:26: in roll  
####     self._handle_tenth_frame()  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96efffead0>  
####   
####     def _handle_tenth_frame(self):  
####         rolls = self.current_frame_rolls  
####         if len(rolls) == 1:  
####             if rolls[0] == 10:  
####                 pass  
####             else:  
####                 pass  
####         elif len(rolls) == 2:  
####             if rolls[0] == 10:  
####                 pass  
####             elif sum(rolls) == 10:  
####                 pass  
####             else:  
####                 raise ValueError("invalid roll for tenth frame")  
####         elif len(rolls) == 3:  
####             if rolls[0] == 10:  
####                 if rolls[1] == 10:  
####                     pass  
####                 elif sum(rolls[1:]) == 10:  
####                     pass  
####                 else:  
#### >                   raise ValueError("invalid roll for tenth frame")  
#### E                   ValueError: invalid roll for tenth frame  
####   
#### bowling.py:54: ValueError  
#### __ BowlingTest.test_points_scored_in_the_roll_after_a_spare_are_counted_twice __  
####   
#### self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_roll_after_a_spare_are_counted_twice>  
####   
####     def test_points_scored_in_the_roll_after_a_spare_are_counted_twice(self):  
####         rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:36:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f0018650>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### _ BowlingTest.test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus>  
####   
####     def test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus(  
####         self,  
####     ):  
####         rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:58:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96efffa950>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### ________ BowlingTest.test_should_be_able_to_score_a_game_with_all_zeros ________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_all_zeros>  
####   
####     def test_should_be_able_to_score_a_game_with_all_zeros(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:21:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96effcf210>, pins = 0  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### __ BowlingTest.test_should_be_able_to_score_a_game_with_no_strikes_or_spares ___  
####   
#### self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_no_strikes_or_spares>  
####   
####     def test_should_be_able_to_score_a_game_with_no_strikes_or_spares(self):  
####         rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]  
#### >       game = self.roll_new_game(rolls)  
####                ^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### bowling_test.py:26:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### bowling_test.py:16: in roll_new_game  
####     game.roll(roll)  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <bowling.BowlingGame object at 0x7f96f0013c10>, pins = 6  
####   
####     def roll(self, pins):  
####         if self.game_complete:  
#### >           raise ValueError("cannot roll after game is over")  
#### E           ValueError: cannot roll after game is over  
####   
#### bowling.py:11: ValueError  
#### =========================== short test summary info ============================  
#### FAILED bowling_test.py::BowlingTest::test_a_spare_followed_by_zeros_is_worth_ten_points  
#### FAILED bowling_test.py::BowlingTest::test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once  
#### FAILED bowling_test.py::BowlingTest::test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll  
#### FAILED bowling_test.py::BowlingTest::test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once  
#### FAILED bowling_test.py::BowlingTest::test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus  
#### FAILED bowling_test.py::BowlingTest::test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated  
#### FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_roll_for_spare  
#### FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_rolls_for_strike  
#### FAILED bowling_test.py::BowlingTest::test_cannot_roll_if_game_already_has_ten_frames  
#### FAILED bowling_test.py::BowlingTest::test_consecutive_spares_each_get_a_one_roll_bonus  
#### FAILED bowling_test.py::BowlingTest::test_consecutive_strikes_each_get_the_two_roll_bonus  
#### FAILED bowling_test.py::BowlingTest::test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points  
#### FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_roll_after_a_spare_are_counted_twice  
#### FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus  
#### FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_all_zeros  
#### FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_no_strikes_or_spares  
#### ======================== 16 failed, 15 passed  =========================  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in bowling.py to resolve the errors.  

To fix the bowling game logic, I will replace the contents of `bowling.py` with a cleaner implementation that correctly handles frame boundaries, the 10th frame bonus rolls, and scoring.

The current implementation has several issues:
1.  It marks the game as complete too early in the 10th frame (e.g., after a spare or strike without processing the bonus rolls).
2.  It raises "invalid roll" errors for valid bonus rolls in the 10th frame (e.g., `[10, 7, 1]` is valid, but the code rejects it).
3.  The scoring logic is fragile and doesn't handle the 10th frame bonuses correctly in all cases.

Here is the *SEARCH/REPLACE* block to fix `bowling.py`:

bowling.py
```python
<<<<<<< SEARCH
class BowlingGame:
    def __init__(self):
        self.rolls = []
        self.frame_scores = []
        self.current_frame = 0
        self.current_frame_rolls = []
        self.game_complete = False

    def roll(self, pins):
        if self.game_complete:
            raise ValueError("cannot roll after game is over")
        if pins < 0 or pins > 10:
            raise ValueError("pins must be between 0 and 10")

        self.rolls.append(pins)
        self.current_frame_rolls.append(pins)

        if self.current_frame < 9:
            if len(self.current_frame_rolls) == 1 and pins == 10:
                self._end_frame()
            elif len(self.current_frame_rolls) == 2:
                if sum(self.current_frame_rolls) > 10:
                    raise ValueError("invalid roll for frame")
                self._end_frame()
        else:
            self._handle_tenth_frame()

    def _end_frame(self):
        self.frame_scores.append(sum(self.current_frame_rolls))
        self.current_frame += 1
        self.current_frame_rolls = []

    def _handle_tenth_frame(self):
        rolls = self.current_frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                raise ValueError("invalid roll for tenth frame")
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
                    raise ValueError("invalid roll for tenth frame")
            else:
                raise ValueError("invalid roll for tenth frame")
        else:
            raise ValueError("invalid roll for tenth frame")

        if len(rolls) == 1 and rolls[0] < 10:
            self.game_complete = True
            self._end_frame()
        elif len(rolls) == 2:
            if rolls[0] < 10 and sum(rolls) < 10:
                self.game_complete = True
                self._end_frame()
            elif rolls[0] < 10 and sum(rolls) == 10:
                pass
            elif rolls[0] == 10 and rolls[1] < 10:
                pass
            elif rolls[0] == 10 and rolls[1] == 10:
                pass
        elif len(rolls) == 3:
            self.game_complete = True
            self._end_frame()

    def score(self):
        if not self.game_complete:
            raise ValueError("score cannot be taken until the end of the game")

        total = 0
        roll_index = 0

        for frame in range(10):
            if self.rolls[roll_index] == 10:
                if frame == 9:
                    total += sum(self.rolls[roll_index:])
                else:
                    total += 10 + self.rolls[roll_index + 1] + self.rolls[roll_index + 2]
                roll_index += 1
            elif sum(self.rolls[roll_index:roll_index + 2]) == 10:
                if frame == 9:
                    total += sum(self.rolls[roll_index:])
                else:
                    total += 10 + self.rolls[roll_index + 2]
                roll_index += 2
            else:
                total += sum(self.rolls[roll_index:roll_index + 2])
                roll_index += 2

        return total
=======
class BowlingGame:
    def __init__(self):
        self.rolls = []
        self.frame_rolls = []
        self.current_frame = 0
        self.game_complete = False

    def roll(self, pins):
        if self.game_complete:
            raise ValueError("cannot roll after game is over")
        if pins < 0 or pins > 10:
            raise ValueError("pins must be between 0 and 10")

        self.rolls.append(pins)
        self.frame_rolls.append(pins)

        if self.current_frame < 9:
            if pins == 10:
                self._end_frame()
            elif len(self.frame_rolls) == 2:
                if sum(self.frame_rolls) > 10:
                    raise ValueError("invalid roll for frame")
                self._end_frame()
        else:
            self._handle_tenth_frame()

    def _end_frame(self):
        self.current_frame += 1
        self.frame_rolls = []

    def _handle_tenth_frame(self):
        rolls = self.frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                self.game_complete = True
                self._end_frame()
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
                    raise ValueError("invalid roll for tenth frame")
            else:
                raise ValueError("invalid roll for tenth frame")
            self.game_complete = True
            self._end_frame()
        else:
            raise ValueError("invalid roll for tenth frame")

    def score(self):
        if not self.game_complete:
            raise ValueError("score cannot be taken until the end of the game")

        total = 0
        roll_index = 0

        for frame in range(10):
            if self.rolls[roll_index] == 10:
                if frame == 9:
                    total += sum(self.rolls[roll_index:])
                else:
                    total += 10 + self.rolls[roll_index + 1] + self.rolls[roll_index + 2]
                roll_index += 1
            elif sum(self.rolls[roll_index:roll_index + 2]) == 10:
                if frame == 9:
                    total += sum(self.rolls[roll_index:])
                else:
                    total += 10 + self.rolls[roll_index + 2]
                roll_index += 2
            else:
                total += sum(self.rolls[roll_index:roll_index + 2])
                roll_index += 2

        return total
>>>>>>> REPLACE
```

> Tokens: 11k sent, 1.7k received.  
> Applied edit to bowling.py  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: bowling
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 31 items

bowling_test.py ..F.FF.......FF...F............                          [100%]

=================================== FAILURES ===================================
_ BowlingTest.test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once _

self = <bowling_test.BowlingTest testMethod=test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once>

    def test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:46: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:25: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x74be5f301ed0>

    def _handle_tenth_frame(self):
        rolls = self.frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                self.game_complete = True
                self._end_frame()
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
                    raise ValueError("invalid roll for tenth frame")
            else:
>               raise ValueError("invalid roll for tenth frame")
E               ValueError: invalid roll for tenth frame

bowling.py:55: ValueError
_ BowlingTest.test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once _

self = <bowling_test.BowlingTest testMethod=test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once>

    def test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:70: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:25: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x74be5f301ad0>

    def _handle_tenth_frame(self):
        rolls = self.frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                self.game_complete = True
                self._end_frame()
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
>                   raise ValueError("invalid roll for tenth frame")
E                   ValueError: invalid roll for tenth frame

bowling.py:53: ValueError
_ BowlingTest.test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus _

self = <bowling_test.BowlingTest testMethod=test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus>

    def test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:92: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:25: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x74be5f320490>

    def _handle_tenth_frame(self):
        rolls = self.frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                self.game_complete = True
                self._end_frame()
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
                    raise ValueError("invalid roll for tenth frame")
            else:
>               raise ValueError("invalid roll for tenth frame")
E               ValueError: invalid roll for tenth frame

bowling.py:55: ValueError
___________ BowlingTest.test_cannot_roll_after_bonus_roll_for_spare ____________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_roll_for_spare>

    def test_cannot_roll_after_bonus_roll_for_spare(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:201: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:25: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x74be5f34d350>

    def _handle_tenth_frame(self):
        rolls = self.frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                self.game_complete = True
                self._end_frame()
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
                    raise ValueError("invalid roll for tenth frame")
            else:
>               raise ValueError("invalid roll for tenth frame")
E               ValueError: invalid roll for tenth frame

bowling.py:55: ValueError
__________ BowlingTest.test_cannot_roll_after_bonus_rolls_for_strike ___________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_rolls_for_strike>

    def test_cannot_roll_after_bonus_rolls_for_strike(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:207: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:25: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x74be5f2ed250>

    def _handle_tenth_frame(self):
        rolls = self.frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                self.game_complete = True
                self._end_frame()
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
>                   raise ValueError("invalid roll for tenth frame")
E                   ValueError: invalid roll for tenth frame

bowling.py:53: ValueError
_ BowlingTest.test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points _

self = <bowling_test.BowlingTest testMethod=test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points>

    def test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
>       game = self.roll_new_game(rolls)
               ^^^^^^^^^^^^^^^^^^^^^^^^^

bowling_test.py:85: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
bowling_test.py:16: in roll_new_game
    game.roll(roll)
bowling.py:25: in roll
    self._handle_tenth_frame()
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x74be5f5f6f90>

    def _handle_tenth_frame(self):
        rolls = self.frame_rolls
        if len(rolls) == 1:
            if rolls[0] == 10:
                pass
            else:
                pass
        elif len(rolls) == 2:
            if rolls[0] == 10:
                pass
            elif sum(rolls) == 10:
                pass
            else:
                self.game_complete = True
                self._end_frame()
        elif len(rolls) == 3:
            if rolls[0] == 10:
                if rolls[1] == 10:
                    pass
                elif sum(rolls[1:]) == 10:
                    pass
                else:
>                   raise ValueError("invalid roll for tenth frame")
E                   ValueError: invalid roll for tenth frame

bowling.py:53: ValueError
=========================== short test summary info ============================
FAILED bowling_test.py::BowlingTest::test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_roll_for_spare
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_rolls_for_strike
FAILED bowling_test.py::BowlingTest::test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points
========================= 6 failed, 25 passed  =========================

```