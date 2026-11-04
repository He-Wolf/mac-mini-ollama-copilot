
# aider chat started at 2026-11-04 15:40:50

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-flash-next-gyro-gyro-s with diff edit format, reasoning none  
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

To implement the reactive system, we need to replace the stub implementations in `react.py` with full logic.

1.  **InputCell**: Needs a setter method (`set_value`) that updates its value and triggers propagation through dependent compute cells.
2.  **ComputeCell**: Needs to store inputs and the compute function. It needs to calculate its value based on inputs. It needs to manage callbacks, calling them only when the stable state changes after an update cycle.
3.  **Propagation Logic**: When an input cell changes, we need to recalculate all dependent compute cells. To ensure callbacks are called correctly (only once per stable state change), we should collect all affected compute cells, calculate their new values, and then compare against old values before firing callbacks.

Here is the implementation:

react.py
```python
<<<<<<< SEARCH
class InputCell:
    def __init__(self, initial_value):
        self.value = None


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.value = None

    def add_callback(self, callback):
        pass

    def remove_callback(self, callback):
        pass
=======
class InputCell:
    def __init__(self, initial_value):
        self.value = initial_value
        self._dependents = []

    def set_value(self, new_value):
        if self.value == new_value:
            return
        self.value = new_value
        # Propagate changes to all dependent compute cells
        for cell in self._dependents:
            cell.update()


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])

        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
                input_cell._dependents.append(self)

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def remove_callback(self, callback):
        if callback in self.callbacks:
            self.callbacks.remove(callback)

    def update(self):
        old_value = self.value
        new_value = self.compute_function([i.value for i in self.inputs])
        
        # If the value hasn't changed, no need to propagate further or fire callbacks
        if new_value == old_value:
            return
        
        self.value = new_value
        
        # Propagate to dependents first to ensure stable state is reached
        # before firing callbacks. This prevents intermediate states from triggering callbacks.
        for cell in self._dependents:
            cell.update()

        # Fire callbacks only if the value changed in this update cycle
        # Note: We fire callbacks after propagating to dependents so that
        # nested compute cells have their final values before we notify listeners.
        # However, standard reactive systems often fire callbacks immediately upon change.
        # The requirement says "Call a cell’s callbacks when the cell’s value in a new stable state has changed".
        # To achieve this properly without firing multiple times for intermediate states,
        # we need to track changes across the whole graph.
        
        # A simpler approach that satisfies "stable state" is to defer callback firing
        # until all updates are done. But since InputCell.set_value triggers update() recursively,
        # we can fire callbacks here if we ensure we don't fire for intermediate states.
        # Actually, if we fire immediately, a dependent cell might change again later in the same propagation.
        # To strictly follow "stable state", we should collect changes and fire at the end.
        
        # Let's implement a deferred callback firing mechanism.
        # We'll mark that this cell changed, and let the root trigger handle callbacks.
        # But InputCell doesn't know about all cells.
        
        # Alternative: Fire callbacks immediately but ensure we only fire once per set_value call.
        # This is tricky with recursion.
        
        # Let's use a global-ish approach within the propagation context.
        # Since Python doesn't have thread-local storage easily without imports,
        # and we want to keep it simple, let's look at how tests usually expect this.
        # Usually, callbacks are fired after the entire graph stabilizes.
        
        # We can modify InputCell.set_value to collect all changed cells and fire callbacks at the end.
        # But ComputeCell.update is called by InputCell.
        
        # Let's refactor slightly: InputCell.set_value will trigger a propagation that collects changes.
        # We'll add a helper method or manage state in InputCell.
        
        # Actually, the simplest correct implementation for "stable state" callbacks:
        # 1. Update values recursively.
        # 2. Collect all cells whose value changed during this update.
        # 3. Fire callbacks for those cells.
        
        # We need to pass a "change tracker" through the update chain.
        # Let's modify InputCell.set_value to do this.
        
        # For now, let's assume immediate firing is acceptable if we prevent double-firing?
        # No, "stable state" implies waiting for all dependencies to settle.
        
        # I will implement a deferred callback system using a list of changed cells passed down.
        # But the signature of update() doesn't allow passing extra args easily without changing API.
        # Let's use an instance variable on InputCell to track changes during a set_value call.
        
        # Wait, ComputeCell can be dependent on other ComputeCells.
        # So we need a way to propagate "this is part of a batch update".
        
        # Let's add a `_pending_callbacks` list to the root InputCell? No, InputCell doesn't know all cells.
        
        # Better approach: Use a global variable or class-level state for the current propagation cycle.
        # Since we can't use globals easily in a clean way, let's attach the change tracker to the InputCell instance during set_value.
        
        # Actually, let's just fire callbacks immediately after updating self.value, but BEFORE propagating to dependents?
        # No, if a dependent changes later, the state isn't stable yet.
        
        # Correct approach:
        # 1. Recursively update all values.
        # 2. Track which cells changed.
        # 3. Fire callbacks for tracked cells.
        
        # We can do this by having InputCell.set_value collect changes.
        # But ComputeCell.update is called by InputCell._dependents.
        
        # Let's modify the design slightly:
        # InputCell.set_value will call a helper that propagates and collects changes.
        # ComputeCell.update will return whether it changed, or we track it via a shared list.
        
        # Since I cannot change signatures arbitrarily if tests rely on them, I'll stick to standard methods.
        # I'll use a private attribute `_changed_cells` on InputCell during set_value.
        
        # But ComputeCell doesn't know which InputCell triggered the update.
        
        # Let's try a different tactic: Fire callbacks immediately, but ensure we don't fire for intermediate states by checking if the value changed *from the last stable state*.
        # This requires storing the "last stable value".
        
        # Actually, the standard way is:
        # - Update all values.
        # - Compare new values to old values.
        # - Fire callbacks.
        
        # To do this without complex plumbing, we can use a class-level list for pending callbacks during an update cycle.
        # But that's not thread-safe or clean.
        
        # Let's implement it by having InputCell.set_value manage the propagation and callback firing.
        # We'll add a method `_propagate_and_notify` to InputCell? No, tests might call set_value directly.
        
        # Okay, I will implement `update()` in ComputeCell to just update value and propagate.
        # And I will modify `InputCell.set_value` to collect all affected cells and fire callbacks at the end.
        
        # To do this, InputCell needs to know all downstream cells. It only knows direct dependents.
        # We can recursively gather them.
        
        # Let's implement it cleanly:
        
        # 1. ComputeCell.update() updates value and propagates.
        # 2. InputCell.set_value() triggers propagation, collects changed cells, fires callbacks.
        
        # To collect changed cells, we need to know which ones changed during the propagation triggered by set_value.
        # We can use a temporary list attached to the InputCell instance during the call.
        
        # Let's rewrite the classes properly.
>>>>>>> REPLACE
```

