
# aider chat started at 2026-11-04 12:11:29

> Aider v0.86.3.dev+less  
> Model: ollama_chat/ornith-1.5-agent with diff edit format  
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
> Tokens: 3.0k sent, 16k received.  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: bowling
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 31 items

bowling_test.py FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF                          [100%]

=================================== FAILURES ===================================
___________ BowlingTest.test_a_roll_cannot_score_more_than_10_points ___________

self = <bowling_test.BowlingTest testMethod=test_a_roll_cannot_score_more_than_10_points>

    def test_a_roll_cannot_score_more_than_10_points(self):
        rolls = []
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:109: AssertionError
________ BowlingTest.test_a_spare_followed_by_zeros_is_worth_ten_points ________

self = <bowling_test.BowlingTest testMethod=test_a_spare_followed_by_zeros_is_worth_ten_points>

    def test_a_spare_followed_by_zeros_is_worth_ten_points(self):
        rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 10)
E       AssertionError: None != 10

bowling_test.py:32: AssertionError
_ BowlingTest.test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once _

self = <bowling_test.BowlingTest testMethod=test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once>

    def test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 17)
E       AssertionError: None != 17

bowling_test.py:47: AssertionError
___ BowlingTest.test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll ___

self = <bowling_test.BowlingTest testMethod=test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll>

    def test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll(self):
        rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 10)
E       AssertionError: None != 10

bowling_test.py:52: AssertionError
_ BowlingTest.test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once _

self = <bowling_test.BowlingTest testMethod=test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once>

    def test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 18)
E       AssertionError: None != 18

bowling_test.py:71: AssertionError
_ BowlingTest.test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus _

self = <bowling_test.BowlingTest testMethod=test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus>

    def test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 20)
E       AssertionError: None != 20

bowling_test.py:93: AssertionError
________________ BowlingTest.test_all_strikes_is_a_perfect_game ________________

self = <bowling_test.BowlingTest testMethod=test_all_strikes_is_a_perfect_game>

    def test_all_strikes_is_a_perfect_game(self):
        rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 300)
E       AssertionError: None != 300

bowling_test.py:98: AssertionError
_____________ BowlingTest.test_an_incomplete_game_cannot_be_scored _____________

self = <bowling_test.BowlingTest testMethod=test_an_incomplete_game_cannot_be_scored>

    def test_an_incomplete_game_cannot_be_scored(self):
        rolls = [0, 0]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:166: AssertionError
_____________ BowlingTest.test_an_unstarted_game_cannot_be_scored ______________

self = <bowling_test.BowlingTest testMethod=test_an_unstarted_game_cannot_be_scored>

    def test_an_unstarted_game_cannot_be_scored(self):
        rolls = []
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:160: AssertionError
_ BowlingTest.test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points _

self = <bowling_test.BowlingTest testMethod=test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points>

    def test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:123: AssertionError
_ BowlingTest.test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _

self = <bowling_test.BowlingTest testMethod=test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>

    def test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:196: AssertionError
_ BowlingTest.test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _

self = <bowling_test.BowlingTest testMethod=test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>

    def test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:180: AssertionError
_ BowlingTest.test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _

self = <bowling_test.BowlingTest testMethod=test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>

    def test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:188: AssertionError
