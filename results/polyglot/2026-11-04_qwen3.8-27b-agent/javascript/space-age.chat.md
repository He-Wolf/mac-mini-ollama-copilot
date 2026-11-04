
# aider chat started at 2026-11-04 18:03:32

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-27b-agent with diff edit format, reasoning none  
> Git repo: none  
> Repo-map: disabled  
> Added space-age.js to the chat.  

#### # Introduction  
####   
#### The year is 2525 and you've just embarked on a journey to visit all planets in the Solar System (Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus and Neptune).  
#### The first stop is Mercury, where customs require you to fill out a form (bureaucracy is apparently _not_ Earth-specific).  
#### As you hand over the form to the customs officer, they scrutinize it and frown.  
#### "Do you _really_ expect me to believe you're just 50 years old?  
#### You must be closer to 200 years old!"  
####   
#### Amused, you wait for the customs officer to start laughing, but they appear to be dead serious.  
#### You realize that you've entered your age in _Earth years_, but the officer expected it in _Mercury years_!  
#### As Mercury's orbital period around the sun is significantly shorter than Earth, you're actually a lot older in Mercury years.  
#### After some quick calculations, you're able to provide your age in Mercury Years.  
#### The customs officer smiles, satisfied, and waves you through.  
#### You make a mental note to pre-calculate your planet-specific age _before_ future customs checks, to avoid such mix-ups.  
####   
#### ~~~~exercism/note  
#### If you're wondering why Pluto didn't make the cut, go watch [this YouTube video][pluto-video].  
####   
#### [pluto-video]: https://www.youtube.com/watch?v=Z_2gbGXzFbs  
#### ~~~~  
#### # Instructions  
####   
#### Given an age in seconds, calculate how old someone would be on a planet in our Solar System.  
####   
#### One Earth year equals 365.25 Earth days, or 31,557,600 seconds.  
#### If you were told someone was 1,000,000,000 seconds old, their age would be 31.69 Earth-years.  
####   
#### For the other planets, you have to account for their orbital period in Earth Years:  
####   
#### | Planet  | Orbital period in Earth Years |  
#### | ------- | ----------------------------- |  
#### | Mercury | 0.2408467                     |  
#### | Venus   | 0.61519726                    |  
#### | Earth   | 1.0                           |  
#### | Mars    | 1.8808158                     |  
#### | Jupiter | 11.862615                     |  
#### | Saturn  | 29.447498                     |  
#### | Uranus  | 84.016846                     |  
#### | Neptune | 164.79132                     |  
####   
#### ~~~~exercism/note  
#### The actual length of one complete orbit of the Earth around the sun is closer to 365.256 days (1 sidereal year).  
#### The Gregorian calendar has, on average, 365.2425 days.  
#### While not entirely accurate, 365.25 is the value used in this exercise.  
#### See [Year on Wikipedia][year] for more ways to measure a year.  
####   
#### [year]: https://en.wikipedia.org/wiki/Year#Summary  
#### ~~~~  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: space-age.js  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

To implement the `age` function in `space-age.js`, we need to:
1. Define the orbital periods for each planet in Earth years.
2. Calculate the age in Earth years from the given seconds.
3. Divide the Earth years by the planet's orbital period to get the age on that planet.
4. Round the result to 2 decimal places.

Here is the *SEARCH/REPLACE* block for `space-age.js`:

space-age.js
```javascript
<<<<<<< SEARCH
//
// This is only a SKELETON file for the 'Space Age' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const age = () => {
  throw new Error('Remove this statement and implement this function');
};
=======
//
// This is only a SKELETON file for the 'Space Age' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const EARTH_YEAR_IN_SECONDS = 31557600;

const PLANET_ORBITAL_PERIODS = {
  mercury: 0.2408467,
  venus: 0.61519726,
  earth: 1.0,
  mars: 1.8808158,
  jupiter: 11.862615,
  saturn: 29.447498,
  uranus: 84.016846,
  neptune: 164.79132,
};

export const age = (seconds, planet = 'earth') => {
  const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
  const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
  
  if (orbitalPeriod === undefined) {
    throw new Error('invalid planet');
  }
  
  return Math.round((earthYears / orbitalPeriod) * 100) / 100;
};
>>>>>>> REPLACE
```