react.py
```python
<<<<<<< SEARCH
class InputCell:
    def __init__(self, initial_value):
        self.value = None


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.value = None

    def add_callback(self, callback):
        pass

    def remove_callback(self, callback):
        pass
=======
class InputCell:
    def __init__(self, initial_value):
        self.value = initial_value
        self._dependents = []

    def set_value(self, new_value):
        if self.value == new_value:
            return
        
        self.value = new_value
        
        # Collect all cells that will be updated
        changed_cells = []
        
        # Propagate updates and collect changes
        for cell in self._dependents:
            self._propagate(cell, changed_cells)
            
        # Fire callbacks for cells whose value changed
        for cell in changed_cells:
            for callback in cell.callbacks:
                callback(cell.value)

    def _propagate(self, cell, changed_cells):
        old_value = cell.value
        new_value = cell.compute_function([i.value for i in cell.inputs])
        
        if new_value != old_value:
            cell.value = new_value
            changed_cells.append(cell)
            
            # Propagate to dependents
            for dependent in cell._dependents:
                self._propagate(dependent, changed_cells)


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])

        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
                input_cell._dependents.append(self)

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def remove_callback(self, callback):
        if callback in self.callbacks:
            self.callbacks.remove(callback)
>>>>>>> REPLACE
```

> Tokens: 2.3k sent, 2.4k received.  
> The LLM did not conform to the edit format.  
> https://aider.chat/docs/troubleshooting/edit-errors.html  
> # 1 SEARCH/REPLACE block failed to match!