___________ BowlingTest.test_cannot_roll_after_bonus_roll_for_spare ____________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_roll_for_spare>

    def test_cannot_roll_after_bonus_roll_for_spare(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:202: AssertionError
__________ BowlingTest.test_cannot_roll_after_bonus_rolls_for_strike ___________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_rolls_for_strike>

    def test_cannot_roll_after_bonus_rolls_for_strike(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:208: AssertionError
_________ BowlingTest.test_cannot_roll_if_game_already_has_ten_frames __________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_if_game_already_has_ten_frames>

    def test_cannot_roll_if_game_already_has_ten_frames(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:172: AssertionError
________ BowlingTest.test_consecutive_spares_each_get_a_one_roll_bonus _________

self = <bowling_test.BowlingTest testMethod=test_consecutive_spares_each_get_a_one_roll_bonus>

    def test_consecutive_spares_each_get_a_one_roll_bonus(self):
        rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 31)
E       AssertionError: None != 31

bowling_test.py:42: AssertionError
_______ BowlingTest.test_consecutive_strikes_each_get_the_two_roll_bonus _______

self = <bowling_test.BowlingTest testMethod=test_consecutive_strikes_each_get_the_two_roll_bonus>

    def test_consecutive_strikes_each_get_the_two_roll_bonus(self):
        rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 81)
E       AssertionError: None != 81

bowling_test.py:64: AssertionError
_ BowlingTest.test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points _

self = <bowling_test.BowlingTest testMethod=test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points>

    def test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 31)
E       AssertionError: None != 31

bowling_test.py:86: AssertionError
__ BowlingTest.test_points_scored_in_the_roll_after_a_spare_are_counted_twice __

self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_roll_after_a_spare_are_counted_twice>

    def test_points_scored_in_the_roll_after_a_spare_are_counted_twice(self):
        rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 16)
E       AssertionError: None != 16

bowling_test.py:37: AssertionError
_ BowlingTest.test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus _

self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus>

    def test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus(
        self,
    ):
        rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 26)
E       AssertionError: None != 26

bowling_test.py:59: AssertionError
_ BowlingTest.test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll _

self = <bowling_test.BowlingTest testMethod=test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll>

    def test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 20)
E       AssertionError: None != 20

bowling_test.py:76: AssertionError
_____________ BowlingTest.test_rolls_cannot_score_negative_points ______________

self = <bowling_test.BowlingTest testMethod=test_rolls_cannot_score_negative_points>

    def test_rolls_cannot_score_negative_points(self):
        rolls = []
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:103: AssertionError
_ BowlingTest.test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points _

self = <bowling_test.BowlingTest testMethod=test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points>

    def test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:154: AssertionError
________ BowlingTest.test_should_be_able_to_score_a_game_with_all_zeros ________

self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_all_zeros>

    def test_should_be_able_to_score_a_game_with_all_zeros(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 0)
E       AssertionError: None != 0

bowling_test.py:22: AssertionError
__ BowlingTest.test_should_be_able_to_score_a_game_with_no_strikes_or_spares ___

self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_no_strikes_or_spares>

    def test_should_be_able_to_score_a_game_with_no_strikes_or_spares(self):
        rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 90)
E       AssertionError: None != 90

bowling_test.py:27: AssertionError
___ BowlingTest.test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls ____

self = <bowling_test.BowlingTest testMethod=test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls>

    def test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 30)
E       AssertionError: None != 30

bowling_test.py:81: AssertionError
_ BowlingTest.test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike _

self = <bowling_test.BowlingTest testMethod=test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike>

    def test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:146: AssertionError
_ BowlingTest.test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike _

self = <bowling_test.BowlingTest testMethod=test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike>

    def test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 26)
E       AssertionError: None != 26

bowling_test.py:139: AssertionError
_ BowlingTest.test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points _

self = <bowling_test.BowlingTest testMethod=test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points>

    def test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:131: AssertionError
____ BowlingTest.test_two_rolls_in_a_frame_cannot_score_more_than_10_points ____

self = <bowling_test.BowlingTest testMethod=test_two_rolls_in_a_frame_cannot_score_more_than_10_points>

    def test_two_rolls_in_a_frame_cannot_score_more_than_10_points(self):
        rolls = [5]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:115: AssertionError
