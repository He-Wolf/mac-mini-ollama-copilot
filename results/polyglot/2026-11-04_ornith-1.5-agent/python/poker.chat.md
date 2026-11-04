
# aider chat started at 2026-11-04 13:52:14

> Aider v0.86.3.dev+less  
> Model: ollama_chat/ornith-1.5-agent with diff edit format  
> Git repo: none  
> Repo-map: disabled  
> Added poker.py to the chat.  

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
#### Use the above instructions to modify the supplied files: poker.py  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

I'll implement the `best_hands` function to rank poker hands and return the winning hand(s).

My approach:
1. Parse each card into a rank and suit.
2. Score each hand as a comparable tuple (higher = better), covering all 9 hand categories with proper tiebreakers.
3. Return all hands that share the maximum score (to handle ties).

poker.py
```python
<<<<<<< SEARCH
def best_hands(hands):
    pass
=======
from collections import Counter

RANK_VALUES = {'2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8,
               '9': 9, '10': 10, 'J': 11, 'Q': 12, 'K': 13, 'A': 14}


def best_hands(hands):
    best = max(score(h) for h in hands)
    return [h for h in hands if score(h) == best]


def score(hand):
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
    suits = [c[-1] for c in hand]
    is_flush = len(set(suits)) == 1

    is_straight = len(set(ranks)) == 5
    if set(ranks) == {14, 5, 4, 3, 2}:  # wheel: A-5-4-3-2, ace counts as 1
        is_straight = True
        ranks = [5, 4, 3, 2, 1]

    counts = Counter(ranks)
    rank_by_count = sorted(counts.items(), key=lambda x: (x[1], x[0]), reverse=True)
    counts_list = [c for _, c in rank_by_count]

    if is_straight and is_flush:
        return (8, ranks[0])
    if counts_list[0] == 4:
        return (7, rank_by_count[0][0], rank_by_count[1][0])
    if counts_list[0] == 3 and counts_list[1] == 2:
        return (6, rank_by_count[0][0], rank_by_count[1][0])
    if is_flush:
        return (5,) + tuple(ranks)
    if is_straight:
        return (4, ranks[0])
    if counts_list[0] == 3:
        return (3, rank_by_count[0][0], *[r for r in ranks if counts[r] == 1])
    if counts_list[0] == 2 and counts_list[1] == 2:
        return (2, rank_by_count[0][0], rank_by_count[1][0], rank_by_count[2][0])
    if counts_list[0] == 2:
        return (1, rank_by_count[0][0], *[r for r in ranks if counts[r] == 1])
    return (0,) + tuple(ranks)
>>>>>>> REPLACE
```

> Tokens: 2.1k sent, 2.8k received.  
> Applied edit to poker.py  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: poker
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 37 items

poker_test.py FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF                      [100%]

=================================== FAILURES ===================================
_______________ PokerTest.test_a_straight_beats_three_of_a_kind ________________