## SearchReplaceNoExactMatch: This SEARCH block failed to exactly match lines in react.py
<<<<<<< SEARCH
class InputCell:
    def __init__(self, initial_value):
        self.value = None


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.value = None

    def add_callback(self, callback):
        pass

    def remove_callback(self, callback):
        pass
=======
class InputCell:
    def __init__(self, initial_value):
        self.value = initial_value
        self._dependents = []

    def set_value(self, new_value):
        if self.value == new_value:
            return
        
        self.value = new_value
        
        # Collect all cells that will be updated
        changed_cells = []
        
        # Propagate updates and collect changes
        for cell in self._dependents:
            self._propagate(cell, changed_cells)
            
        # Fire callbacks for cells whose value changed
        for cell in changed_cells:
            for callback in cell.callbacks:
                callback(cell.value)

    def _propagate(self, cell, changed_cells):
        old_value = cell.value
        new_value = cell.compute_function([i.value for i in cell.inputs])
        
        if new_value != old_value:
            cell.value = new_value
            changed_cells.append(cell)
            
            # Propagate to dependents
            for dependent in cell._dependents:
                self._propagate(dependent, changed_cells)


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])

        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
                input_cell._dependents.append(self)

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def remove_callback(self, callback):
        if callback in self.callbacks:
            self.callbacks.remove(callback)
>>>>>>> REPLACE

The SEARCH section must exactly match an existing block of lines including all white space, comments, indentation, docstrings, etc

# The other 1 SEARCH/REPLACE block were applied successfully.
Don't re-send them.
Just reply with fixed versions of the block above that failed to match.  

The previous `InputCell` implementation was incomplete and lacked the logic to properly handle callbacks in a stable state. The current file has a messy `ComputeCell.update` method with lots of comments but no actual callback firing logic, and `InputCell.set_value` calls `cell.update()` which doesn't fire callbacks correctly for stable states.

I will replace the entire content of `react.py` with a clean implementation that:
1.  Properly propagates changes from `InputCell`.
2.  Collects all changed cells during propagation.
3.  Fires callbacks only after the system reaches a stable state (i.e., after all dependent values have been updated).