=========================== short test summary info ============================
FAILED bowling_test.py::BowlingTest::test_a_roll_cannot_score_more_than_10_points
FAILED bowling_test.py::BowlingTest::test_a_spare_followed_by_zeros_is_worth_ten_points
FAILED bowling_test.py::BowlingTest::test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll
FAILED bowling_test.py::BowlingTest::test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus
FAILED bowling_test.py::BowlingTest::test_all_strikes_is_a_perfect_game - Ass...
FAILED bowling_test.py::BowlingTest::test_an_incomplete_game_cannot_be_scored
FAILED bowling_test.py::BowlingTest::test_an_unstarted_game_cannot_be_scored
FAILED bowling_test.py::BowlingTest::test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points
FAILED bowling_test.py::BowlingTest::test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated
FAILED bowling_test.py::BowlingTest::test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated
FAILED bowling_test.py::BowlingTest::test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_roll_for_spare
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_rolls_for_strike
FAILED bowling_test.py::BowlingTest::test_cannot_roll_if_game_already_has_ten_frames
FAILED bowling_test.py::BowlingTest::test_consecutive_spares_each_get_a_one_roll_bonus
FAILED bowling_test.py::BowlingTest::test_consecutive_strikes_each_get_the_two_roll_bonus
FAILED bowling_test.py::BowlingTest::test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points
FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_roll_after_a_spare_are_counted_twice
FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus
FAILED bowling_test.py::BowlingTest::test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll
FAILED bowling_test.py::BowlingTest::test_rolls_cannot_score_negative_points
FAILED bowling_test.py::BowlingTest::test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points
FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_all_zeros
FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_no_strikes_or_spares
FAILED bowling_test.py::BowlingTest::test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls
FAILED bowling_test.py::BowlingTest::test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike
FAILED bowling_test.py::BowlingTest::test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike
FAILED bowling_test.py::BowlingTest::test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points
FAILED bowling_test.py::BowlingTest::test_two_rolls_in_a_frame_cannot_score_more_than_10_points
============================== 31 failed  ==============================

