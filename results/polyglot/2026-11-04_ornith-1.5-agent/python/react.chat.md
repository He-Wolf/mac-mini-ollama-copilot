
# aider chat started at 2026-11-04 13:27:34

> Aider v0.86.3.dev+less  
> Model: ollama_chat/ornith-1.5-agent with diff edit format  
> Git repo: none  
> Repo-map: disabled  
> Added react.py to the chat.  

#### # Instructions  
####   
#### Implement a basic reactive system.  
####   
#### Reactive programming is a programming paradigm that focuses on how values are computed in terms of each other to allow a change to one value to automatically propagate to other values, like in a spreadsheet.  
####   
#### Implement a basic reactive system with cells with settable values ("input" cells) and cells with values computed in terms of other cells ("compute" cells).  
#### Implement updates so that when an input value is changed, values propagate to reach a new stable system state.  
####   
#### In addition, compute cells should allow for registering change notification callbacks.  
#### Call a cell’s callbacks when the cell’s value in a new stable state has changed from the previous stable state.  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: react.py  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  
> Tokens: 2.3k sent, 16k received.  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: react
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 14 items

react_test.py .FFFF.FFFFFFFF                                             [100%]

=================================== FAILURES ===================================
______________ ReactTest.test_callback_cells_only_fire_on_change _______________

self = <react_test.ReactTest testMethod=test_callback_cells_only_fire_on_change>

    def test_callback_cells_only_fire_on_change(self):
        input = InputCell(1)
        output = ComputeCell([input], lambda inputs: 111 if inputs[0] < 3 else 222)
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 2
        self.assertEqual(cb1_observer, [])
        input.value = 4
>       self.assertEqual(cb1_observer[-1], 222)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:105: IndexError
______________ ReactTest.test_callbacks_can_be_added_and_removed _______________

self = <react_test.ReactTest testMethod=test_callbacks_can_be_added_and_removed>

    def test_callbacks_can_be_added_and_removed(self):
        input = InputCell(11)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        cb2_observer = []
        cb3_observer = []
        callback1 = self.callback_factory(cb1_observer)
        callback2 = self.callback_factory(cb2_observer)
        callback3 = self.callback_factory(cb3_observer)
        output.add_callback(callback1)
        output.add_callback(callback2)
        input.value = 31
>       self.assertEqual(cb1_observer[-1], 32)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:164: IndexError
____________ ReactTest.test_callbacks_can_fire_from_multiple_cells _____________

self = <react_test.ReactTest testMethod=test_callbacks_can_fire_from_multiple_cells>

    def test_callbacks_can_fire_from_multiple_cells(self):
        input = InputCell(1)
        plus_one = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        minus_one = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] - 1,
        )
        cb1_observer = []
        cb2_observer = []
        callback1 = self.callback_factory(cb1_observer)
        callback2 = self.callback_factory(cb2_observer)
        plus_one.add_callback(callback1)
        minus_one.add_callback(callback2)
        input.value = 10
>       self.assertEqual(cb1_observer[-1], 11)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:144: IndexError
________ ReactTest.test_callbacks_do_not_report_already_reported_values ________

self = <react_test.ReactTest testMethod=test_callbacks_do_not_report_already_reported_values>

    def test_callbacks_do_not_report_already_reported_values(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 2
>       self.assertEqual(cb1_observer[-1], 3)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:119: IndexError
_ ReactTest.test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change _

self = <react_test.ReactTest testMethod=test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change>

    def test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change(
        self,
    ):
        input = InputCell(1)
        plus_one = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        minus_one1 = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] - 1,
        )
        minus_one2 = ComputeCell(
            [
                minus_one1,
            ],
            lambda inputs: inputs[0] - 1,
        )
        output = ComputeCell(
            [
                plus_one,
                minus_one2,
            ],
            lambda inputs: inputs[0] * inputs[1],
        )
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 4
>       self.assertEqual(cb1_observer[-1], 10)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:229: IndexError
_____________ ReactTest.test_compute_cells_calculate_initial_value _____________