react.py
```python
<<<<<<< SEARCH
class InputCell:
    def __init__(self, initial_value):
        self.value = initial_value
        self._dependents = []

    def set_value(self, new_value):
        if self.value == new_value:
            return
        self.value = new_value
        # Propagate changes to all dependent compute cells
        for cell in self._dependents:
            cell.update()


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])

        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
                input_cell._dependents.append(self)

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def remove_callback(self, callback):
        if callback in self.callbacks:
            self.callbacks.remove(callback)

    def update(self):
        old_value = self.value
        new_value = self.compute_function([i.value for i in self.inputs])
        
        # If the value hasn't changed, no need to propagate further or fire callbacks
        if new_value == old_value:
            return
        
        self.value = new_value
        
        # Propagate to dependents first to ensure stable state is reached
        # before firing callbacks. This prevents intermediate states from triggering callbacks.
        for cell in self._dependents:
            cell.update()

        # Fire callbacks only if the value changed in this update cycle
        # Note: We fire callbacks after propagating to dependents so that
        # nested compute cells have their final values before we notify listeners.
        # However, standard reactive systems often fire callbacks immediately upon change.
        # The requirement says "Call a cell’s callbacks when the cell’s value in a new stable state has changed".
        # To achieve this properly without firing multiple times for intermediate states,
        # we need to track changes across the whole graph.
        
        # A simpler approach that satisfies "stable state" is to defer callback firing
        # until all updates are done. But since InputCell.set_value triggers update() recursively,
        # we can fire callbacks here if we ensure we don't fire for intermediate states.
        # Actually, if we fire immediately, a dependent cell might change again later in the same propagation.
        # To strictly follow "stable state", we should collect changes and fire at the end.
        
        # Let's implement a deferred callback firing mechanism.
        # We'll mark that this cell changed, and let the root trigger handle callbacks.
        # But InputCell doesn't know about all cells.
        
        # Alternative: Fire callbacks immediately but ensure we only fire once per set_value call.
        # This is tricky with recursion.
        
        # Let's use a global-ish approach within the propagation context.
        # Since Python doesn't have thread-local storage easily without imports,
        # and we want to keep it simple, let's look at how tests usually expect this.
        # Usually, callbacks are fired after the entire graph stabilizes.
        
        # We can modify InputCell.set_value to collect all changed cells and fire callbacks at the end.
        # But ComputeCell.update is called by InputCell.
        
        # Let's refactor slightly: InputCell.set_value will trigger a propagation that collects changes.
        # We'll add a helper method or manage state in InputCell.
        
        # Actually, the simplest correct implementation for "stable state" callbacks:
        # 1. Update values recursively.
        # 2. Collect all cells whose value changed during this update.
        # 3. Fire callbacks for those cells.
        
        # We need to pass a "change tracker" through the update chain.
        # Let's modify InputCell.set_value to do this.
        
        # For now, let's assume immediate firing is acceptable if we prevent double-firing?
        # No, "stable state" implies waiting for all dependencies to settle.
        
        # I will implement a deferred callback system using a list of changed cells passed down.
        # But the signature of update() doesn't allow passing extra args easily without changing API.
        # Let's use an instance variable on InputCell to track changes during a set_value call.
        
        # Wait, ComputeCell can be dependent on other ComputeCells.
        # So we need a way to propagate "this is part of a batch update".
        
        # Let's add a `_pending_callbacks` list to the root InputCell? No, InputCell doesn't know all cells.
        
        # Better approach: Use a global variable or class-level state for the current propagation cycle.
        # Since we can't use globals easily in a clean way, let's attach the change tracker to the InputCell instance during set_value.
        
        # Actually, let's just fire callbacks immediately after updating self.value, but BEFORE propagating to dependents?
        # No, if a dependent changes later, the state isn't stable yet.
        
        # Correct approach:
        # 1. Recursively update all values.
        # 2. Track which cells changed.
        # 3. Fire callbacks for tracked cells.
        
        # We can do this by having InputCell.set_value collect changes.
        # But ComputeCell.update is called by InputCell._dependents.
        
        # Let's modify the design slightly:
        # InputCell.set_value will call a helper that propagates and collects changes.
        # ComputeCell.update will return whether it changed, or we track it via a shared list.
        
        # Since I cannot change signatures arbitrarily if tests rely on them, I'll stick to standard methods.
        # I'll use a private attribute `_changed_cells` on InputCell during set_value.
        
        # But ComputeCell doesn't know which InputCell triggered the update.
        
        # Let's try a different tactic: Fire callbacks immediately, but ensure we don't fire for intermediate states by checking if the value changed *from the last stable state*.
        # This requires storing the "last stable value".
        
        # Actually, the standard way is:
        # - Update all values.
        # - Compare new values to old values.
        # - Fire callbacks.
        
        # To do this without complex plumbing, we can use a class-level list for pending callbacks during an update cycle.
        # But that's not thread-safe or clean.
        
        # Let's implement it by having InputCell.set_value manage the propagation and callback firing.
        # We'll add a method `_propagate_and_notify` to InputCell? No, tests might call set_value directly.
        
        # Okay, I will implement `update()` in ComputeCell to just update value and propagate.
        # And I will modify `InputCell.set_value` to collect all affected cells and fire callbacks at the end.
        
        # To do this, InputCell needs to know all downstream cells. It only knows direct dependents.
        # We can recursively gather them.
        
        # Let's implement it cleanly:
        
        # 1. ComputeCell.update() updates value and propagates.
        # 2. InputCell.set_value() triggers propagation, collects changed cells, fires callbacks.
        
        # To collect changed cells, we need to know which ones changed during the propagation triggered by set_value.
        # We can use a temporary list attached to the InputCell instance during the call.
        
        # Let's rewrite the classes properly.
    
=======
class InputCell:
    def __init__(self, initial_value):
        self.value = initial_value
        self._dependents = []

    def set_value(self, new_value):
        if self.value == new_value:
            return
        
        self.value = new_value
        
        # Collect all cells that will be updated
        changed_cells = []
        
        # Propagate updates and collect changes
        for cell in self._dependents:
            self._propagate(cell, changed_cells)
            
        # Fire callbacks for cells whose value changed
        for cell in changed_cells:
            for callback in cell.callbacks:
                callback(cell.value)

    def _propagate(self, cell, changed_cells):
        old_value = cell.value
        new_value = cell.compute_function([i.value for i in cell.inputs])
        
        if new_value != old_value:
            cell.value = new_value
            changed_cells.append(cell)
            
            # Propagate to dependents
            for dependent in cell._dependents:
                self._propagate(dependent, changed_cells)


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])

        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
                input_cell._dependents.append(self)

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def remove_callback(self, callback):
        if callback in self.callbacks:
            self.callbacks.remove(callback)
>>>>>>> REPLACE
```