```
#### ============================= test session starts ==============================  
#### platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0  
#### rootdir: bowling  
#### plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0  
#### collected 31 items  
####   
#### bowling_test.py FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF                          [100%]  
####   
#### =================================== FAILURES ===================================  
#### ___________ BowlingTest.test_a_roll_cannot_score_more_than_10_points ___________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_roll_cannot_score_more_than_10_points>  
####   
####     def test_a_roll_cannot_score_more_than_10_points(self):  
####         rolls = []  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:109: AssertionError  
#### ________ BowlingTest.test_a_spare_followed_by_zeros_is_worth_ten_points ________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_spare_followed_by_zeros_is_worth_ten_points>  
####   
####     def test_a_spare_followed_by_zeros_is_worth_ten_points(self):  
####         rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 10)  
#### E       AssertionError: None != 10  
####   
#### bowling_test.py:32: AssertionError  
#### _ BowlingTest.test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once>  
####   
####     def test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 17)  
#### E       AssertionError: None != 17  
####   
#### bowling_test.py:47: AssertionError  
#### ___ BowlingTest.test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll ___  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll>  
####   
####     def test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll(self):  
####         rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 10)  
#### E       AssertionError: None != 10  
####   
#### bowling_test.py:52: AssertionError  
#### _ BowlingTest.test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once>  
####   
####     def test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 18)  
#### E       AssertionError: None != 18  
####   
#### bowling_test.py:71: AssertionError  
#### _ BowlingTest.test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus>  
####   
####     def test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 20)  
#### E       AssertionError: None != 20  
####   
#### bowling_test.py:93: AssertionError  
#### ________________ BowlingTest.test_all_strikes_is_a_perfect_game ________________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_all_strikes_is_a_perfect_game>  
####   
####     def test_all_strikes_is_a_perfect_game(self):  
####         rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 300)  
#### E       AssertionError: None != 300  
####   
#### bowling_test.py:98: AssertionError  
#### _____________ BowlingTest.test_an_incomplete_game_cannot_be_scored _____________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_an_incomplete_game_cannot_be_scored>  
####   
####     def test_an_incomplete_game_cannot_be_scored(self):  
####         rolls = [0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:166: AssertionError  
#### _____________ BowlingTest.test_an_unstarted_game_cannot_be_scored ______________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_an_unstarted_game_cannot_be_scored>  
####   
####     def test_an_unstarted_game_cannot_be_scored(self):  
####         rolls = []  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:160: AssertionError  
#### _ BowlingTest.test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points>  
####   
####     def test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:123: AssertionError  
#### _ BowlingTest.test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>  
####   
####     def test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:196: AssertionError  
#### _ BowlingTest.test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>  
####   
####     def test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:180: AssertionError  
#### _ BowlingTest.test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated>  
####   
####     def test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:188: AssertionError  
#### ___________ BowlingTest.test_cannot_roll_after_bonus_roll_for_spare ____________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_roll_for_spare>  
####   
####     def test_cannot_roll_after_bonus_roll_for_spare(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:202: AssertionError  
#### __________ BowlingTest.test_cannot_roll_after_bonus_rolls_for_strike ___________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_rolls_for_strike>  
####   
####     def test_cannot_roll_after_bonus_rolls_for_strike(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:208: AssertionError  
#### _________ BowlingTest.test_cannot_roll_if_game_already_has_ten_frames __________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_cannot_roll_if_game_already_has_ten_frames>  
####   
####     def test_cannot_roll_if_game_already_has_ten_frames(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:172: AssertionError  
#### ________ BowlingTest.test_consecutive_spares_each_get_a_one_roll_bonus _________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_consecutive_spares_each_get_a_one_roll_bonus>  
####   
####     def test_consecutive_spares_each_get_a_one_roll_bonus(self):  
####         rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 31)  
#### E       AssertionError: None != 31  
####   
#### bowling_test.py:42: AssertionError  
#### _______ BowlingTest.test_consecutive_strikes_each_get_the_two_roll_bonus _______  
####   
#### self = <bowling_test.BowlingTest testMethod=test_consecutive_strikes_each_get_the_two_roll_bonus>  
####   
####     def test_consecutive_strikes_each_get_the_two_roll_bonus(self):  
####         rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 81)  
#### E       AssertionError: None != 81  
####   
#### bowling_test.py:64: AssertionError  
#### _ BowlingTest.test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points>  
####   
####     def test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 31)  
#### E       AssertionError: None != 31  
####   
#### bowling_test.py:86: AssertionError  
#### __ BowlingTest.test_points_scored_in_the_roll_after_a_spare_are_counted_twice __  
####   
#### self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_roll_after_a_spare_are_counted_twice>  
####   
####     def test_points_scored_in_the_roll_after_a_spare_are_counted_twice(self):  
####         rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 16)  
#### E       AssertionError: None != 16  
####   
#### bowling_test.py:37: AssertionError  
#### _ BowlingTest.test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus>  
####   
####     def test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus(  
####         self,  
####     ):  
####         rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 26)  
#### E       AssertionError: None != 26  
####   
#### bowling_test.py:59: AssertionError  
#### _ BowlingTest.test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll>  
####   
####     def test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 20)  
#### E       AssertionError: None != 20  
####   
#### bowling_test.py:76: AssertionError  
#### _____________ BowlingTest.test_rolls_cannot_score_negative_points ______________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_rolls_cannot_score_negative_points>  
####   
####     def test_rolls_cannot_score_negative_points(self):  
####         rolls = []  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:103: AssertionError  
#### _ BowlingTest.test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points>  
####   
####     def test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:154: AssertionError  
#### ________ BowlingTest.test_should_be_able_to_score_a_game_with_all_zeros ________  
####   
#### self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_all_zeros>  
####   
####     def test_should_be_able_to_score_a_game_with_all_zeros(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 0)  
#### E       AssertionError: None != 0  
####   
#### bowling_test.py:22: AssertionError  
#### __ BowlingTest.test_should_be_able_to_score_a_game_with_no_strikes_or_spares ___  
####   
#### self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_no_strikes_or_spares>  
####   
####     def test_should_be_able_to_score_a_game_with_no_strikes_or_spares(self):  
####         rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 90)  
#### E       AssertionError: None != 90  
####   
#### bowling_test.py:27: AssertionError  
#### ___ BowlingTest.test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls ____  
####   
#### self = <bowling_test.BowlingTest testMethod=test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls>  
####   
####     def test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls(self):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 30)  
#### E       AssertionError: None != 30  
####   
#### bowling_test.py:81: AssertionError  
#### _ BowlingTest.test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike>  
####   
####     def test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:146: AssertionError  
#### _ BowlingTest.test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike>  
####   
####     def test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]  
####         game = self.roll_new_game(rolls)  
#### >       self.assertEqual(game.score(), 26)  
#### E       AssertionError: None != 26  
####   
#### bowling_test.py:139: AssertionError  
#### _ BowlingTest.test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points _  
####   
#### self = <bowling_test.BowlingTest testMethod=test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points>  
####   
####     def test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points(  
####         self,  
####     ):  
####         rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:131: AssertionError  
#### ____ BowlingTest.test_two_rolls_in_a_frame_cannot_score_more_than_10_points ____  
####   
#### self = <bowling_test.BowlingTest testMethod=test_two_rolls_in_a_frame_cannot_score_more_than_10_points>  
####   
####     def test_two_rolls_in_a_frame_cannot_score_more_than_10_points(self):  
####         rolls = [5]  
####         game = self.roll_new_game(rolls)  
#### >       with self.assertRaisesWithMessage(Exception):  
#### E       AssertionError: Exception not raised  
####   
#### bowling_test.py:115: AssertionError  
#### =========================== short test summary info ============================  
#### FAILED bowling_test.py::BowlingTest::test_a_roll_cannot_score_more_than_10_points  
#### FAILED bowling_test.py::BowlingTest::test_a_spare_followed_by_zeros_is_worth_ten_points  
#### FAILED bowling_test.py::BowlingTest::test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once  
#### FAILED bowling_test.py::BowlingTest::test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll  
#### FAILED bowling_test.py::BowlingTest::test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once  
#### FAILED bowling_test.py::BowlingTest::test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus  
#### FAILED bowling_test.py::BowlingTest::test_all_strikes_is_a_perfect_game - Ass...  
#### FAILED bowling_test.py::BowlingTest::test_an_incomplete_game_cannot_be_scored  
#### FAILED bowling_test.py::BowlingTest::test_an_unstarted_game_cannot_be_scored  
#### FAILED bowling_test.py::BowlingTest::test_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points  
#### FAILED bowling_test.py::BowlingTest::test_bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated  
#### FAILED bowling_test.py::BowlingTest::test_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated  
#### FAILED bowling_test.py::BowlingTest::test_both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated  
#### FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_roll_for_spare  
#### FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_rolls_for_strike  
#### FAILED bowling_test.py::BowlingTest::test_cannot_roll_if_game_already_has_ten_frames  
#### FAILED bowling_test.py::BowlingTest::test_consecutive_spares_each_get_a_one_roll_bonus  
#### FAILED bowling_test.py::BowlingTest::test_consecutive_strikes_each_get_the_two_roll_bonus  
#### FAILED bowling_test.py::BowlingTest::test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points  
#### FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_roll_after_a_spare_are_counted_twice  
#### FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus  
#### FAILED bowling_test.py::BowlingTest::test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll  
#### FAILED bowling_test.py::BowlingTest::test_rolls_cannot_score_negative_points  
#### FAILED bowling_test.py::BowlingTest::test_second_bonus_roll_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points  
#### FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_all_zeros  
#### FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_no_strikes_or_spares  
#### FAILED bowling_test.py::BowlingTest::test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls  
#### FAILED bowling_test.py::BowlingTest::test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike  
#### FAILED bowling_test.py::BowlingTest::test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike  
#### FAILED bowling_test.py::BowlingTest::test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points  
#### FAILED bowling_test.py::BowlingTest::test_two_rolls_in_a_frame_cannot_score_more_than_10_points  
#### ============================== 31 failed  ==============================  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in bowling.py to resolve the errors.  

I'll implement the full BowlingGame class to track rolls, validate them, and compute scores according to bowling rules.

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
        self._rolls = []

    def roll(self, pins):
        if pins < 0:
            raise ValueError("rolls cannot score negative points")
        if pins > 10:
            raise ValueError("a roll cannot score more than 10 points")

        if self._is_game_over():
            raise ValueError("cannot roll after game is done")

        self._rolls.append(pins)

    def score(self):
        if not self._is_game_over():
            raise ValueError("an incomplete game cannot be scored")

        score = 0
        roll_index = 0

        for frame in range(10):
            if self._is_strike(roll_index):
                score += 10 + self._rolls[roll_index + 1] + self._rolls[roll_index + 2]
                roll_index += 1
            elif self._is_spare(roll_index):
                score += 10 + self._rolls[roll_index + 2]
                roll_index += 2
            else:
                score += self._rolls[roll_index] + self._rolls[roll_index + 1]
                roll_index += 2

        return score

    def _is_game_over(self):
        if len(self._rolls) < 20:
            return False

        tenth = self._rolls[18]
        eleventh = self._rolls[19]

        if tenth == 10:
            return len(self._rolls) >= 22

        return self._rolls[18] + self._rolls[19] >= 10

    def _is_strike(self, roll_index):
        return self._rolls[roll_index] == 10

    def _is_spare(self, roll_index):
        return self._rolls[roll_index] + self._rolls[roll_index + 1] == 10
>>>>>>> REPLACE
```

