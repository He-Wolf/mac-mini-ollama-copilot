
# aider chat started at 2026-11-04 16:09:56

> Aider v0.86.3.dev+less  
> Model: openai/qwen3.8-flash-next-gyro-gyro-s with diff edit format, reasoning none  
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

To implement the `age` function, we need to:
1. Define a map of orbital periods for each planet relative to Earth years.
2. Calculate the age in Earth years by dividing seconds by 31,557,600.
3. Divide the Earth years by the specific planet's orbital period.
4. Round the result to two decimal places.

Here is the *SEARCH/REPLACE* block for `space-age.js`:

space-age.js
```javascript
<<<<<<< SEARCH
export const age = () => {
  throw new Error('Remove this statement and implement this function');
};
=======
const EARTH_YEAR_IN_SECONDS = 31557600;

const ORBITAL_PERIODS = {
  mercury: 0.2408467,
  venus: 0.61519726,
  earth: 1.0,
  mars: 1.8808158,
  jupiter: 11.862615,
  saturn: 29.447498,
  uranus: 84.016846,
  neptune: 164.79132,
};

export const age = (planet, seconds) => {
  if (!ORBITAL_PERIODS[planet]) {
    throw new Error(`Invalid planet: ${planet}`);
  }

  const earthYears = seconds / EARTH_YEAR_IN_SECONDS;
  const planetYears = earthYears / ORBITAL_PERIODS[planet];

  return Math.round(planetYears * 100) / 100;
};
>>>>>>> REPLACE
```

> Tokens: 2.8k sent, 379 received.  
> Applied edit to space-age.js  
```

> test
> jest ./*

PASS ./space-age.spec.js
  Space Age
    ✓ age on Earth (2 ms)
    ✓ age on Mercury
    ✓ age on Venus
    ✓ age on Mars (1 ms)
    ✓ age on Jupiter
    ✓ age on Saturn (1 ms)
    ✓ age on Uranus
    ✓ age on Neptune

Test Suites: 1 passed, 1 total
Tests:       8 passed, 8 total
Snapshots:   0 total
Time:        0.446 s
Ran all test suites matching ./LICENSE|./babel.config.js|./node_modules|./package-lock.json|./package.json|./space-age.js|./space-age.spec.js.

```