> Tokens: 6.8k sent, 2.2k received.  
> Applied edit to react.py  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: react
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 14 items

react_test.py .FFFFFF.FF.F.F                                             [100%]

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
_ ReactTest.test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change _

self = <react_test.ReactTest testMethod=test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change>

    def test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change(
        self,
    ):
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
>       always_two = ComputeCell(
            [
                plus_one,
                minus_one,
            ],
            lambda inputs: inputs[0] - inputs[1],
        )

react_test.py:247: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <react.ComputeCell object at 0x7a5f4c868b50>
inputs = [<react.ComputeCell object at 0x7a5f4c869010>, <react.ComputeCell object at 0x7a5f4c86a390>]
compute_function = <function ReactTest.test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change.<locals>.<lambda> at 0x7a5f4cb6cf40>

    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])
    
        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
>               input_cell._dependents.append(self)
                ^^^^^^^^^^^^^^^^^^^^^^
E               AttributeError: 'ComputeCell' object has no attribute '_dependents'

react.py:49: AttributeError
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
>       minus_one2 = ComputeCell(
            [
                minus_one1,
            ],
            lambda inputs: inputs[0] - 1,
        )

react_test.py:212: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <react.ComputeCell object at 0x7a5f4c884910>
inputs = [<react.ComputeCell object at 0x7a5f4c884090>]
compute_function = <function ReactTest.test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change.<locals>.<lambda> at 0x7a5f4cb6cc20>

    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])
    
        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
>               input_cell._dependents.append(self)
                ^^^^^^^^^^^^^^^^^^^^^^
E               AttributeError: 'ComputeCell' object has no attribute '_dependents'

react.py:49: AttributeError
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
>       output = ComputeCell(
            [
                times_two,
                times_thirty,
            ],
            lambda inputs: inputs[0] + inputs[1],
        )

react_test.py:71: 
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

self = <react.ComputeCell object at 0x7a5f4c867550>
inputs = [<react.ComputeCell object at 0x7a5f4c866b10>, <react.ComputeCell object at 0x7a5f4c866f10>]
compute_function = <function ReactTest.test_compute_cells_can_depend_on_other_compute_cells.<locals>.<lambda> at 0x7a5f4cb6d620>

    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])
    
        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
>               input_cell._dependents.append(self)
                ^^^^^^^^^^^^^^^^^^^^^^
E               AttributeError: 'ComputeCell' object has no attribute '_dependents'

react.py:49: AttributeError
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
E       AssertionError: 2 != 4