> Tokens: 9.2k sent, 537 received.  
> Applied edit to bowling.py  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: bowling
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 31 items

bowling_test.py .FFFFFF......FFFFFFFFF..FFFFFFF                          [100%]

=================================== FAILURES ===================================
________ BowlingTest.test_a_spare_followed_by_zeros_is_worth_ten_points ________

self = <bowling_test.BowlingTest testMethod=test_a_spare_followed_by_zeros_is_worth_ten_points>

    def test_a_spare_followed_by_zeros_is_worth_ten_points(self):
        rolls = [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 10)
                         ^^^^^^^^^^^^

bowling_test.py:32: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe7dd790>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
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

self = <bowling.BowlingGame object at 0x7d7cfe4f5a90>, pins = 7

    def roll(self, pins):
        if pins < 0:
            raise ValueError("rolls cannot score negative points")
        if pins > 10:
            raise ValueError("a roll cannot score more than 10 points")
    
        if self._is_game_over():
>           raise ValueError("cannot roll after game is done")
E           ValueError: cannot roll after game is done

bowling.py:12: ValueError
___ BowlingTest.test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll ___

self = <bowling_test.BowlingTest testMethod=test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll>

    def test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll(self):
        rolls = [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 10)
                         ^^^^^^^^^^^^