self = <react_test.ReactTest testMethod=test_compute_cells_calculate_initial_value>

    def test_compute_cells_calculate_initial_value(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
>       self.assertEqual(output.value, 2)
E       AssertionError: None != 2

react_test.py:32: AssertionError
________ ReactTest.test_compute_cells_can_depend_on_other_compute_cells ________

self = <react_test.ReactTest testMethod=test_compute_cells_can_depend_on_other_compute_cells>

    def test_compute_cells_can_depend_on_other_compute_cells(self):
        input = InputCell(1)
        times_two = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] * 2,
        )
        times_thirty = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] * 30,
        )
        output = ComputeCell(
            [
                times_two,
                times_thirty,
            ],
            lambda inputs: inputs[0] + inputs[1],
        )
>       self.assertEqual(output.value, 32)
E       AssertionError: None != 32

react_test.py:78: AssertionError
_________________ ReactTest.test_compute_cells_fire_callbacks __________________

self = <react_test.ReactTest testMethod=test_compute_cells_fire_callbacks>

    def test_compute_cells_fire_callbacks(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 3
>       self.assertEqual(cb1_observer[-1], 4)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:94: IndexError
_________ ReactTest.test_compute_cells_take_inputs_in_the_right_order __________

self = <react_test.ReactTest testMethod=test_compute_cells_take_inputs_in_the_right_order>

    def test_compute_cells_take_inputs_in_the_right_order(self):
        one = InputCell(1)
        two = InputCell(2)
        output = ComputeCell(
            [
                one,
                two,
            ],
            lambda inputs: inputs[0] + inputs[1] * 10,
        )
>       self.assertEqual(output.value, 21)
E       AssertionError: None != 21

react_test.py:44: AssertionError
___ ReactTest.test_compute_cells_update_value_when_dependencies_are_changed ____

self = <react_test.ReactTest testMethod=test_compute_cells_update_value_when_dependencies_are_changed>

    def test_compute_cells_update_value_when_dependencies_are_changed(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        input.value = 3
>       self.assertEqual(output.value, 4)
E       AssertionError: None != 4

react_test.py:55: AssertionError
___________________ ReactTest.test_input_cells_have_a_value ____________________

self = <react_test.ReactTest testMethod=test_input_cells_have_a_value>

    def test_input_cells_have_a_value(self):
        input = InputCell(10)
>       self.assertEqual(input.value, 10)
E       AssertionError: None != 10

react_test.py:17: AssertionError
_ ReactTest.test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks _

self = <react_test.ReactTest testMethod=test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks>

    def test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks(
        self,
    ):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        cb2_observer = []
        callback1 = self.callback_factory(cb1_observer)
        callback2 = self.callback_factory(cb2_observer)
        output.add_callback(callback1)
        output.add_callback(callback2)
        output.remove_callback(callback1)
        output.remove_callback(callback1)
        output.remove_callback(callback1)
        input.value = 2
        self.assertEqual(cb1_observer, [])
>       self.assertEqual(cb2_observer[-1], 3)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:194: IndexError
=========================== short test summary info ============================
FAILED react_test.py::ReactTest::test_callback_cells_only_fire_on_change - In...
FAILED react_test.py::ReactTest::test_callbacks_can_be_added_and_removed - In...
FAILED react_test.py::ReactTest::test_callbacks_can_fire_from_multiple_cells
FAILED react_test.py::ReactTest::test_callbacks_do_not_report_already_reported_values
FAILED react_test.py::ReactTest::test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change
FAILED react_test.py::ReactTest::test_compute_cells_calculate_initial_value
FAILED react_test.py::ReactTest::test_compute_cells_can_depend_on_other_compute_cells
FAILED react_test.py::ReactTest::test_compute_cells_fire_callbacks - IndexErr...
FAILED react_test.py::ReactTest::test_compute_cells_take_inputs_in_the_right_order
FAILED react_test.py::ReactTest::test_compute_cells_update_value_when_dependencies_are_changed
FAILED react_test.py::ReactTest::test_input_cells_have_a_value - AssertionErr...
FAILED react_test.py::ReactTest::test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks
========================= 12 failed, 2 passed  =========================

```
#### ============================= test session starts ==============================  
#### platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0  
#### rootdir: react  
#### plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0  
#### collected 14 items  
####   
#### react_test.py .FFFF.FFFFFFFF                                             [100%]  
####   
#### =================================== FAILURES ===================================  
#### ______________ ReactTest.test_callback_cells_only_fire_on_change _______________  
####   
#### self = <react_test.ReactTest testMethod=test_callback_cells_only_fire_on_change>  
####   
####     def test_callback_cells_only_fire_on_change(self):  
####         input = InputCell(1)  
####         output = ComputeCell([input], lambda inputs: 111 if inputs[0] < 3 else 222)  
####         cb1_observer = []  
####         callback1 = self.callback_factory(cb1_observer)  
####         output.add_callback(callback1)  
####         input.value = 2  
####         self.assertEqual(cb1_observer, [])  
####         input.value = 4  
#### >       self.assertEqual(cb1_observer[-1], 222)  
####                          ^^^^^^^^^^^^^^^^  
#### E       IndexError: list index out of range  
####   
#### react_test.py:105: IndexError  
#### ______________ ReactTest.test_callbacks_can_be_added_and_removed _______________  
####   
#### self = <react_test.ReactTest testMethod=test_callbacks_can_be_added_and_removed>  
####   
####     def test_callbacks_can_be_added_and_removed(self):  
####         input = InputCell(11)  
####         output = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
####         cb1_observer = []  
####         cb2_observer = []  
####         cb3_observer = []  
####         callback1 = self.callback_factory(cb1_observer)  
####         callback2 = self.callback_factory(cb2_observer)  
####         callback3 = self.callback_factory(cb3_observer)  
####         output.add_callback(callback1)  
####         output.add_callback(callback2)  
####         input.value = 31  
#### >       self.assertEqual(cb1_observer[-1], 32)  
####                          ^^^^^^^^^^^^^^^^  
#### E       IndexError: list index out of range  
####   
#### react_test.py:164: IndexError  
#### ____________ ReactTest.test_callbacks_can_fire_from_multiple_cells _____________  
####   
#### self = <react_test.ReactTest testMethod=test_callbacks_can_fire_from_multiple_cells>  
####   
####     def test_callbacks_can_fire_from_multiple_cells(self):  
####         input = InputCell(1)  
####         plus_one = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
####         minus_one = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] - 1,  
####         )  
####         cb1_observer = []  
####         cb2_observer = []  
####         callback1 = self.callback_factory(cb1_observer)  
####         callback2 = self.callback_factory(cb2_observer)  
####         plus_one.add_callback(callback1)  
####         minus_one.add_callback(callback2)  
####         input.value = 10  
#### >       self.assertEqual(cb1_observer[-1], 11)  
####                          ^^^^^^^^^^^^^^^^  
#### E       IndexError: list index out of range  
####   
#### react_test.py:144: IndexError  
#### ________ ReactTest.test_callbacks_do_not_report_already_reported_values ________  
####   
#### self = <react_test.ReactTest testMethod=test_callbacks_do_not_report_already_reported_values>  
####   
####     def test_callbacks_do_not_report_already_reported_values(self):  
####         input = InputCell(1)  
####         output = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
####         cb1_observer = []  
####         callback1 = self.callback_factory(cb1_observer)  
####         output.add_callback(callback1)  
####         input.value = 2  
#### >       self.assertEqual(cb1_observer[-1], 3)  
####                          ^^^^^^^^^^^^^^^^  
#### E       IndexError: list index out of range  
####   
#### react_test.py:119: IndexError  
#### _ ReactTest.test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change _  
####   
#### self = <react_test.ReactTest testMethod=test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change>  
####   
####     def test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change(  
####         self,  
####     ):  
####         input = InputCell(1)  
####         plus_one = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
####         minus_one1 = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] - 1,  
####         )  
####         minus_one2 = ComputeCell(  
####             [  
####                 minus_one1,  
####             ],  
####             lambda inputs: inputs[0] - 1,  
####         )  
####         output = ComputeCell(  
####             [  
####                 plus_one,  
####                 minus_one2,  
####             ],  
####             lambda inputs: inputs[0] * inputs[1],  
####         )  
####         cb1_observer = []  
####         callback1 = self.callback_factory(cb1_observer)  
####         output.add_callback(callback1)  
####         input.value = 4  
#### >       self.assertEqual(cb1_observer[-1], 10)  
####                          ^^^^^^^^^^^^^^^^  
#### E       IndexError: list index out of range  
####   
#### react_test.py:229: IndexError  
#### _____________ ReactTest.test_compute_cells_calculate_initial_value _____________  
####   
#### self = <react_test.ReactTest testMethod=test_compute_cells_calculate_initial_value>  
####   
####     def test_compute_cells_calculate_initial_value(self):  
####         input = InputCell(1)  
####         output = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
#### >       self.assertEqual(output.value, 2)  
#### E       AssertionError: None != 2  
####   
#### react_test.py:32: AssertionError  
#### ________ ReactTest.test_compute_cells_can_depend_on_other_compute_cells ________  
####   
#### self = <react_test.ReactTest testMethod=test_compute_cells_can_depend_on_other_compute_cells>  
####   
####     def test_compute_cells_can_depend_on_other_compute_cells(self):  
####         input = InputCell(1)  
####         times_two = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] * 2,  
####         )  
####         times_thirty = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] * 30,  
####         )  
####         output = ComputeCell(  
####             [  
####                 times_two,  
####                 times_thirty,  
####             ],  
####             lambda inputs: inputs[0] + inputs[1],  
####         )  
#### >       self.assertEqual(output.value, 32)  
#### E       AssertionError: None != 32  
####   
#### react_test.py:78: AssertionError  
#### _________________ ReactTest.test_compute_cells_fire_callbacks __________________  
####   
#### self = <react_test.ReactTest testMethod=test_compute_cells_fire_callbacks>  
####   
####     def test_compute_cells_fire_callbacks(self):  
####         input = InputCell(1)  
####         output = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
####         cb1_observer = []  
####         callback1 = self.callback_factory(cb1_observer)  
####         output.add_callback(callback1)  
####         input.value = 3  
#### >       self.assertEqual(cb1_observer[-1], 4)  
####                          ^^^^^^^^^^^^^^^^  
#### E       IndexError: list index out of range  
####   
#### react_test.py:94: IndexError  
#### _________ ReactTest.test_compute_cells_take_inputs_in_the_right_order __________  
####   
#### self = <react_test.ReactTest testMethod=test_compute_cells_take_inputs_in_the_right_order>  
####   
####     def test_compute_cells_take_inputs_in_the_right_order(self):  
####         one = InputCell(1)  
####         two = InputCell(2)  
####         output = ComputeCell(  
####             [  
####                 one,  
####                 two,  
####             ],  
####             lambda inputs: inputs[0] + inputs[1] * 10,  
####         )  
#### >       self.assertEqual(output.value, 21)  
#### E       AssertionError: None != 21  
####   
#### react_test.py:44: AssertionError  
#### ___ ReactTest.test_compute_cells_update_value_when_dependencies_are_changed ____  
####   
#### self = <react_test.ReactTest testMethod=test_compute_cells_update_value_when_dependencies_are_changed>  
####   
####     def test_compute_cells_update_value_when_dependencies_are_changed(self):  
####         input = InputCell(1)  
####         output = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
####         input.value = 3  
#### >       self.assertEqual(output.value, 4)  
#### E       AssertionError: None != 4  
####   
#### react_test.py:55: AssertionError  
#### ___________________ ReactTest.test_input_cells_have_a_value ____________________  
####   
#### self = <react_test.ReactTest testMethod=test_input_cells_have_a_value>  
####   
####     def test_input_cells_have_a_value(self):  
####         input = InputCell(10)  
#### >       self.assertEqual(input.value, 10)  
#### E       AssertionError: None != 10  
####   
#### react_test.py:17: AssertionError  
#### _ ReactTest.test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks _  
####   
#### self = <react_test.ReactTest testMethod=test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks>  
####   
####     def test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks(  
####         self,  
####     ):  
####         input = InputCell(1)  
####         output = ComputeCell(  
####             [  
####                 input,  
####             ],  
####             lambda inputs: inputs[0] + 1,  
####         )  
####         cb1_observer = []  
####         cb2_observer = []  
####         callback1 = self.callback_factory(cb1_observer)  
####         callback2 = self.callback_factory(cb2_observer)  
####         output.add_callback(callback1)  
####         output.add_callback(callback2)  
####         output.remove_callback(callback1)  
####         output.remove_callback(callback1)  
####         output.remove_callback(callback1)  
####         input.value = 2  
####         self.assertEqual(cb1_observer, [])  
#### >       self.assertEqual(cb2_observer[-1], 3)  
####                          ^^^^^^^^^^^^^^^^  
#### E       IndexError: list index out of range  
####   
#### react_test.py:194: IndexError  
#### =========================== short test summary info ============================  
#### FAILED react_test.py::ReactTest::test_callback_cells_only_fire_on_change - In...  
#### FAILED react_test.py::ReactTest::test_callbacks_can_be_added_and_removed - In...  
#### FAILED react_test.py::ReactTest::test_callbacks_can_fire_from_multiple_cells  
#### FAILED react_test.py::ReactTest::test_callbacks_do_not_report_already_reported_values  
#### FAILED react_test.py::ReactTest::test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change  
#### FAILED react_test.py::ReactTest::test_compute_cells_calculate_initial_value  
#### FAILED react_test.py::ReactTest::test_compute_cells_can_depend_on_other_compute_cells  
#### FAILED react_test.py::ReactTest::test_compute_cells_fire_callbacks - IndexErr...  
#### FAILED react_test.py::ReactTest::test_compute_cells_take_inputs_in_the_right_order  
#### FAILED react_test.py::ReactTest::test_compute_cells_update_value_when_dependencies_are_changed  
#### FAILED react_test.py::ReactTest::test_input_cells_have_a_value - AssertionErr...  
#### FAILED react_test.py::ReactTest::test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks  
#### ========================= 12 failed, 2 passed  =========================  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in react.py to resolve the errors.  
> Tokens: 4.8k sent, 16k received.  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: react
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 14 items

react_test.py .FFFF.FFFFFFFF                                             [100%]

=================================== FAILURES ===================================
______________ ReactTest.test_callback_cells_only_fire_on_change _______________

self = <react_test.ReactTest testMethod=test_callback_cells_only_fire_on_change>

    def test_callback_cells_only_fire_on_change(self):
        input = InputCell(1)
        output = ComputeCell([input], lambda inputs: 111 if inputs[0] < 3 else 222)
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 2
        self.assertEqual(cb1_observer, [])
        input.value = 4
>       self.assertEqual(cb1_observer[-1], 222)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:105: IndexError
______________ ReactTest.test_callbacks_can_be_added_and_removed _______________

self = <react_test.ReactTest testMethod=test_callbacks_can_be_added_and_removed>

    def test_callbacks_can_be_added_and_removed(self):
        input = InputCell(11)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        cb2_observer = []
        cb3_observer = []
        callback1 = self.callback_factory(cb1_observer)
        callback2 = self.callback_factory(cb2_observer)
        callback3 = self.callback_factory(cb3_observer)
        output.add_callback(callback1)
        output.add_callback(callback2)
        input.value = 31
>       self.assertEqual(cb1_observer[-1], 32)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:164: IndexError
____________ ReactTest.test_callbacks_can_fire_from_multiple_cells _____________

self = <react_test.ReactTest testMethod=test_callbacks_can_fire_from_multiple_cells>

    def test_callbacks_can_fire_from_multiple_cells(self):
        input = InputCell(1)
        plus_one = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        minus_one = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] - 1,
        )
        cb1_observer = []
        cb2_observer = []
        callback1 = self.callback_factory(cb1_observer)
        callback2 = self.callback_factory(cb2_observer)
        plus_one.add_callback(callback1)
        minus_one.add_callback(callback2)
        input.value = 10
>       self.assertEqual(cb1_observer[-1], 11)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:144: IndexError
________ ReactTest.test_callbacks_do_not_report_already_reported_values ________

self = <react_test.ReactTest testMethod=test_callbacks_do_not_report_already_reported_values>

    def test_callbacks_do_not_report_already_reported_values(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 2
>       self.assertEqual(cb1_observer[-1], 3)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:119: IndexError
_ ReactTest.test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change _

self = <react_test.ReactTest testMethod=test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change>

    def test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change(
        self,
    ):
        input = InputCell(1)
        plus_one = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        minus_one1 = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] - 1,
        )
        minus_one2 = ComputeCell(
            [
                minus_one1,
            ],
            lambda inputs: inputs[0] - 1,
        )
        output = ComputeCell(
            [
                plus_one,
                minus_one2,
            ],
            lambda inputs: inputs[0] * inputs[1],
        )
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 4
>       self.assertEqual(cb1_observer[-1], 10)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:229: IndexError
_____________ ReactTest.test_compute_cells_calculate_initial_value _____________

self = <react_test.ReactTest testMethod=test_compute_cells_calculate_initial_value>

    def test_compute_cells_calculate_initial_value(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
>       self.assertEqual(output.value, 2)
E       AssertionError: None != 2

react_test.py:32: AssertionError
________ ReactTest.test_compute_cells_can_depend_on_other_compute_cells ________

self = <react_test.ReactTest testMethod=test_compute_cells_can_depend_on_other_compute_cells>

    def test_compute_cells_can_depend_on_other_compute_cells(self):
        input = InputCell(1)
        times_two = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] * 2,
        )
        times_thirty = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] * 30,
        )
        output = ComputeCell(
            [
                times_two,
                times_thirty,
            ],
            lambda inputs: inputs[0] + inputs[1],
        )
>       self.assertEqual(output.value, 32)
E       AssertionError: None != 32

react_test.py:78: AssertionError
_________________ ReactTest.test_compute_cells_fire_callbacks __________________

self = <react_test.ReactTest testMethod=test_compute_cells_fire_callbacks>

    def test_compute_cells_fire_callbacks(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        callback1 = self.callback_factory(cb1_observer)
        output.add_callback(callback1)
        input.value = 3
>       self.assertEqual(cb1_observer[-1], 4)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:94: IndexError
_________ ReactTest.test_compute_cells_take_inputs_in_the_right_order __________

self = <react_test.ReactTest testMethod=test_compute_cells_take_inputs_in_the_right_order>

    def test_compute_cells_take_inputs_in_the_right_order(self):
        one = InputCell(1)
        two = InputCell(2)
        output = ComputeCell(
            [
                one,
                two,
            ],
            lambda inputs: inputs[0] + inputs[1] * 10,
        )
>       self.assertEqual(output.value, 21)
E       AssertionError: None != 21

react_test.py:44: AssertionError
___ ReactTest.test_compute_cells_update_value_when_dependencies_are_changed ____

self = <react_test.ReactTest testMethod=test_compute_cells_update_value_when_dependencies_are_changed>

    def test_compute_cells_update_value_when_dependencies_are_changed(self):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        input.value = 3
>       self.assertEqual(output.value, 4)
E       AssertionError: None != 4

react_test.py:55: AssertionError
___________________ ReactTest.test_input_cells_have_a_value ____________________

self = <react_test.ReactTest testMethod=test_input_cells_have_a_value>

    def test_input_cells_have_a_value(self):
        input = InputCell(10)
>       self.assertEqual(input.value, 10)
E       AssertionError: None != 10

react_test.py:17: AssertionError
_ ReactTest.test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks _

self = <react_test.ReactTest testMethod=test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks>

    def test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks(
        self,
    ):
        input = InputCell(1)
        output = ComputeCell(
            [
                input,
            ],
            lambda inputs: inputs[0] + 1,
        )
        cb1_observer = []
        cb2_observer = []
        callback1 = self.callback_factory(cb1_observer)
        callback2 = self.callback_factory(cb2_observer)
        output.add_callback(callback1)
        output.add_callback(callback2)
        output.remove_callback(callback1)
        output.remove_callback(callback1)
        output.remove_callback(callback1)
        input.value = 2
        self.assertEqual(cb1_observer, [])
>       self.assertEqual(cb2_observer[-1], 3)
                         ^^^^^^^^^^^^^^^^
E       IndexError: list index out of range

react_test.py:194: IndexError
=========================== short test summary info ============================
FAILED react_test.py::ReactTest::test_callback_cells_only_fire_on_change - In...
FAILED react_test.py::ReactTest::test_callbacks_can_be_added_and_removed - In...
FAILED react_test.py::ReactTest::test_callbacks_can_fire_from_multiple_cells
FAILED react_test.py::ReactTest::test_callbacks_do_not_report_already_reported_values
FAILED react_test.py::ReactTest::test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change
FAILED react_test.py::ReactTest::test_compute_cells_calculate_initial_value
FAILED react_test.py::ReactTest::test_compute_cells_can_depend_on_other_compute_cells
FAILED react_test.py::ReactTest::test_compute_cells_fire_callbacks - IndexErr...
FAILED react_test.py::ReactTest::test_compute_cells_take_inputs_in_the_right_order
FAILED react_test.py::ReactTest::test_compute_cells_update_value_when_dependencies_are_changed
FAILED react_test.py::ReactTest::test_input_cells_have_a_value - AssertionErr...
FAILED react_test.py::ReactTest::test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks
========================= 12 failed, 2 passed  =========================

```