react_test.py:55: AssertionError
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
FAILED react_test.py::ReactTest::test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change
FAILED react_test.py::ReactTest::test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change
FAILED react_test.py::ReactTest::test_compute_cells_can_depend_on_other_compute_cells
FAILED react_test.py::ReactTest::test_compute_cells_fire_callbacks - IndexErr...
FAILED react_test.py::ReactTest::test_compute_cells_update_value_when_dependencies_are_changed
FAILED react_test.py::ReactTest::test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks
========================= 10 failed, 4 passed  =========================

```
#### ============================= test session starts ==============================  
#### platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0  
#### rootdir: react  
#### plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0  
#### collected 14 items  
####   
#### react_test.py .FFFFFF.FF.F.F                                             [100%]  
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
#### _ ReactTest.test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change _  
####   
#### self = <react_test.ReactTest testMethod=test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change>  
####   
####     def test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change(  
####         self,  
####     ):  
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
#### >       always_two = ComputeCell(  
####             [  
####                 plus_one,  
####                 minus_one,  
####             ],  
####             lambda inputs: inputs[0] - inputs[1],  
####         )  
####   
#### react_test.py:247:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <react.ComputeCell object at 0x7a5f4c868b50>  
#### inputs = [<react.ComputeCell object at 0x7a5f4c869010>, <react.ComputeCell object at 0x7a5f4c86a390>]  
#### compute_function = <function ReactTest.test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change.<locals>.<lambda> at 0x7a5f4cb6cf40>  
####   
####     def __init__(self, inputs, compute_function):  
####         self.inputs = inputs  
####         self.compute_function = compute_function  
####         self.callbacks = []  
####         self.value = self.compute_function([i.value for i in inputs])  
####       
####         # Register this cell as a dependent of each input cell  
####         for input_cell in inputs:  
####             if isinstance(input_cell, InputCell):  
####                 input_cell._dependents.append(self)  
####             elif isinstance(input_cell, ComputeCell):  
#### >               input_cell._dependents.append(self)  
####                 ^^^^^^^^^^^^^^^^^^^^^^  
#### E               AttributeError: 'ComputeCell' object has no attribute '_dependents'  
####   
#### react.py:49: AttributeError  
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
#### >       minus_one2 = ComputeCell(  
####             [  
####                 minus_one1,  
####             ],  
####             lambda inputs: inputs[0] - 1,  
####         )  
####   
#### react_test.py:212:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <react.ComputeCell object at 0x7a5f4c884910>  
#### inputs = [<react.ComputeCell object at 0x7a5f4c884090>]  
#### compute_function = <function ReactTest.test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change.<locals>.<lambda> at 0x7a5f4cb6cc20>  
####   
####     def __init__(self, inputs, compute_function):  
####         self.inputs = inputs  
####         self.compute_function = compute_function  
####         self.callbacks = []  
####         self.value = self.compute_function([i.value for i in inputs])  
####       
####         # Register this cell as a dependent of each input cell  
####         for input_cell in inputs:  
####             if isinstance(input_cell, InputCell):  
####                 input_cell._dependents.append(self)  
####             elif isinstance(input_cell, ComputeCell):  
#### >               input_cell._dependents.append(self)  
####                 ^^^^^^^^^^^^^^^^^^^^^^  
#### E               AttributeError: 'ComputeCell' object has no attribute '_dependents'  
####   
#### react.py:49: AttributeError  
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
#### >       output = ComputeCell(  
####             [  
####                 times_two,  
####                 times_thirty,  
####             ],  
####             lambda inputs: inputs[0] + inputs[1],  
####         )  
####   
#### react_test.py:71:   
#### _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _   
####   
#### self = <react.ComputeCell object at 0x7a5f4c867550>  
#### inputs = [<react.ComputeCell object at 0x7a5f4c866b10>, <react.ComputeCell object at 0x7a5f4c866f10>]  
#### compute_function = <function ReactTest.test_compute_cells_can_depend_on_other_compute_cells.<locals>.<lambda> at 0x7a5f4cb6d620>  
####   
####     def __init__(self, inputs, compute_function):  
####         self.inputs = inputs  
####         self.compute_function = compute_function  
####         self.callbacks = []  
####         self.value = self.compute_function([i.value for i in inputs])  
####       
####         # Register this cell as a dependent of each input cell  
####         for input_cell in inputs:  
####             if isinstance(input_cell, InputCell):  
####                 input_cell._dependents.append(self)  
####             elif isinstance(input_cell, ComputeCell):  
#### >               input_cell._dependents.append(self)  
####                 ^^^^^^^^^^^^^^^^^^^^^^  
#### E               AttributeError: 'ComputeCell' object has no attribute '_dependents'  
####   
#### react.py:49: AttributeError  
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
#### E       AssertionError: 2 != 4  
####   
#### react_test.py:55: AssertionError  
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
#### FAILED react_test.py::ReactTest::test_callbacks_should_not_be_called_if_dependencies_change_but_output_value_doesn_t_change  
#### FAILED react_test.py::ReactTest::test_callbacks_should_only_be_called_once_even_if_multiple_dependencies_change  
#### FAILED react_test.py::ReactTest::test_compute_cells_can_depend_on_other_compute_cells  
#### FAILED react_test.py::ReactTest::test_compute_cells_fire_callbacks - IndexErr...  
#### FAILED react_test.py::ReactTest::test_compute_cells_update_value_when_dependencies_are_changed  
#### FAILED react_test.py::ReactTest::test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks  
#### ========================= 10 failed, 4 passed  =========================  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in react.py to resolve the errors.  

The tests are failing because:
1.  `ComputeCell` is missing the `_dependents` attribute, causing `AttributeError` when other cells try to register themselves as dependents.
2.  The propagation logic in `InputCell.set_value` relies on `_propagate`, but `ComputeCell` doesn't have a way to be updated directly if it's not triggered by an `InputCell`. However, the main issue is that `ComputeCell` needs `_dependents` initialized in `__init__`.
3.  The callback firing logic seems correct in structure (collecting changes then firing), but since `ComputeCell` lacks `_dependents`, the graph isn't fully connected for nested compute cells.

I will fix `ComputeCell.__init__` to initialize `_dependents` and ensure the propagation logic works correctly for nested dependencies.

react.py
```python
<<<<<<< SEARCH
class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self.value = self.compute_function([i.value for i in inputs])

        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
                input_cell._dependents.append(self)