bowling_test.py:52: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4f3250>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
_ BowlingTest.test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once _

self = <bowling_test.BowlingTest testMethod=test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once>

    def test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 18)
                         ^^^^^^^^^^^^

bowling_test.py:71: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe7fdb10>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
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

self = <bowling.BowlingGame object at 0x7d7cfe4f11d0>, pins = 10

    def roll(self, pins):
        if pins < 0:
            raise ValueError("rolls cannot score negative points")
        if pins > 10:
            raise ValueError("a roll cannot score more than 10 points")
    
        if self._is_game_over():
>           raise ValueError("cannot roll after game is done")
E           ValueError: cannot roll after game is done

bowling.py:12: ValueError
________________ BowlingTest.test_all_strikes_is_a_perfect_game ________________

self = <bowling_test.BowlingTest testMethod=test_all_strikes_is_a_perfect_game>

    def test_all_strikes_is_a_perfect_game(self):
        rolls = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 300)
                         ^^^^^^^^^^^^

bowling_test.py:98: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4d1450>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
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

self = <bowling.BowlingGame object at 0x7d7cfe4f6d90>, pins = 2

    def roll(self, pins):
        if pins < 0:
            raise ValueError("rolls cannot score negative points")
        if pins > 10:
            raise ValueError("a roll cannot score more than 10 points")
    
        if self._is_game_over():