> Tokens: 2.8k sent, 462 received.  
> Applied edit to space-age.js  
```

> test
> jest ./*

FAIL ./space-age.spec.js
  Space Age
    ✕ age on Earth (2 ms)
    ✕ age on Mercury (1 ms)
    ✕ age on Venus
    ✕ age on Mars
    ✕ age on Jupiter (1 ms)
    ✕ age on Saturn (1 ms)
    ✕ age on Uranus
    ✕ age on Neptune

  ● Space Age › age on Earth

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:5:15)

  ● Space Age › age on Mercury

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:9:15)

  ● Space Age › age on Venus

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:13:15)

  ● Space Age › age on Mars

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:17:15)

  ● Space Age › age on Jupiter

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:21:15)

  ● Space Age › age on Saturn

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:25:15)

  ● Space Age › age on Uranus

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:29:15)

  ● Space Age › age on Neptune

    TypeError: planet.toLowerCase is not a function

      19 | export const age = (seconds, planet = 'earth') => {
      20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
    > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
         |                                                       ^
      22 |   
      23 |   if (orbitalPeriod === undefined) {
      24 |     throw new Error('invalid planet');

      at toLowerCase (space-age.js:21:55)
      at Object.<anonymous> (space-age.spec.js:33:15)

Test Suites: 1 failed, 1 total
Tests:       8 failed, 8 total
Snapshots:   0 total
Time:        0.477 s
Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./space-age.js|./space-age.spec.js.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./space-age.spec.js  
####   Space Age  
####     ✕ age on Earth (2 ms)  
####     ✕ age on Mercury (1 ms)  
####     ✕ age on Venus  
####     ✕ age on Mars  
####     ✕ age on Jupiter (1 ms)  
####     ✕ age on Saturn (1 ms)  
####     ✕ age on Uranus  
####     ✕ age on Neptune  
####   
####   ● Space Age › age on Earth  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:5:15)  
####   
####   ● Space Age › age on Mercury  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:9:15)  
####   
####   ● Space Age › age on Venus  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:13:15)  
####   
####   ● Space Age › age on Mars  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:17:15)  
####   
####   ● Space Age › age on Jupiter  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:21:15)  
####   
####   ● Space Age › age on Saturn  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:25:15)  
####   
####   ● Space Age › age on Uranus  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:29:15)  
####   
####   ● Space Age › age on Neptune  
####   
####     TypeError: planet.toLowerCase is not a function  
####   
####       19 | export const age = (seconds, planet = 'earth') => {  
####       20 |   const earthYears = seconds / EARTH_YEAR_IN_SECONDS;  
####     > 21 |   const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];  
####          |                                                       ^  
####       22 |     
####       23 |   if (orbitalPeriod === undefined) {  
####       24 |     throw new Error('invalid planet');  
####   
####       at toLowerCase (space-age.js:21:55)  
####       at Object.<anonymous> (space-age.spec.js:33:15)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       8 failed, 8 total  
#### Snapshots:   0 total  
#### Time:        0.477 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./space-age.js|./space-age.spec.js.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in space-age.js to resolve the errors.  

To fix the errors, we need to handle the case where `planet` is not a string (or is undefined/null) before calling `.toLowerCase()`. The tests likely pass a string, but the error `planet.toLowerCase is not a function` suggests that in some cases `planet` might not be a string, or perhaps the default parameter isn't being used as expected in the test environment, or the tests are passing something else. However, looking at the error trace, it seems `planet` is not a string.

Wait, looking at the test file `space-age.spec.js` (which I don't have, but can infer from the error), the tests are likely calling `age(seconds, 'Earth')` or similar. The error `planet.toLowerCase is not a function` implies `planet` is not a string.

Let's look at the `age` function signature: `export const age = (seconds, planet = 'earth') => {`.
If the tests are calling `age(1000000000, 'Earth')`, then `planet` is `'Earth'`, which is a string.
Why would `planet.toLowerCase` fail?
Maybe the tests are calling `age(1000000000)` and expecting it to default to Earth?
If `planet` is undefined, the default `'earth'` should kick in.
Unless... the tests are passing `null` or `undefined` explicitly? `age(1000000000, undefined)` would use the default. `age(1000000000, null)` would NOT use the default, and `null.toLowerCase` would fail.

Let's assume the tests might be passing `null` or the function signature needs to be more robust.
However, a more likely scenario in Exercism's "Space Age" exercise is that the function signature is `age(seconds, planet)` and the tests pass the planet name.
The error `planet.toLowerCase is not a function` is very specific.
Let's check the test file content if possible? No, I can't.
But I can make the code robust.

Another possibility: The tests are passing the planet name as the *first* argument? No, the instructions say "Given an age in seconds...".
Let's look at the error again.
`at Object.<anonymous> (space-age.spec.js:5:15)`
Line 5 of the spec file.
Usually, the first test is "age on Earth".
If the test is `expect(age(1000000000, 'Earth')).toEqual(31.69)`, then `planet` is `'Earth'`.
Why would `'Earth'.toLowerCase` fail? It shouldn't.

Wait, looking at the provided `space-age.js` in the chat:
```javascript
export const age = (seconds, planet = 'earth') => {
  const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
  const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
```
If `planet` is `'Earth'`, `planet.toLowerCase()` is `'earth'`.
`PLANET_ORBITAL_PERIODS['earth']` is `1.0`.
This should work.

Is it possible that `planet` is not being passed as a string?
Or maybe the test is calling `age(1000000000)` and the default is not working?
If `planet` is `undefined`, `planet.toLowerCase` fails.
But `planet = 'earth'` should handle `undefined`.
It does NOT handle `null`.
If the test calls `age(1000000000, null)`, it fails.

Let's look at the error message again.
`TypeError: planet.toLowerCase is not a function`
This happens if `planet` is `null`, `undefined`, `number`, `object`, etc.
If the test is `age(1000000000)`, `planet` is `'earth'` (string).
If the test is `age(1000000000, 'Earth')`, `planet` is `'Earth'` (string).

Maybe the test file is importing `age` differently?
Or maybe the test is passing the planet as the first argument?
"Given an age in seconds, calculate how old someone would be on a planet".
Standard signature is `age(seconds, planet)`.

Let's assume the tests are passing `null` or the default parameter isn't catching it.
I will modify the code to handle non-string inputs gracefully or ensure `planet` is a string.
Actually, if I look at common Exercism solutions, sometimes the planet is passed as the first argument in older versions, but the instructions here say "Given an age in seconds...".

Let's look at the error trace again.
`at toLowerCase (space-age.js:21:55)`
Line 21 is `const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];`

If I change the code to check if `planet` is a string, or use `String(planet).toLowerCase()`, it might fix it.
But if `planet` is `undefined`, `String(undefined)` is `'undefined'`, which is not a valid planet.
If the test expects `age(1000000000)` to work, and it's failing, maybe the default parameter isn't being used?
No, default parameters work in modern JS.

Wait, if the test is `age(1000000000, 'Earth')`, and it fails with `planet.toLowerCase is not a function`, then `planet` is NOT a string.
How can `planet` not be a string if the test passes `'Earth'`?
Maybe the test is `age('Earth', 1000000000)`?
If the arguments are swapped, `seconds` would be `'Earth'` and `planet` would be `1000000000`.
`1000000000.toLowerCase` is not a function.
This is a very common mistake in these exercises.
Let's check the instructions: "Given an age in seconds...".
But maybe the test file has `age('Earth', 1000000000)`?
If I look at the error `at Object.<anonymous> (space-age.spec.js:5:15)`, it's the first test.
If the first test is "age on Earth", it might be `age(1000000000, 'Earth')` or `age('Earth', 1000000000)`.

Let's assume the arguments might be in the wrong order or `planet` is not a string.
I will make the function robust to handle both orders or ensure `planet` is treated as a string.
Actually, the safest bet is to check the types.
If `typeof planet === 'number'`, then `seconds` and `planet` are likely swapped.
Or, I can just use `String(planet).toLowerCase()` and handle the case where it's not found.

However, if the test is `age(1000000000, 'Earth')`, and it fails, it's very strange.
Let's look at the `PLANET_ORBITAL_PERIODS` keys. They are lowercase.
`planet.toLowerCase()` converts to lowercase.
If `planet` is `'Earth'`, it becomes `'earth'`.
`PLANET_ORBITAL_PERIODS['earth']` exists.

Is it possible that `planet` is `undefined` because the test calls `age(1000000000)`?
If `age(1000000000)` is called, `planet` defaults to `'earth'`.
`'earth'.toLowerCase()` is `'earth'`.
This should work.

Unless... the test file is not using the default parameter?
Maybe the test file is `age(1000000000, undefined)`?
`undefined` triggers the default.

Let's look at the error again.
`TypeError: planet.toLowerCase is not a function`
This error occurs when `planet` is `null`, `undefined`, `number`, `boolean`, `object`.
If `planet` is `undefined`, the default `'earth'` should replace it.
So `planet` must be `null` or a non-string, non-undefined value.
If the test calls `age(1000000000, null)`, it fails.
If the test calls `age(1000000000, 1000000000)` (swapped), it fails.

I will modify the code to handle the case where `planet` is not a string by converting it to a string, or better, by checking if the arguments are swapped.
But the simplest fix that handles `null` and `undefined` (if default doesn't catch `null`) is to use `String(planet)`.
However, if `planet` is `null`, `String(null)` is `'null'`, which is not a valid planet.
If the test expects `age(1000000000, null)` to throw an error, that's fine.
But the test is failing with a TypeError, not an expected error.
This suggests the test expects a valid result.

Let's assume the test is passing the planet name as a string, but maybe it's not?
Or maybe the test is `age(1000000000, 'Earth')` and the code is correct, but the environment is weird?
No, the error is clear.

Let's try to make the function accept the planet name as the first argument if the second is not a string?
Or just ensure `planet` is a string.
I'll change `planet.toLowerCase()` to `String(planet).toLowerCase()`.
And I'll also handle the case where `planet` is not provided or is `null` by defaulting to `'earth'` more explicitly.

Actually, looking at the test file line 5, it's likely `expect(age(1000000000, 'Earth')).toEqual(31.69)`.
If this fails with `planet.toLowerCase is not a function`, then `planet` is not a string.
This is very confusing.
Maybe the test file is `age('Earth', 1000000000)`?
If so, `seconds` is `'Earth'` and `planet` is `1000000000`.
`1000000000.toLowerCase` fails.
If I swap the arguments in the function, it might work.
But the instructions say "Given an age in seconds...".
I will make the function robust to handle both orders.

space-age.js
```javascript
<<<<<<< SEARCH
export const age = (seconds, planet = 'earth') => {
  const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
  const orbitalPeriod = PLANET_ORBITAL_PERIODS[planet.toLowerCase()];
  
  if (orbitalPeriod === undefined) {
    throw new Error('invalid planet');
  }
  
  return Math.round((earthYears / orbitalPeriod) * 100) / 100;
};
=======
export const age = (seconds, planet = 'earth') => {
  // Handle case where arguments might be swapped or planet is not a string
  let planetName = planet;
  if (typeof planet !== 'string') {
    // If planet is not a string, maybe seconds is the planet name?
    // Or maybe planet is null/undefined and we should default to earth?
    if (typeof seconds === 'string') {
      planetName = seconds;
      seconds = planet;
    } else {
      planetName = 'earth';
    }
  }
  
  const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
  const orbitalPeriod = PLANET_ORBITAL_PERIODS[planetName.toLowerCase()];
  
  if (orbitalPeriod === undefined) {
    throw new Error('invalid planet');
  }
  
  return Math.round((earthYears / orbitalPeriod) * 100) / 100;
};
>>>>>>> REPLACE
```

> Tokens: 5.0k sent, 2.7k received.  
> Applied edit to space-age.js  
```

> test
> jest ./*

PASS ./space-age.spec.js
  Space Age
    ✓ age on Earth (2 ms)
    ✓ age on Mercury
    ✓ age on Venus
    ✓ age on Mars
    ✓ age on Jupiter
    ✓ age on Saturn
    ✓ age on Uranus
    ✓ age on Neptune

Test Suites: 1 passed, 1 total
Tests:       8 passed, 8 total
Snapshots:   0 total
Time:        0.982 s, estimated 1 s
Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./space-age.js|./space-age.spec.js.

```