=======
class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = []
        self._dependents = []
        self.value = self.compute_function([i.value for i in inputs])

        # Register this cell as a dependent of each input cell
        for input_cell in inputs:
            if isinstance(input_cell, InputCell):
                input_cell._dependents.append(self)
            elif isinstance(input_cell, ComputeCell):
                input_cell._dependents.append(self)
>>>>>>> REPLACE
```

> Tokens: 11k sent, 431 received.  
> Applied edit to react.py  
```
============================= test session starts ==============================
platform linux -- Python 3.11.18, pytest-9.0.2, pluggy-1.6.0
rootdir: react
plugins: env-1.6.0, anyio-4.12.1, cov-7.0.0
collected 14 items

react_test.py .FFFF.F.FF.F.F                                             [100%]

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
        self.assertEqual(output.value, 32)
        input.value = 3
>       self.assertEqual(output.value, 96)
E       AssertionError: 32 != 96

react_test.py:80: AssertionError
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
E       AssertionError: 2 != 4

react_test.py:55: AssertionError
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
FAILED react_test.py::ReactTest::test_compute_cells_can_depend_on_other_compute_cells
FAILED react_test.py::ReactTest::test_compute_cells_fire_callbacks - IndexErr...
FAILED react_test.py::ReactTest::test_compute_cells_update_value_when_dependencies_are_changed
FAILED react_test.py::ReactTest::test_removing_a_callback_multiple_times_doesn_t_interfere_with_other_callbacks
========================= 9 failed, 5 passed  ==========================

```