>           raise ValueError("cannot roll after game is done")
E           ValueError: cannot roll after game is done

bowling.py:12: ValueError
__________ BowlingTest.test_cannot_roll_after_bonus_rolls_for_strike ___________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_after_bonus_rolls_for_strike>

    def test_cannot_roll_after_bonus_rolls_for_strike(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:208: AssertionError
_________ BowlingTest.test_cannot_roll_if_game_already_has_ten_frames __________

self = <bowling_test.BowlingTest testMethod=test_cannot_roll_if_game_already_has_ten_frames>

    def test_cannot_roll_if_game_already_has_ten_frames(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:172: AssertionError
________ BowlingTest.test_consecutive_spares_each_get_a_one_roll_bonus _________

self = <bowling_test.BowlingTest testMethod=test_consecutive_spares_each_get_a_one_roll_bonus>

    def test_consecutive_spares_each_get_a_one_roll_bonus(self):
        rolls = [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 31)
                         ^^^^^^^^^^^^

bowling_test.py:42: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe7430d0>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
_______ BowlingTest.test_consecutive_strikes_each_get_the_two_roll_bonus _______

self = <bowling_test.BowlingTest testMethod=test_consecutive_strikes_each_get_the_two_roll_bonus>

    def test_consecutive_strikes_each_get_the_two_roll_bonus(self):
        rolls = [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 81)
                         ^^^^^^^^^^^^

bowling_test.py:64: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4f57d0>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
_ BowlingTest.test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points _

self = <bowling_test.BowlingTest testMethod=test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points>

    def test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 31)
                         ^^^^^^^^^^^^

bowling_test.py:86: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4ca850>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
__ BowlingTest.test_points_scored_in_the_roll_after_a_spare_are_counted_twice __

self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_roll_after_a_spare_are_counted_twice>

    def test_points_scored_in_the_roll_after_a_spare_are_counted_twice(self):
        rolls = [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 16)
                         ^^^^^^^^^^^^

bowling_test.py:37: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4f68d0>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
_ BowlingTest.test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus _

self = <bowling_test.BowlingTest testMethod=test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus>

    def test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus(
        self,
    ):
        rolls = [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 26)
                         ^^^^^^^^^^^^

bowling_test.py:59: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4cbbd0>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
_ BowlingTest.test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll _

self = <bowling_test.BowlingTest testMethod=test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll>

    def test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 20)
                         ^^^^^^^^^^^^

bowling_test.py:76: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4d2a10>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
________ BowlingTest.test_should_be_able_to_score_a_game_with_all_zeros ________

self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_all_zeros>

    def test_should_be_able_to_score_a_game_with_all_zeros(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 0)
                         ^^^^^^^^^^^^

bowling_test.py:22: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4ddb50>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
__ BowlingTest.test_should_be_able_to_score_a_game_with_no_strikes_or_spares ___

self = <bowling_test.BowlingTest testMethod=test_should_be_able_to_score_a_game_with_no_strikes_or_spares>

    def test_should_be_able_to_score_a_game_with_no_strikes_or_spares(self):
        rolls = [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 90)
                         ^^^^^^^^^^^^

bowling_test.py:27: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4d0e90>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
___ BowlingTest.test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls ____

self = <bowling_test.BowlingTest testMethod=test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls>

    def test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls(self):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 30)
                         ^^^^^^^^^^^^

bowling_test.py:81: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe4f2090>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
_ BowlingTest.test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike _

self = <bowling_test.BowlingTest testMethod=test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike>

    def test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:146: AssertionError
_ BowlingTest.test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike _

self = <bowling_test.BowlingTest testMethod=test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike>

    def test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]
        game = self.roll_new_game(rolls)
>       self.assertEqual(game.score(), 26)
                         ^^^^^^^^^^^^

bowling_test.py:139: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <bowling.BowlingGame object at 0x7d7cfe7dfa10>

    def score(self):
        if not self._is_game_over():
>           raise ValueError("an incomplete game cannot be scored")
E           ValueError: an incomplete game cannot be scored

bowling.py:18: ValueError
_ BowlingTest.test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points _

self = <bowling_test.BowlingTest testMethod=test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points>

    def test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points(
        self,
    ):
        rolls = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:131: AssertionError
____ BowlingTest.test_two_rolls_in_a_frame_cannot_score_more_than_10_points ____

self = <bowling_test.BowlingTest testMethod=test_two_rolls_in_a_frame_cannot_score_more_than_10_points>

    def test_two_rolls_in_a_frame_cannot_score_more_than_10_points(self):
        rolls = [5]
        game = self.roll_new_game(rolls)
>       with self.assertRaisesWithMessage(Exception):
E       AssertionError: Exception not raised

bowling_test.py:115: AssertionError
=========================== short test summary info ============================
FAILED bowling_test.py::BowlingTest::test_a_spare_followed_by_zeros_is_worth_ten_points
FAILED bowling_test.py::BowlingTest::test_a_spare_in_the_last_frame_gets_a_one_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_earns_ten_points_in_a_frame_with_a_single_roll
FAILED bowling_test.py::BowlingTest::test_a_strike_in_the_last_frame_gets_a_two_roll_bonus_that_is_counted_once
FAILED bowling_test.py::BowlingTest::test_a_strike_with_the_one_roll_bonus_after_a_spare_in_the_last_frame_does_not_get_a_bonus
FAILED bowling_test.py::BowlingTest::test_all_strikes_is_a_perfect_game - Val...
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_roll_for_spare
FAILED bowling_test.py::BowlingTest::test_cannot_roll_after_bonus_rolls_for_strike
FAILED bowling_test.py::BowlingTest::test_cannot_roll_if_game_already_has_ten_frames
FAILED bowling_test.py::BowlingTest::test_consecutive_spares_each_get_a_one_roll_bonus
FAILED bowling_test.py::BowlingTest::test_consecutive_strikes_each_get_the_two_roll_bonus
FAILED bowling_test.py::BowlingTest::test_last_two_strikes_followed_by_only_last_bonus_with_non_strike_points
FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_roll_after_a_spare_are_counted_twice
FAILED bowling_test.py::BowlingTest::test_points_scored_in_the_two_rolls_after_a_strike_are_counted_twice_as_a_bonus
FAILED bowling_test.py::BowlingTest::test_rolling_a_spare_with_the_two_roll_bonus_does_not_get_a_bonus_roll
FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_all_zeros
FAILED bowling_test.py::BowlingTest::test_should_be_able_to_score_a_game_with_no_strikes_or_spares
FAILED bowling_test.py::BowlingTest::test_strikes_with_the_two_roll_bonus_do_not_get_bonus_rolls
FAILED bowling_test.py::BowlingTest::test_the_second_bonus_rolls_after_a_strike_in_the_last_frame_cannot_be_a_strike_if_the_first_one_is_not_a_strike
FAILED bowling_test.py::BowlingTest::test_two_bonus_rolls_after_a_strike_in_the_last_frame_can_score_more_than_10_points_if_one_is_a_strike
FAILED bowling_test.py::BowlingTest::test_two_bonus_rolls_after_a_strike_in_the_last_frame_cannot_score_more_than_10_points
FAILED bowling_test.py::BowlingTest::test_two_rolls_in_a_frame_cannot_score_more_than_10_points
========================= 22 failed, 9 passed  =========================

```