self = <poker_test.PokerTest testMethod=test_a_straight_beats_three_of_a_kind>

    def test_a_straight_beats_three_of_a_kind(self):
        self.assertEqual(
>           best_hands(["4S 5H 4C 8D 4H", "3S 4D 2S 6D 5C"]), ["3S 4D 2S 6D 5C"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:117: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5628820>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
__________________ PokerTest.test_a_tie_has_multiple_winners ___________________

self = <poker_test.PokerTest testMethod=test_a_tie_has_multiple_winners>

    def test_a_tie_has_multiple_winners(self):
        self.assertEqual(
>           best_hands(
                [
                    "4D 5S 6S 8D 3C",
                    "2S 4C 7S 9H 10H",
                    "3S 4S 5D 6H JH",
                    "3H 4H 5C 6C JD",
                ]
            ),
            ["3S 4S 5D 6H JH", "3H 4H 5C 6C JD"],
        )

poker_test.py:24: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c24d0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
______________ PokerTest.test_aces_can_end_a_straight_10_j_q_k_a _______________

self = <poker_test.PokerTest testMethod=test_aces_can_end_a_straight_10_j_q_k_a>

    def test_aces_can_end_a_straight_10_j_q_k_a(self):
        self.assertEqual(
>           best_hands(["4S 5H 4C 8D 4H", "10D JH QS KD AC"]), ["10D JH QS KD AC"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:122: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b562b550>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
___________ PokerTest.test_aces_can_end_a_straight_flush_10_j_q_k_a ____________

self = <poker_test.PokerTest testMethod=test_aces_can_end_a_straight_flush_10_j_q_k_a>

    def test_aces_can_end_a_straight_flush_10_j_q_k_a(self):
        self.assertEqual(
>           best_hands(["KC AH AS AD AC", "10C JC QC KC AC"]), ["10C JC QC KC AC"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:200: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c2e30>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
______________ PokerTest.test_aces_can_start_a_straight_a_2_3_4_5 ______________

self = <poker_test.PokerTest testMethod=test_aces_can_start_a_straight_a_2_3_4_5>

    def test_aces_can_start_a_straight_a_2_3_4_5(self):
        self.assertEqual(
>           best_hands(["4S 5H 4C 8D 4H", "4D AH 3S 2D 5C"]), ["4D AH 3S 2D 5C"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:127: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5629270>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
___________ PokerTest.test_aces_can_start_a_straight_flush_a_2_3_4_5 ___________

self = <poker_test.PokerTest testMethod=test_aces_can_start_a_straight_flush_a_2_3_4_5>

    def test_aces_can_start_a_straight_flush_a_2_3_4_5(self):
        self.assertEqual(
>           best_hands(["KS AH AS AD AC", "4H AH 3H 2H 5H"]), ["4H AH 3H 2H 5H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:205: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c37f0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
__ PokerTest.test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3 ___

self = <poker_test.PokerTest testMethod=test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3>

    def test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3(self):
        self.assertEqual(
>           best_hands(["2C AC QC 10C KC", "QH KH AH 2H 3H"]), ["2C AC QC 10C KC"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:210: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5629540>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_____ PokerTest.test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3 ______

self = <poker_test.PokerTest testMethod=test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3>

    def test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3(self):
        self.assertEqual(
>           best_hands(["2C 3D 7H 5H 2S", "QS KH AC 2D 3S"]), ["2C 3D 7H 5H 2S"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:132: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b562b670>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary _

self = <poker_test.PokerTest testMethod=test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary>

    def test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary(
        self,
    ):
        self.assertEqual(
>           best_hands(["2H 7H 8H 9H 6H", "3S 5S 6S 7S 8S"]), ["2H 7H 8H 9H 6H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:156: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5628130>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet _

self = <poker_test.PokerTest testMethod=test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet>

    def test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet(self):
        self.assertEqual(
>           best_hands(["4H 4S 4D 9S 9D", "5H 5S 5D 8S 8D"]), ["5H 5S 5D 8S 8D"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:166: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5628430>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card _

self = <poker_test.PokerTest testMethod=test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card>

    def test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card(self):
        self.assertEqual(
>           best_hands(["4H 6H 7H 8H 5H", "5S 7S 8S 9S 6S"]), ["5S 7S 8S 9S 6S"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:215: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5650760>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_____ PokerTest.test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad ______

self = <poker_test.PokerTest testMethod=test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad>

    def test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad(self):
        self.assertEqual(
>           best_hands(["2S 2H 2C 8D 2D", "4S 5H 5S 5D 5C"]), ["4S 5H 5S 5D 5C"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:183: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5650a60>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_________ PokerTest.test_both_hands_have_the_same_pair_high_card_wins __________

self = <poker_test.PokerTest testMethod=test_both_hands_have_the_same_pair_high_card_wins>

    def test_both_hands_have_the_same_pair_high_card_wins(self):
        self.assertEqual(
>           best_hands(["4H 4S AH JC 3D", "4C 4D AS 5D 6C"]), ["4H 4S AH JC 3D"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:59: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5651d80>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet _

self = <poker_test.PokerTest testMethod=test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet>

    def test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet(self):
        self.assertEqual(
>           best_hands(["2S 2H 2C 8D JH", "4S AH AS 8C AD"]), ["4S AH AS 8C AD"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:105: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5651c60>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker _

self = <poker_test.PokerTest testMethod=test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker>

    def test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker(
        self,
    ):
        self.assertEqual(
>           best_hands(["JD QH JS 8D QC", "JS QS JC 2D QD"]), ["JD QH JS 8D QC"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:83: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5653a60>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
______ PokerTest.test_both_hands_have_two_pairs_highest_ranked_pair_wins _______

self = <poker_test.PokerTest testMethod=test_both_hands_have_two_pairs_highest_ranked_pair_wins>

    def test_both_hands_have_two_pairs_highest_ranked_pair_wins(self):
        self.assertEqual(
>           best_hands(["2S 8H 2D 8D 3H", "4S 5H 4C 8S 5D"]), ["2S 8H 2D 8D 3H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:69: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5652e00>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair _

self = <poker_test.PokerTest testMethod=test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair>

    def test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair(
        self,
    ):
        self.assertEqual(
>           best_hands(["6S 6H 3S 3H AS", "7H 7S 2H 2S AC"]), ["7H 7S 2H 2S AC"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:90: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5652da0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair _

self = <poker_test.PokerTest testMethod=test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair>

    def test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair(
        self,
    ):
        self.assertEqual(
>           best_hands(["2S QS 2C QD JH", "JD QH JS 8D QC"]), ["JD QH JS 8D QC"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:76: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b56504c0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
__ PokerTest.test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card ___

self = <poker_test.PokerTest testMethod=test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card>

    def test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card(self):
        self.assertEqual(
>           best_hands(["4S 6C 7S 8D 5H", "5S 7H 8S 9D 6H"]), ["5S 7H 8S 9D 6H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:137: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5653eb0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush _

self = <poker_test.PokerTest testMethod=test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush>

    def test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush(
        self,
    ):
        self.assertEqual(
>           best_hands(["2H 3H 4H 5H 6H", "4D AD 3D 2D 5D"]), ["2H 3H 4H 5H 6H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:222: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b56534c0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight _

self = <poker_test.PokerTest testMethod=test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight>

    def test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight(
        self,
    ):
        self.assertEqual(
>           best_hands(["2H 3C 4D 5D 6H", "4S AH 3S 2D 5H"]), ["2H 3C 4D 5D 6H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:144: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55f9240>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
____________________ PokerTest.test_flush_beats_a_straight _____________________

self = <poker_test.PokerTest testMethod=test_flush_beats_a_straight>

    def test_flush_beats_a_straight(self):
        self.assertEqual(
>           best_hands(["4C 6H 7D 8D 5H", "2S 4S 5S 6S 7S"]), ["2S 4S 5S 6S 7S"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:149: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c29e0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_______________ PokerTest.test_four_of_a_kind_beats_a_full_house _______________

self = <poker_test.PokerTest testMethod=test_four_of_a_kind_beats_a_full_house>

    def test_four_of_a_kind_beats_a_full_house(self):
        self.assertEqual(
>           best_hands(["4S 5H 4D 5D 4H", "3S 3H 2S 3D 3C"]), ["3S 3H 2S 3D 3C"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:178: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c28f0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
___________________ PokerTest.test_full_house_beats_a_flush ____________________

self = <poker_test.PokerTest testMethod=test_full_house_beats_a_flush>

    def test_full_house_beats_a_flush(self):
        self.assertEqual(
>           best_hands(["3H 6H 7H 8H 5H", "4S 5H 4C 5D 4H"]), ["4S 5H 4C 5D 4H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:161: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c2a70>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
______________ PokerTest.test_highest_card_out_of_all_hands_wins _______________

self = <poker_test.PokerTest testMethod=test_highest_card_out_of_all_hands_wins>

    def test_highest_card_out_of_all_hands_wins(self):
        self.assertEqual(
>           best_hands(["4D 5S 6S 8D 3C", "2S 4C 7S 9H 10H", "3S 4S 5D 6H JH"]),
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            ["3S 4S 5D 6H JH"],
        )

poker_test.py:18: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c3370>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_______________________ PokerTest.test_highest_pair_wins _______________________

self = <poker_test.PokerTest testMethod=test_highest_pair_wins>

    def test_highest_pair_wins(self):
        self.assertEqual(
>           best_hands(["4S 2H 6S 2D JH", "2S 4H 6C 4D JD"]), ["2S 4H 6C 4D JD"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:54: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c2d10>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card _

self = <poker_test.PokerTest testMethod=test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card>

    def test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card(
        self,
    ):
        self.assertEqual(
>           best_hands(["3S 5H 6S 8D 7H", "2S 5D 6D 8C 7S"]), ["3S 5H 6S 8D 7H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:39: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c3280>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
___________________ PokerTest.test_one_pair_beats_high_card ____________________

self = <poker_test.PokerTest testMethod=test_one_pair_beats_high_card>

    def test_one_pair_beats_high_card(self):
        self.assertEqual(
>           best_hands(["4S 5H 6C 8D KH", "2S 4H 6S 4D JH"]), ["2S 4H 6S 4D JH"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:49: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c29e0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
____________________ PokerTest.test_single_hand_always_wins ____________________

self = <poker_test.PokerTest testMethod=test_single_hand_always_wins>

    def test_single_hand_always_wins(self):
>       self.assertEqual(best_hands(["4S 5S 7H 8D JC"]), ["4S 5S 7H 8D JC"])
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

poker_test.py:14: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c2950>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
______________ PokerTest.test_straight_flush_beats_four_of_a_kind ______________

self = <poker_test.PokerTest testMethod=test_straight_flush_beats_four_of_a_kind>

    def test_straight_flush_beats_four_of_a_kind(self):
        self.assertEqual(
>           best_hands(["4S 5H 5S 5D 5C", "7S 8S 9S 6S 10S"]), ["7S 8S 9S 6S 10S"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:195: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c3730>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
________________ PokerTest.test_three_of_a_kind_beats_two_pair _________________

self = <poker_test.PokerTest testMethod=test_three_of_a_kind_beats_two_pair>

    def test_three_of_a_kind_beats_two_pair(self):
        self.assertEqual(
>           best_hands(["2S 8H 2H 8D JH", "4S 5H 4C 8S 4H"]), ["4S 5H 4C 8S 4H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:100: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c28f0>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
___________________ PokerTest.test_two_pairs_beats_one_pair ____________________

self = <poker_test.PokerTest testMethod=test_two_pairs_beats_one_pair>

    def test_two_pairs_beats_one_pair(self):
        self.assertEqual(
>           best_hands(["2S 8H 6S 8D JH", "4S 5H 4C 8C 5C"]), ["4S 5H 4C 8C 5C"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:64: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c3c70>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
____________ PokerTest.test_two_pairs_first_ranked_by_largest_pair _____________

self = <poker_test.PokerTest testMethod=test_two_pairs_first_ranked_by_largest_pair>

    def test_two_pairs_first_ranked_by_largest_pair(self):
        self.assertEqual(
>           best_hands(["5C 2S 5S 4H 4C", "6S 2S 6H 7C 2C"]), ["6S 2S 6H 7C 2C"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:95: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c2590>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
________ PokerTest.test_winning_high_card_hand_also_has_the_lowest_card ________

self = <poker_test.PokerTest testMethod=test_winning_high_card_hand_also_has_the_lowest_card>

    def test_winning_high_card_hand_also_has_the_lowest_card(self):
        self.assertEqual(
>           best_hands(["2S 5H 6S 8D 7H", "3S 4D 6D 8C 7S"]), ["2S 5H 6S 8D 7H"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:44: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c2410>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair _

self = <poker_test.PokerTest testMethod=test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair>

    def test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair(
        self,
    ):
        self.assertEqual(
>           best_hands(["5H 5S 5D 9S 9D", "5H 5S 5D 8S 8D"]), ["5H 5S 5D 9S 9D"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:173: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b560ad40>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker _

self = <poker_test.PokerTest testMethod=test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker>

    def test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker(
        self,
    ):
        self.assertEqual(
>           best_hands(["3S 3H 2S 3D 3C", "3S 3H 4S 3D 3C"]), ["3S 3H 4S 3D 3C"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:190: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b55c2530>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
_ PokerTest.test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards _

self = <poker_test.PokerTest testMethod=test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards>

    def test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards(
        self,
    ):
        self.assertEqual(
>           best_hands(["5S AH AS 7C AD", "4S AH AS 8C AD"]), ["4S AH AS 8C AD"]
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        )

poker_test.py:112: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
poker.py:8: in best_hands
    best = max(score(h) for h in hands)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
poker.py:8: in <genexpr>
    best = max(score(h) for h in hands)
               ^^^^^^^^
poker.py:13: in score
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

.0 = <str_ascii_iterator object at 0x7076b5628880>

>   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
                    ^^^^^^^^^^^^^^^^^^^
E   KeyError: ''

poker.py:13: KeyError
=========================== short test summary info ============================
FAILED poker_test.py::PokerTest::test_a_straight_beats_three_of_a_kind - KeyE...
FAILED poker_test.py::PokerTest::test_a_tie_has_multiple_winners - KeyError: ''
FAILED poker_test.py::PokerTest::test_aces_can_end_a_straight_10_j_q_k_a - Ke...
FAILED poker_test.py::PokerTest::test_aces_can_end_a_straight_flush_10_j_q_k_a
FAILED poker_test.py::PokerTest::test_aces_can_start_a_straight_a_2_3_4_5 - K...
FAILED poker_test.py::PokerTest::test_aces_can_start_a_straight_flush_a_2_3_4_5
FAILED poker_test.py::PokerTest::test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3
FAILED poker_test.py::PokerTest::test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3
FAILED poker_test.py::PokerTest::test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary
FAILED poker_test.py::PokerTest::test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet
FAILED poker_test.py::PokerTest::test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card
FAILED poker_test.py::PokerTest::test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad
FAILED poker_test.py::PokerTest::test_both_hands_have_the_same_pair_high_card_wins
FAILED poker_test.py::PokerTest::test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet
FAILED poker_test.py::PokerTest::test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker
FAILED poker_test.py::PokerTest::test_both_hands_have_two_pairs_highest_ranked_pair_wins
FAILED poker_test.py::PokerTest::test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair
FAILED poker_test.py::PokerTest::test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair
FAILED poker_test.py::PokerTest::test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card
FAILED poker_test.py::PokerTest::test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush
FAILED poker_test.py::PokerTest::test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight
FAILED poker_test.py::PokerTest::test_flush_beats_a_straight - KeyError: ''
FAILED poker_test.py::PokerTest::test_four_of_a_kind_beats_a_full_house - Key...
FAILED poker_test.py::PokerTest::test_full_house_beats_a_flush - KeyError: ''
FAILED poker_test.py::PokerTest::test_highest_card_out_of_all_hands_wins - Ke...
FAILED poker_test.py::PokerTest::test_highest_pair_wins - KeyError: ''
FAILED poker_test.py::PokerTest::test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card
FAILED poker_test.py::PokerTest::test_one_pair_beats_high_card - KeyError: ''
FAILED poker_test.py::PokerTest::test_single_hand_always_wins - KeyError: ''
FAILED poker_test.py::PokerTest::test_straight_flush_beats_four_of_a_kind - K...
FAILED poker_test.py::PokerTest::test_three_of_a_kind_beats_two_pair - KeyErr...
FAILED poker_test.py::PokerTest::test_two_pairs_beats_one_pair - KeyError: ''
FAILED poker_test.py::PokerTest::test_two_pairs_first_ranked_by_largest_pair
FAILED poker_test.py::PokerTest::test_winning_high_card_hand_also_has_the_lowest_card
FAILED poker_test.py::PokerTest::test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair
FAILED poker_test.py::PokerTest::test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker
FAILED poker_test.py::PokerTest::test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards
============================== 37 failed  ==============================

```
#### ============================= test session starts ==============================  
#### platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0  
#### rootdir: poker  
#### plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0  
#### collected 37 items  
####   
#### poker_test.py FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF                      [100%]  
####   
#### =================================== FAILURES ===================================  
#### _______________ PokerTest.test_a_straight_beats_three_of_a_kind ________________  
####   
#### self = <poker_test.PokerTest testMethod=test_a_straight_beats_three_of_a_kind>  
####   
####     def test_a_straight_beats_three_of_a_kind(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 5H 4C 8D 4H", "3S 4D 2S 6D 5C"]), ["3S 4D 2S 6D 5C"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:117:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5628820>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### __________________ PokerTest.test_a_tie_has_multiple_winners ___________________  
####   
#### self = <poker_test.PokerTest testMethod=test_a_tie_has_multiple_winners>  
####   
####     def test_a_tie_has_multiple_winners(self):  
####         self.assertEqual(  
#### >           best_hands(  
####                 [  
####                     "4D 5S 6S 8D 3C",  
####                     "2S 4C 7S 9H 10H",  
####                     "3S 4S 5D 6H JH",  
####                     "3H 4H 5C 6C JD",  
####                 ]  
####             ),  
####             ["3S 4S 5D 6H JH", "3H 4H 5C 6C JD"],  
####         )  
####   
#### poker_test.py:24:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c24d0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ______________ PokerTest.test_aces_can_end_a_straight_10_j_q_k_a _______________  
####   
#### self = <poker_test.PokerTest testMethod=test_aces_can_end_a_straight_10_j_q_k_a>  
####   
####     def test_aces_can_end_a_straight_10_j_q_k_a(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 5H 4C 8D 4H", "10D JH QS KD AC"]), ["10D JH QS KD AC"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:122:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b562b550>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ___________ PokerTest.test_aces_can_end_a_straight_flush_10_j_q_k_a ____________  
####   
#### self = <poker_test.PokerTest testMethod=test_aces_can_end_a_straight_flush_10_j_q_k_a>  
####   
####     def test_aces_can_end_a_straight_flush_10_j_q_k_a(self):  
####         self.assertEqual(  
#### >           best_hands(["KC AH AS AD AC", "10C JC QC KC AC"]), ["10C JC QC KC AC"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:200:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c2e30>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ______________ PokerTest.test_aces_can_start_a_straight_a_2_3_4_5 ______________  
####   
#### self = <poker_test.PokerTest testMethod=test_aces_can_start_a_straight_a_2_3_4_5>  
####   
####     def test_aces_can_start_a_straight_a_2_3_4_5(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 5H 4C 8D 4H", "4D AH 3S 2D 5C"]), ["4D AH 3S 2D 5C"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:127:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5629270>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ___________ PokerTest.test_aces_can_start_a_straight_flush_a_2_3_4_5 ___________  
####   
#### self = <poker_test.PokerTest testMethod=test_aces_can_start_a_straight_flush_a_2_3_4_5>  
####   
####     def test_aces_can_start_a_straight_flush_a_2_3_4_5(self):  
####         self.assertEqual(  
#### >           best_hands(["KS AH AS AD AC", "4H AH 3H 2H 5H"]), ["4H AH 3H 2H 5H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:205:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c37f0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### __ PokerTest.test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3 ___  
####   
#### self = <poker_test.PokerTest testMethod=test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3>  
####   
####     def test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3(self):  
####         self.assertEqual(  
#### >           best_hands(["2C AC QC 10C KC", "QH KH AH 2H 3H"]), ["2C AC QC 10C KC"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:210:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5629540>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _____ PokerTest.test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3 ______  
####   
#### self = <poker_test.PokerTest testMethod=test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3>  
####   
####     def test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3(self):  
####         self.assertEqual(  
#### >           best_hands(["2C 3D 7H 5H 2S", "QS KH AC 2D 3S"]), ["2C 3D 7H 5H 2S"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:132:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b562b670>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary _  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary>  
####   
####     def test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["2H 7H 8H 9H 6H", "3S 5S 6S 7S 8S"]), ["2H 7H 8H 9H 6H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:156:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5628130>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet _  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet>  
####   
####     def test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet(self):  
####         self.assertEqual(  
#### >           best_hands(["4H 4S 4D 9S 9D", "5H 5S 5D 8S 8D"]), ["5H 5S 5D 8S 8D"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:166:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5628430>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card _  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card>  
####   
####     def test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card(self):  
####         self.assertEqual(  
#### >           best_hands(["4H 6H 7H 8H 5H", "5S 7S 8S 9S 6S"]), ["5S 7S 8S 9S 6S"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:215:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5650760>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _____ PokerTest.test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad ______  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad>  
####   
####     def test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad(self):  
####         self.assertEqual(  
#### >           best_hands(["2S 2H 2C 8D 2D", "4S 5H 5S 5D 5C"]), ["4S 5H 5S 5D 5C"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:183:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5650a60>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _________ PokerTest.test_both_hands_have_the_same_pair_high_card_wins __________  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_the_same_pair_high_card_wins>  
####   
####     def test_both_hands_have_the_same_pair_high_card_wins(self):  
####         self.assertEqual(  
#### >           best_hands(["4H 4S AH JC 3D", "4C 4D AS 5D 6C"]), ["4H 4S AH JC 3D"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:59:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5651d80>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet _  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet>  
####   
####     def test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet(self):  
####         self.assertEqual(  
#### >           best_hands(["2S 2H 2C 8D JH", "4S AH AS 8C AD"]), ["4S AH AS 8C AD"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:105:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5651c60>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker _  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker>  
####   
####     def test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["JD QH JS 8D QC", "JS QS JC 2D QD"]), ["JD QH JS 8D QC"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:83:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5653a60>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ______ PokerTest.test_both_hands_have_two_pairs_highest_ranked_pair_wins _______  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_two_pairs_highest_ranked_pair_wins>  
####   
####     def test_both_hands_have_two_pairs_highest_ranked_pair_wins(self):  
####         self.assertEqual(  
#### >           best_hands(["2S 8H 2D 8D 3H", "4S 5H 4C 8S 5D"]), ["2S 8H 2D 8D 3H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:69:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5652e00>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair _  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair>  
####   
####     def test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["6S 6H 3S 3H AS", "7H 7S 2H 2S AC"]), ["7H 7S 2H 2S AC"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:90:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5652da0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair _  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair>  
####   
####     def test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["2S QS 2C QD JH", "JD QH JS 8D QC"]), ["JD QH JS 8D QC"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:76:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b56504c0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### __ PokerTest.test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card ___  
####   
#### self = <poker_test.PokerTest testMethod=test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card>  
####   
####     def test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 6C 7S 8D 5H", "5S 7H 8S 9D 6H"]), ["5S 7H 8S 9D 6H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:137:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5653eb0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush _  
####   
#### self = <poker_test.PokerTest testMethod=test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush>  
####   
####     def test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["2H 3H 4H 5H 6H", "4D AD 3D 2D 5D"]), ["2H 3H 4H 5H 6H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:222:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b56534c0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight _  
####   
#### self = <poker_test.PokerTest testMethod=test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight>  
####   
####     def test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["2H 3C 4D 5D 6H", "4S AH 3S 2D 5H"]), ["2H 3C 4D 5D 6H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:144:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55f9240>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ____________________ PokerTest.test_flush_beats_a_straight _____________________  
####   
#### self = <poker_test.PokerTest testMethod=test_flush_beats_a_straight>  
####   
####     def test_flush_beats_a_straight(self):  
####         self.assertEqual(  
#### >           best_hands(["4C 6H 7D 8D 5H", "2S 4S 5S 6S 7S"]), ["2S 4S 5S 6S 7S"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:149:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c29e0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _______________ PokerTest.test_four_of_a_kind_beats_a_full_house _______________  
####   
#### self = <poker_test.PokerTest testMethod=test_four_of_a_kind_beats_a_full_house>  
####   
####     def test_four_of_a_kind_beats_a_full_house(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 5H 4D 5D 4H", "3S 3H 2S 3D 3C"]), ["3S 3H 2S 3D 3C"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:178:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c28f0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ___________________ PokerTest.test_full_house_beats_a_flush ____________________  
####   
#### self = <poker_test.PokerTest testMethod=test_full_house_beats_a_flush>  
####   
####     def test_full_house_beats_a_flush(self):  
####         self.assertEqual(  
#### >           best_hands(["3H 6H 7H 8H 5H", "4S 5H 4C 5D 4H"]), ["4S 5H 4C 5D 4H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:161:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c2a70>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ______________ PokerTest.test_highest_card_out_of_all_hands_wins _______________  
####   
#### self = <poker_test.PokerTest testMethod=test_highest_card_out_of_all_hands_wins>  
####   
####     def test_highest_card_out_of_all_hands_wins(self):  
####         self.assertEqual(  
#### >           best_hands(["4D 5S 6S 8D 3C", "2S 4C 7S 9H 10H", "3S 4S 5D 6H JH"]),  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####             ["3S 4S 5D 6H JH"],  
####         )  
####   
#### poker_test.py:18:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c3370>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _______________________ PokerTest.test_highest_pair_wins _______________________  
####   
#### self = <poker_test.PokerTest testMethod=test_highest_pair_wins>  
####   
####     def test_highest_pair_wins(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 2H 6S 2D JH", "2S 4H 6C 4D JD"]), ["2S 4H 6C 4D JD"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:54:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c2d10>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card _  
####   
#### self = <poker_test.PokerTest testMethod=test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card>  
####   
####     def test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["3S 5H 6S 8D 7H", "2S 5D 6D 8C 7S"]), ["3S 5H 6S 8D 7H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:39:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c3280>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ___________________ PokerTest.test_one_pair_beats_high_card ____________________  
####   
#### self = <poker_test.PokerTest testMethod=test_one_pair_beats_high_card>  
####   
####     def test_one_pair_beats_high_card(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 5H 6C 8D KH", "2S 4H 6S 4D JH"]), ["2S 4H 6S 4D JH"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:49:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c29e0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ____________________ PokerTest.test_single_hand_always_wins ____________________  
####   
#### self = <poker_test.PokerTest testMethod=test_single_hand_always_wins>  
####   
####     def test_single_hand_always_wins(self):  
#### >       self.assertEqual(best_hands(["4S 5S 7H 8D JC"]), ["4S 5S 7H 8D JC"])  
####                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####   
#### poker_test.py:14:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c2950>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ______________ PokerTest.test_straight_flush_beats_four_of_a_kind ______________  
####   
#### self = <poker_test.PokerTest testMethod=test_straight_flush_beats_four_of_a_kind>  
####   
####     def test_straight_flush_beats_four_of_a_kind(self):  
####         self.assertEqual(  
#### >           best_hands(["4S 5H 5S 5D 5C", "7S 8S 9S 6S 10S"]), ["7S 8S 9S 6S 10S"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:195:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c3730>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ________________ PokerTest.test_three_of_a_kind_beats_two_pair _________________  
####   
#### self = <poker_test.PokerTest testMethod=test_three_of_a_kind_beats_two_pair>  
####   
####     def test_three_of_a_kind_beats_two_pair(self):  
####         self.assertEqual(  
#### >           best_hands(["2S 8H 2H 8D JH", "4S 5H 4C 8S 4H"]), ["4S 5H 4C 8S 4H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:100:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c28f0>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ___________________ PokerTest.test_two_pairs_beats_one_pair ____________________  
####   
#### self = <poker_test.PokerTest testMethod=test_two_pairs_beats_one_pair>  
####   
####     def test_two_pairs_beats_one_pair(self):  
####         self.assertEqual(  
#### >           best_hands(["2S 8H 6S 8D JH", "4S 5H 4C 8C 5C"]), ["4S 5H 4C 8C 5C"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:64:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c3c70>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ____________ PokerTest.test_two_pairs_first_ranked_by_largest_pair _____________  
####   
#### self = <poker_test.PokerTest testMethod=test_two_pairs_first_ranked_by_largest_pair>  
####   
####     def test_two_pairs_first_ranked_by_largest_pair(self):  
####         self.assertEqual(  
#### >           best_hands(["5C 2S 5S 4H 4C", "6S 2S 6H 7C 2C"]), ["6S 2S 6H 7C 2C"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:95:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c2590>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### ________ PokerTest.test_winning_high_card_hand_also_has_the_lowest_card ________  
####   
#### self = <poker_test.PokerTest testMethod=test_winning_high_card_hand_also_has_the_lowest_card>  
####   
####     def test_winning_high_card_hand_also_has_the_lowest_card(self):  
####         self.assertEqual(  
#### >           best_hands(["2S 5H 6S 8D 7H", "3S 4D 6D 8C 7S"]), ["2S 5H 6S 8D 7H"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:44:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c2410>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair _  
####   
#### self = <poker_test.PokerTest testMethod=test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair>  
####   
####     def test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["5H 5S 5D 9S 9D", "5H 5S 5D 8S 8D"]), ["5H 5S 5D 9S 9D"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:173:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b560ad40>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker _  
####   
#### self = <poker_test.PokerTest testMethod=test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker>  
####   
####     def test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["3S 3H 2S 3D 3C", "3S 3H 4S 3D 3C"]), ["3S 3H 4S 3D 3C"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:190:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b55c2530>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### _ PokerTest.test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards _  
####   
#### self = <poker_test.PokerTest testMethod=test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards>  
####   
####     def test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards(  
####         self,  
####     ):  
####         self.assertEqual(  
#### >           best_hands(["5S AH AS 7C AD", "4S AH AS 8C AD"]), ["4S AH AS 8C AD"]  
####             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
####         )  
####   
#### poker_test.py:112:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
#### poker.py:8: in best_hands  
####     best = max(score(h) for h in hands)  
####            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### poker.py:8: in <genexpr>  
####     best = max(score(h) for h in hands)  
####                ^^^^^^^^  
#### poker.py:13: in score  
####     ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### .0 = <str_ascii_iterator object at 0x7076b5628880>  
####   
#### >   ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)  
####                     ^^^^^^^^^^^^^^^^^^^  
#### E   KeyError: ''  
####   
#### poker.py:13: KeyError  
#### =========================== short test summary info ============================  
#### FAILED poker_test.py::PokerTest::test_a_straight_beats_three_of_a_kind - KeyE...  
#### FAILED poker_test.py::PokerTest::test_a_tie_has_multiple_winners - KeyError: ''  
#### FAILED poker_test.py::PokerTest::test_aces_can_end_a_straight_10_j_q_k_a - Ke...  
#### FAILED poker_test.py::PokerTest::test_aces_can_end_a_straight_flush_10_j_q_k_a  
#### FAILED poker_test.py::PokerTest::test_aces_can_start_a_straight_a_2_3_4_5 - K...  
#### FAILED poker_test.py::PokerTest::test_aces_can_start_a_straight_flush_a_2_3_4_5  
#### FAILED poker_test.py::PokerTest::test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3  
#### FAILED poker_test.py::PokerTest::test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_a_flush_tie_goes_to_high_card_down_to_the_last_one_if_necessary  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_a_full_house_tie_goes_to_highest_ranked_triplet  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_a_straight_flush_tie_goes_to_highest_ranked_card  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_four_of_a_kind_tie_goes_to_high_quad  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_the_same_pair_high_card_wins  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_three_of_a_kind_tie_goes_to_highest_ranked_triplet  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_two_identically_ranked_pairs_tie_goes_to_remaining_card_kicker  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_two_pairs_highest_ranked_pair_wins  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_two_pairs_that_add_to_the_same_value_win_goes_to_highest_pair  
#### FAILED poker_test.py::PokerTest::test_both_hands_have_two_pairs_with_the_same_highest_ranked_pair_tie_goes_to_low_pair  
#### FAILED poker_test.py::PokerTest::test_both_hands_with_a_straight_tie_goes_to_highest_ranked_card  
#### FAILED poker_test.py::PokerTest::test_even_though_an_ace_is_usually_high_a_5_high_straight_flush_is_the_lowest_scoring_straight_flush  
#### FAILED poker_test.py::PokerTest::test_even_though_an_ace_is_usually_high_a_5_high_straight_is_the_lowest_scoring_straight  
#### FAILED poker_test.py::PokerTest::test_flush_beats_a_straight - KeyError: ''  
#### FAILED poker_test.py::PokerTest::test_four_of_a_kind_beats_a_full_house - Key...  
#### FAILED poker_test.py::PokerTest::test_full_house_beats_a_flush - KeyError: ''  
#### FAILED poker_test.py::PokerTest::test_highest_card_out_of_all_hands_wins - Ke...  
#### FAILED poker_test.py::PokerTest::test_highest_pair_wins - KeyError: ''  
#### FAILED poker_test.py::PokerTest::test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card  
#### FAILED poker_test.py::PokerTest::test_one_pair_beats_high_card - KeyError: ''  
#### FAILED poker_test.py::PokerTest::test_single_hand_always_wins - KeyError: ''  
#### FAILED poker_test.py::PokerTest::test_straight_flush_beats_four_of_a_kind - K...  
#### FAILED poker_test.py::PokerTest::test_three_of_a_kind_beats_two_pair - KeyErr...  
#### FAILED poker_test.py::PokerTest::test_two_pairs_beats_one_pair - KeyError: ''  
#### FAILED poker_test.py::PokerTest::test_two_pairs_first_ranked_by_largest_pair  
#### FAILED poker_test.py::PokerTest::test_winning_high_card_hand_also_has_the_lowest_card  
#### FAILED poker_test.py::PokerTest::test_with_multiple_decks_both_hands_have_a_full_house_with_the_same_triplet_tie_goes_to_the_pair  
#### FAILED poker_test.py::PokerTest::test_with_multiple_decks_both_hands_with_identical_four_of_a_kind_tie_determined_by_kicker  
#### FAILED poker_test.py::PokerTest::test_with_multiple_decks_two_players_can_have_same_three_of_a_kind_ties_go_to_highest_remaining_cards  
#### ============================== 37 failed  ==============================  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in poker.py to resolve the errors.  

The bug is that `hand` is a string like `"4S 5H 4C 8D 4H"`, and iterating over it with `for c in hand` iterates character-by-character (including spaces), so `c[:-1]` becomes `''` for the space character. I need to split the hand into cards first.

poker.py
```python
<<<<<<< SEARCH
def score(hand):
    ranks = sorted([RANK_VALUES[c[:-1]] for c in hand], reverse=True)
    suits = [c[-1] for c in hand]
=======
def score(hand):
    cards = hand.split()
    ranks = sorted([RANK_VALUES[c[:-1]] for c in cards], reverse=True)
    suits = [c[-1] for c in cards]
>>>>>>> REPLACE
```

> Tokens: 20k sent, 594 received.  
> Applied edit to poker.py  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: poker
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 37 items

poker_test.py ......FF...............F..FF.....F...                      [100%]

=================================== FAILURES ===================================
__ PokerTest.test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3 ___

self = <poker_test.PokerTest testMethod=test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3>

    def test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3(self):
>       self.assertEqual(
            best_hands(["2C AC QC 10C KC", "QH KH AH 2H 3H"]), ["2C AC QC 10C KC"]
        )
E       AssertionError: Lists differ: ['2C AC QC 10C KC', 'QH KH AH 2H 3H'] != ['2C AC QC 10C KC']
E       
E       First list contains 1 additional elements.
E       First extra element 1:
E       'QH KH AH 2H 3H'
E       
E       - ['2C AC QC 10C KC', 'QH KH AH 2H 3H']
E       + ['2C AC QC 10C KC']

poker_test.py:209: AssertionError
_____ PokerTest.test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3 ______

self = <poker_test.PokerTest testMethod=test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3>

    def test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3(self):
>       self.assertEqual(
            best_hands(["2C 3D 7H 5H 2S", "QS KH AC 2D 3S"]), ["2C 3D 7H 5H 2S"]
        )
E       AssertionError: Lists differ: ['QS KH AC 2D 3S'] != ['2C 3D 7H 5H 2S']
E       
E       First differing element 0:
E       'QS KH AC 2D 3S'
E       '2C 3D 7H 5H 2S'
E       
E       - ['QS KH AC 2D 3S']
E       + ['2C 3D 7H 5H 2S']

poker_test.py:131: AssertionError
___________________ PokerTest.test_full_house_beats_a_flush ____________________

self = <poker_test.PokerTest testMethod=test_full_house_beats_a_flush>

    def test_full_house_beats_a_flush(self):
>       self.assertEqual(
            best_hands(["3H 6H 7H 8H 5H", "4S 5H 4C 5D 4H"]), ["4S 5H 4C 5D 4H"]
        )
E       AssertionError: Lists differ: ['3H 6H 7H 8H 5H'] != ['4S 5H 4C 5D 4H']
E       
E       First differing element 0:
E       '3H 6H 7H 8H 5H'
E       '4S 5H 4C 5D 4H'
E       
E       - ['3H 6H 7H 8H 5H']
E       + ['4S 5H 4C 5D 4H']

poker_test.py:160: AssertionError
_ PokerTest.test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card _

self = <poker_test.PokerTest testMethod=test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card>

    def test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card(
        self,
    ):
>       self.assertEqual(
            best_hands(["3S 5H 6S 8D 7H", "2S 5D 6D 8C 7S"]), ["3S 5H 6S 8D 7H"]
        )
E       AssertionError: Lists differ: ['3S 5H 6S 8D 7H', '2S 5D 6D 8C 7S'] != ['3S 5H 6S 8D 7H']
E       
E       First list contains 1 additional elements.
E       First extra element 1:
E       '2S 5D 6D 8C 7S'
E       
E       - ['3S 5H 6S 8D 7H', '2S 5D 6D 8C 7S']
E       + ['3S 5H 6S 8D 7H']

poker_test.py:38: AssertionError
___________________ PokerTest.test_one_pair_beats_high_card ____________________

self = <poker_test.PokerTest testMethod=test_one_pair_beats_high_card>

    def test_one_pair_beats_high_card(self):
>       self.assertEqual(
            best_hands(["4S 5H 6C 8D KH", "2S 4H 6S 4D JH"]), ["2S 4H 6S 4D JH"]
        )
E       AssertionError: Lists differ: ['4S 5H 6C 8D KH'] != ['2S 4H 6S 4D JH']
E       
E       First differing element 0:
E       '4S 5H 6C 8D KH'
E       '2S 4H 6S 4D JH'
E       
E       - ['4S 5H 6C 8D KH']
E       + ['2S 4H 6S 4D JH']

poker_test.py:48: AssertionError
________ PokerTest.test_winning_high_card_hand_also_has_the_lowest_card ________

self = <poker_test.PokerTest testMethod=test_winning_high_card_hand_also_has_the_lowest_card>

    def test_winning_high_card_hand_also_has_the_lowest_card(self):
>       self.assertEqual(
            best_hands(["2S 5H 6S 8D 7H", "3S 4D 6D 8C 7S"]), ["2S 5H 6S 8D 7H"]
        )
E       AssertionError: Lists differ: ['2S 5H 6S 8D 7H', '3S 4D 6D 8C 7S'] != ['2S 5H 6S 8D 7H']
E       
E       First list contains 1 additional elements.
E       First extra element 1:
E       '3S 4D 6D 8C 7S'
E       
E       - ['2S 5H 6S 8D 7H', '3S 4D 6D 8C 7S']
E       + ['2S 5H 6S 8D 7H']

poker_test.py:43: AssertionError
=========================== short test summary info ============================
FAILED poker_test.py::PokerTest::test_aces_cannot_be_in_the_middle_of_a_straight_flush_q_k_a_2_3
FAILED poker_test.py::PokerTest::test_aces_cannot_be_in_the_middle_of_a_straight_q_k_a_2_3
FAILED poker_test.py::PokerTest::test_full_house_beats_a_flush - AssertionErr...
FAILED poker_test.py::PokerTest::test_multiple_hands_with_the_same_high_cards_tie_compares_next_highest_ranked_down_to_last_card
FAILED poker_test.py::PokerTest::test_one_pair_beats_high_card - AssertionErr...
FAILED poker_test.py::PokerTest::test_winning_high_card_hand_also_has_the_lowest_card
========================= 6 failed, 31 passed  =========================

```