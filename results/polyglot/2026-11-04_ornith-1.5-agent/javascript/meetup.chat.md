
# aider chat started at 2026-11-04 13:26:16

> Aider v0.86.3.dev+less  
> Model: ollama_chat/ornith-1.5-agent with diff edit format  
> Git repo: none  
> Repo-map: disabled  
> Added meetup.js to the chat.  

#### # Introduction  
####   
#### Every month, your partner meets up with their best friend.  
#### Both of them have very busy schedules, making it challenging to find a suitable date!  
#### Given your own busy schedule, your partner always double-checks potential meetup dates with you:  
####   
#### - "Can I meet up on the first Friday of next month?"  
#### - "What about the third Wednesday?"  
#### - "Maybe the last Sunday?"  
####   
#### In this month's call, your partner asked you this question:  
####   
#### - "I'd like to meet up on the teenth Thursday; is that okay?"  
####   
#### Confused, you ask what a "teenth" day is.  
#### Your partner explains that a teenth day, a concept they made up, refers to the days in a month that end in '-teenth':  
####   
#### - 13th (thirteenth)  
#### - 14th (fourteenth)  
#### - 15th (fifteenth)  
#### - 16th (sixteenth)  
#### - 17th (seventeenth)  
#### - 18th (eighteenth)  
#### - 19th (nineteenth)  
####   
#### As there are also seven weekdays, it is guaranteed that each day of the week has _exactly one_ teenth day each month.  
####   
#### Now that you understand the concept of a teenth day, you check your calendar.  
#### You don't have anything planned on the teenth Thursday, so you happily confirm the date with your partner.  
#### # Instructions  
####   
#### Your task is to find the exact date of a meetup, given a month, year, weekday and week.  
####   
#### There are five week values to consider: `first`, `second`, `third`, `fourth`, `last`, `teenth`.  
####   
#### For example, you might be asked to find the date for the meetup on the first Monday in January 2018 (January 1, 2018).  
####   
#### Similarly, you might be asked to find:  
####   
#### - the third Tuesday of August 2019 (August 20, 2019)  
#### - the teenth Wednesday of May 2020 (May 13, 2020)  
#### - the fourth Sunday of July 2021 (July 25, 2021)  
#### - the last Thursday of November 2022 (November 24, 2022)  
#### - the teenth Saturday of August 1953 (August 15, 1953)  
####   
#### ## Teenth  
####   
#### The teenth week refers to the seven days in a month that end in '-teenth' (13th, 14th, 15th, 16th, 17th, 18th and 19th).  
####   
#### If asked to find the teenth Saturday of August, 1953, we check its calendar:  
####   
#### ```plaintext  
####     August 1953  
#### Su Mo Tu We Th Fr Sa  
####                    1  
####  2  3  4  5  6  7  8  
####  9 10 11 12 13 14 15  
#### 16 17 18 19 20 21 22  
#### 23 24 25 26 27 28 29  
#### 30 31  
#### ```  
####   
#### From this we find that the teenth Saturday is August 15, 1953.  
#### # Instructions append  
####   
#### In JavaScript, the Date object month's index ranges from 0 to 11.  
####   
#### ```javascript  
#### const date = new Date('2020-06-13');  
#### date.getFullYear();  
#### // => 2020  
#### date.getMonth();  
#### // => 5 (instead of 6)  
#### date.getDate();  
#### // => 13  
#### ```  
####   
#### ####  
####   
#### Use the above instructions to modify the supplied files: meetup.js  
#### Don't change the names of existing functions or classes, as they may be referenced from other code like unit tests, etc.  
#### Only use standard libraries, don't suggest installing any packages.  

I'll implement the `meetup` function to find the exact date based on the given year, month, weekday, and week descriptor.

Let me analyze the requirements:
- Take year, month (1-12), weekday name, and week descriptor
- Find all dates in that month matching the weekday
- Select based on the week descriptor (first, second, third, fourth, last, teenth)
- Return a Date object

meetup.js
```javascript
<<<<<<< SEARCH
export const meetup = () => {
  throw new Error('Remove this statement and implement this function');
};
=======
const DAY_TO_INDEX = {
  Sunday: 0,
  Monday: 1,
  Tuesday: 2,
  Wednesday: 3,
  Thursday: 4,
  Friday: 5,
  Saturday: 6,
};

const WEEK_INDEX = {
  first: 0,
  second: 1,
  third: 2,
  fourth: 3,
};

export const meetup = (year, month, weekday, week) => {
  const targetDay = DAY_TO_INDEX[weekday];

  // Collect the day-of-month for every occurrence of the target weekday.
  const days = [];
  let date = new Date(year, month - 1, 1);
  while (date.getMonth() === month - 1) {
    if (date.getDay() === targetDay) {
      days.push(date.getDate());
    }
    date.setDate(date.getDate() + 1);
  }

  let day;
  if (week === 'teenth') {
    day = days.find((d) => d >= 13 && d <= 19);
  } else if (week === 'last') {
    day = days[days.length - 1];
  } else {
    day = days[WEEK_INDEX[week]];
  }

  return new Date(year, month - 1, day);
};
>>>>>>> REPLACE
```

> Tokens: 3.0k sent, 1.2k received.  
> Applied edit to meetup.js  
```

> test
> jest ./*

FAIL ./meetup.spec.js
  Meetup
    ✕ monteenth of May 2013 (5 ms)
    ✕ monteenth of August 2013 (1 ms)
    ✕ monteenth of September 2013
    ✕ tuesteenth of March 2013 (1 ms)
    ✕ tuesteenth of April 2013 (1 ms)
    ✕ tuesteenth of August 2013 (1 ms)
    ✕ wednesteenth of January 2013 (1 ms)
    ✕ wednesteenth of February 2013 (1 ms)
    ✕ wednesteenth of June 2013 (1 ms)
    ✕ thursteenth of May 2013
    ✕ thursteenth of June 2013 (1 ms)
    ✕ thursteenth of September 2013 (1 ms)
    ✕ friteenth of April 2013 (1 ms)
    ✕ friteenth of August 2013 (1 ms)
    ✕ friteenth of September 2013 (1 ms)
    ✕ saturteenth of February 2013
    ✕ saturteenth of April 2013
    ✕ saturteenth of October 2013 (1 ms)
    ✕ sunteenth of May 2013 (1 ms)
    ✕ sunteenth of June 2013
    ✕ sunteenth of October 2013
    ✕ first Monday of March 2013
    ✕ first Monday of April 2013
    ✕ first Tuesday of May 2013
    ✕ first Tuesday of June 2013
    ✕ first Wednesday of July 2013
    ✕ first Wednesday of August 2013 (1 ms)
    ✕ first Thursday of September 2013 (1 ms)
    ✕ first Thursday of October 2013 (1 ms)
    ✕ first Friday of November 2013 (1 ms)
    ✕ first Friday of December 2013 (1 ms)
    ✕ first Saturday of January 2013 (1 ms)
    ✕ first Saturday of February 2013 (1 ms)
    ✕ first Sunday of March 2013 (1 ms)
    ✕ first Sunday of April 2013
    ✕ second Monday of March 2013
    ✕ second Monday of April 2013 (1 ms)
    ✕ second Tuesday of May 2013 (1 ms)
    ✕ second Tuesday of June 2013 (1 ms)
    ✕ second Wednesday of July 2013
    ✕ second Wednesday of August 2013
    ✕ second Thursday of September 2013 (1 ms)
    ✕ second Thursday of October 2013
    ✕ second Friday of November 2013
    ✕ second Friday of December 2013
    ✕ second Saturday of January 2013
    ✕ second Saturday of February 2013 (1 ms)
    ✕ second Sunday of March 2013
    ✕ second Sunday of April 2013
    ✕ third Monday of March 2013
    ✕ third Monday of April 2013
    ✕ third Tuesday of May 2013
    ✕ third Tuesday of June 2013
    ✕ third Wednesday of July 2013
    ✕ third Wednesday of August 2013
    ✕ third Thursday of September 2013 (1 ms)
    ✕ third Thursday of October 2013
    ✕ third Friday of November 2013 (1 ms)
    ✕ third Friday of December 2013
    ✕ third Saturday of January 2013 (1 ms)
    ✕ third Saturday of February 2013 (1 ms)
    ✕ third Sunday of March 2013 (1 ms)
    ✕ third Sunday of April 2013 (1 ms)
    ✕ fourth Monday of March 2013 (1 ms)
    ✕ fourth Monday of April 2013
    ✕ fourth Tuesday of May 2013 (1 ms)
    ✕ fourth Tuesday of June 2013
    ✕ fourth Wednesday of July 2013
    ✕ fourth Wednesday of August 2013
    ✕ fourth Thursday of September 2013
    ✕ fourth Thursday of October 2013 (1 ms)
    ✕ fourth Friday of November 2013
    ✕ fourth Friday of December 2013 (1 ms)
    ✕ fourth Saturday of January 2013
    ✕ fourth Saturday of February 2013 (1 ms)
    ✕ fourth Sunday of March 2013
    ✕ fourth Sunday of April 2013 (1 ms)
    ✕ last Monday of March 2013
    ✕ last Monday of April 2013 (3 ms)
    ✕ last Tuesday of May 2013 (1 ms)
    ✕ last Tuesday of June 2013
    ✕ last Wednesday of July 2013
    ✕ last Wednesday of August 2013
    ✕ last Thursday of September 2013
    ✕ last Thursday of October 2013 (1 ms)
    ✕ last Friday of November 2013
    ✕ last Friday of December 2013 (1 ms)
    ✕ last Saturday of January 2013
    ✕ last Saturday of February 2013 (1 ms)
    ✕ last Sunday of March 2013
    ✕ last Sunday of April 2013
    ✕ last Wednesday of February 2012 (1 ms)
    ✕ last Wednesday of December 2014
    ✕ last Sunday of February 2015
    ✕ first Friday of December 2012

  ● Meetup › monteenth of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-13T00:00:00.000Z
    Received: Date { NaN }

      3 | describe('Meetup', () => {
      4 |   test('monteenth of May 2013', () => {
    > 5 |     expect(meetup(2013, 5, 'teenth', 'Monday')).toEqual(new Date(2013, 4, 13));
        |                                                 ^
      6 |   });
      7 |
      8 |   test('monteenth of August 2013', () => {

      at Object.toEqual (meetup.spec.js:5:49)

  ● Meetup › monteenth of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-19T00:00:00.000Z
    Received: Date { NaN }

       7 |
       8 |   test('monteenth of August 2013', () => {
    >  9 |     expect(meetup(2013, 8, 'teenth', 'Monday')).toEqual(new Date(2013, 7, 19));
         |                                                 ^
      10 |   });
      11 |
      12 |   test('monteenth of September 2013', () => {

      at Object.toEqual (meetup.spec.js:9:49)

  ● Meetup › monteenth of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-16T00:00:00.000Z
    Received: Date { NaN }

      11 |
      12 |   test('monteenth of September 2013', () => {
    > 13 |     expect(meetup(2013, 9, 'teenth', 'Monday')).toEqual(new Date(2013, 8, 16));
         |                                                 ^
      14 |   });
      15 |
      16 |   test('tuesteenth of March 2013', () => {

      at Object.toEqual (meetup.spec.js:13:49)

  ● Meetup › tuesteenth of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-19T00:00:00.000Z
    Received: Date { NaN }

      15 |
      16 |   test('tuesteenth of March 2013', () => {
    > 17 |     expect(meetup(2013, 3, 'teenth', 'Tuesday')).toEqual(new Date(2013, 2, 19));
         |                                                  ^
      18 |   });
      19 |
      20 |   test('tuesteenth of April 2013', () => {

      at Object.toEqual (meetup.spec.js:17:50)

  ● Meetup › tuesteenth of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-16T00:00:00.000Z
    Received: Date { NaN }

      19 |
      20 |   test('tuesteenth of April 2013', () => {
    > 21 |     expect(meetup(2013, 4, 'teenth', 'Tuesday')).toEqual(new Date(2013, 3, 16));
         |                                                  ^
      22 |   });
      23 |
      24 |   test('tuesteenth of August 2013', () => {

      at Object.toEqual (meetup.spec.js:21:50)

  ● Meetup › tuesteenth of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-13T00:00:00.000Z
    Received: Date { NaN }

      23 |
      24 |   test('tuesteenth of August 2013', () => {
    > 25 |     expect(meetup(2013, 8, 'teenth', 'Tuesday')).toEqual(new Date(2013, 7, 13));
         |                                                  ^
      26 |   });
      27 |
      28 |   test('wednesteenth of January 2013', () => {

      at Object.toEqual (meetup.spec.js:25:50)

  ● Meetup › wednesteenth of January 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-01-16T00:00:00.000Z
    Received: Date { NaN }

      27 |
      28 |   test('wednesteenth of January 2013', () => {
    > 29 |     expect(meetup(2013, 1, 'teenth', 'Wednesday')).toEqual(
         |                                                    ^
      30 |       new Date(2013, 0, 16),
      31 |     );
      32 |   });

      at Object.toEqual (meetup.spec.js:29:52)

  ● Meetup › wednesteenth of February 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-02-13T00:00:00.000Z
    Received: Date { NaN }

      33 |
      34 |   test('wednesteenth of February 2013', () => {
    > 35 |     expect(meetup(2013, 2, 'teenth', 'Wednesday')).toEqual(
         |                                                    ^
      36 |       new Date(2013, 1, 13),
      37 |     );
      38 |   });

      at Object.toEqual (meetup.spec.js:35:52)

  ● Meetup › wednesteenth of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-19T00:00:00.000Z
    Received: Date { NaN }

      39 |
      40 |   test('wednesteenth of June 2013', () => {
    > 41 |     expect(meetup(2013, 6, 'teenth', 'Wednesday')).toEqual(
         |                                                    ^
      42 |       new Date(2013, 5, 19),
      43 |     );
      44 |   });

      at Object.toEqual (meetup.spec.js:41:52)

  ● Meetup › thursteenth of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-16T00:00:00.000Z
    Received: Date { NaN }

      45 |
      46 |   test('thursteenth of May 2013', () => {
    > 47 |     expect(meetup(2013, 5, 'teenth', 'Thursday')).toEqual(
         |                                                   ^
      48 |       new Date(2013, 4, 16),
      49 |     );
      50 |   });

      at Object.toEqual (meetup.spec.js:47:51)

  ● Meetup › thursteenth of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-13T00:00:00.000Z
    Received: Date { NaN }

      51 |
      52 |   test('thursteenth of June 2013', () => {
    > 53 |     expect(meetup(2013, 6, 'teenth', 'Thursday')).toEqual(
         |                                                   ^
      54 |       new Date(2013, 5, 13),
      55 |     );
      56 |   });

      at Object.toEqual (meetup.spec.js:53:51)

  ● Meetup › thursteenth of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-19T00:00:00.000Z
    Received: Date { NaN }

      57 |
      58 |   test('thursteenth of September 2013', () => {
    > 59 |     expect(meetup(2013, 9, 'teenth', 'Thursday')).toEqual(
         |                                                   ^
      60 |       new Date(2013, 8, 19),
      61 |     );
      62 |   });

      at Object.toEqual (meetup.spec.js:59:51)

  ● Meetup › friteenth of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-19T00:00:00.000Z
    Received: Date { NaN }

      63 |
      64 |   test('friteenth of April 2013', () => {
    > 65 |     expect(meetup(2013, 4, 'teenth', 'Friday')).toEqual(new Date(2013, 3, 19));
         |                                                 ^
      66 |   });
      67 |
      68 |   test('friteenth of August 2013', () => {

      at Object.toEqual (meetup.spec.js:65:49)

  ● Meetup › friteenth of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-16T00:00:00.000Z
    Received: Date { NaN }

      67 |
      68 |   test('friteenth of August 2013', () => {
    > 69 |     expect(meetup(2013, 8, 'teenth', 'Friday')).toEqual(new Date(2013, 7, 16));
         |                                                 ^
      70 |   });
      71 |
      72 |   test('friteenth of September 2013', () => {

      at Object.toEqual (meetup.spec.js:69:49)

  ● Meetup › friteenth of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-13T00:00:00.000Z
    Received: Date { NaN }

      71 |
      72 |   test('friteenth of September 2013', () => {
    > 73 |     expect(meetup(2013, 9, 'teenth', 'Friday')).toEqual(new Date(2013, 8, 13));
         |                                                 ^
      74 |   });
      75 |
      76 |   test('saturteenth of February 2013', () => {

      at Object.toEqual (meetup.spec.js:73:49)

  ● Meetup › saturteenth of February 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-02-16T00:00:00.000Z
    Received: Date { NaN }

      75 |
      76 |   test('saturteenth of February 2013', () => {
    > 77 |     expect(meetup(2013, 2, 'teenth', 'Saturday')).toEqual(
         |                                                   ^
      78 |       new Date(2013, 1, 16),
      79 |     );
      80 |   });

      at Object.toEqual (meetup.spec.js:77:51)

  ● Meetup › saturteenth of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-13T00:00:00.000Z
    Received: Date { NaN }

      81 |
      82 |   test('saturteenth of April 2013', () => {
    > 83 |     expect(meetup(2013, 4, 'teenth', 'Saturday')).toEqual(
         |                                                   ^
      84 |       new Date(2013, 3, 13),
      85 |     );
      86 |   });

      at Object.toEqual (meetup.spec.js:83:51)

  ● Meetup › saturteenth of October 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-10-19T00:00:00.000Z
    Received: Date { NaN }

      87 |
      88 |   test('saturteenth of October 2013', () => {
    > 89 |     expect(meetup(2013, 10, 'teenth', 'Saturday')).toEqual(
         |                                                    ^
      90 |       new Date(2013, 9, 19),
      91 |     );
      92 |   });

      at Object.toEqual (meetup.spec.js:89:52)

  ● Meetup › sunteenth of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-19T00:00:00.000Z
    Received: Date { NaN }

      93 |
      94 |   test('sunteenth of May 2013', () => {
    > 95 |     expect(meetup(2013, 5, 'teenth', 'Sunday')).toEqual(new Date(2013, 4, 19));
         |                                                 ^
      96 |   });
      97 |
      98 |   test('sunteenth of June 2013', () => {

      at Object.toEqual (meetup.spec.js:95:49)

  ● Meetup › sunteenth of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-16T00:00:00.000Z
    Received: Date { NaN }

       97 |
       98 |   test('sunteenth of June 2013', () => {
    >  99 |     expect(meetup(2013, 6, 'teenth', 'Sunday')).toEqual(new Date(2013, 5, 16));
          |                                                 ^
      100 |   });
      101 |
      102 |   test('sunteenth of October 2013', () => {

      at Object.toEqual (meetup.spec.js:99:49)

  ● Meetup › sunteenth of October 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-10-13T00:00:00.000Z
    Received: Date { NaN }

      101 |
      102 |   test('sunteenth of October 2013', () => {
    > 103 |     expect(meetup(2013, 10, 'teenth', 'Sunday')).toEqual(new Date(2013, 9, 13));
          |                                                  ^
      104 |   });
      105 |
      106 |   test('first Monday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:103:50)

  ● Meetup › first Monday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-04T00:00:00.000Z
    Received: Date { NaN }

      105 |
      106 |   test('first Monday of March 2013', () => {
    > 107 |     expect(meetup(2013, 3, 'first', 'Monday')).toEqual(new Date(2013, 2, 4));
          |                                                ^
      108 |   });
      109 |
      110 |   test('first Monday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:107:48)

  ● Meetup › first Monday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-01T00:00:00.000Z
    Received: Date { NaN }

      109 |
      110 |   test('first Monday of April 2013', () => {
    > 111 |     expect(meetup(2013, 4, 'first', 'Monday')).toEqual(new Date(2013, 3, 1));
          |                                                ^
      112 |   });
      113 |
      114 |   test('first Tuesday of May 2013', () => {

      at Object.toEqual (meetup.spec.js:111:48)

  ● Meetup › first Tuesday of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-07T00:00:00.000Z
    Received: Date { NaN }

      113 |
      114 |   test('first Tuesday of May 2013', () => {
    > 115 |     expect(meetup(2013, 5, 'first', 'Tuesday')).toEqual(new Date(2013, 4, 7));
          |                                                 ^
      116 |   });
      117 |
      118 |   test('first Tuesday of June 2013', () => {

      at Object.toEqual (meetup.spec.js:115:49)

  ● Meetup › first Tuesday of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-04T00:00:00.000Z
    Received: Date { NaN }

      117 |
      118 |   test('first Tuesday of June 2013', () => {
    > 119 |     expect(meetup(2013, 6, 'first', 'Tuesday')).toEqual(new Date(2013, 5, 4));
          |                                                 ^
      120 |   });
      121 |
      122 |   test('first Wednesday of July 2013', () => {

      at Object.toEqual (meetup.spec.js:119:49)

  ● Meetup › first Wednesday of July 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-07-03T00:00:00.000Z
    Received: Date { NaN }

      121 |
      122 |   test('first Wednesday of July 2013', () => {
    > 123 |     expect(meetup(2013, 7, 'first', 'Wednesday')).toEqual(new Date(2013, 6, 3));
          |                                                   ^
      124 |   });
      125 |
      126 |   test('first Wednesday of August 2013', () => {

      at Object.toEqual (meetup.spec.js:123:51)

  ● Meetup › first Wednesday of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-07T00:00:00.000Z
    Received: Date { NaN }

      125 |
      126 |   test('first Wednesday of August 2013', () => {
    > 127 |     expect(meetup(2013, 8, 'first', 'Wednesday')).toEqual(new Date(2013, 7, 7));
          |                                                   ^
      128 |   });
      129 |
      130 |   test('first Thursday of September 2013', () => {

      at Object.toEqual (meetup.spec.js:127:51)

  ● Meetup › first Thursday of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-05T00:00:00.000Z
    Received: Date { NaN }

      129 |
      130 |   test('first Thursday of September 2013', () => {
    > 131 |     expect(meetup(2013, 9, 'first', 'Thursday')).toEqual(new Date(2013, 8, 5));
          |                                                  ^
      132 |   });
      133 |
      134 |   test('first Thursday of October 2013', () => {

      at Object.toEqual (meetup.spec.js:131:50)

  ● Meetup › first Thursday of October 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-10-03T00:00:00.000Z
    Received: Date { NaN }

      133 |
      134 |   test('first Thursday of October 2013', () => {
    > 135 |     expect(meetup(2013, 10, 'first', 'Thursday')).toEqual(new Date(2013, 9, 3));
          |                                                   ^
      136 |   });
      137 |
      138 |   test('first Friday of November 2013', () => {

      at Object.toEqual (meetup.spec.js:135:51)

  ● Meetup › first Friday of November 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-11-01T00:00:00.000Z
    Received: Date { NaN }

      137 |
      138 |   test('first Friday of November 2013', () => {
    > 139 |     expect(meetup(2013, 11, 'first', 'Friday')).toEqual(new Date(2013, 10, 1));
          |                                                 ^
      140 |   });
      141 |
      142 |   test('first Friday of December 2013', () => {

      at Object.toEqual (meetup.spec.js:139:49)

  ● Meetup › first Friday of December 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-12-06T00:00:00.000Z
    Received: Date { NaN }

      141 |
      142 |   test('first Friday of December 2013', () => {
    > 143 |     expect(meetup(2013, 12, 'first', 'Friday')).toEqual(new Date(2013, 11, 6));
          |                                                 ^
      144 |   });
      145 |
      146 |   test('first Saturday of January 2013', () => {

      at Object.toEqual (meetup.spec.js:143:49)

  ● Meetup › first Saturday of January 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-01-05T00:00:00.000Z
    Received: Date { NaN }

      145 |
      146 |   test('first Saturday of January 2013', () => {
    > 147 |     expect(meetup(2013, 1, 'first', 'Saturday')).toEqual(new Date(2013, 0, 5));
          |                                                  ^
      148 |   });
      149 |
      150 |   test('first Saturday of February 2013', () => {

      at Object.toEqual (meetup.spec.js:147:50)

  ● Meetup › first Saturday of February 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-02-02T00:00:00.000Z
    Received: Date { NaN }

      149 |
      150 |   test('first Saturday of February 2013', () => {
    > 151 |     expect(meetup(2013, 2, 'first', 'Saturday')).toEqual(new Date(2013, 1, 2));
          |                                                  ^
      152 |   });
      153 |
      154 |   test('first Sunday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:151:50)

  ● Meetup › first Sunday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-03T00:00:00.000Z
    Received: Date { NaN }

      153 |
      154 |   test('first Sunday of March 2013', () => {
    > 155 |     expect(meetup(2013, 3, 'first', 'Sunday')).toEqual(new Date(2013, 2, 3));
          |                                                ^
      156 |   });
      157 |
      158 |   test('first Sunday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:155:48)

  ● Meetup › first Sunday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-07T00:00:00.000Z
    Received: Date { NaN }

      157 |
      158 |   test('first Sunday of April 2013', () => {
    > 159 |     expect(meetup(2013, 4, 'first', 'Sunday')).toEqual(new Date(2013, 3, 7));
          |                                                ^
      160 |   });
      161 |
      162 |   test('second Monday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:159:48)

  ● Meetup › second Monday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-11T00:00:00.000Z
    Received: Date { NaN }

      161 |
      162 |   test('second Monday of March 2013', () => {
    > 163 |     expect(meetup(2013, 3, 'second', 'Monday')).toEqual(new Date(2013, 2, 11));
          |                                                 ^
      164 |   });
      165 |
      166 |   test('second Monday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:163:49)

  ● Meetup › second Monday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-08T00:00:00.000Z
    Received: Date { NaN }

      165 |
      166 |   test('second Monday of April 2013', () => {
    > 167 |     expect(meetup(2013, 4, 'second', 'Monday')).toEqual(new Date(2013, 3, 8));
          |                                                 ^
      168 |   });
      169 |
      170 |   test('second Tuesday of May 2013', () => {

      at Object.toEqual (meetup.spec.js:167:49)

  ● Meetup › second Tuesday of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-14T00:00:00.000Z
    Received: Date { NaN }

      169 |
      170 |   test('second Tuesday of May 2013', () => {
    > 171 |     expect(meetup(2013, 5, 'second', 'Tuesday')).toEqual(new Date(2013, 4, 14));
          |                                                  ^
      172 |   });
      173 |
      174 |   test('second Tuesday of June 2013', () => {

      at Object.toEqual (meetup.spec.js:171:50)

  ● Meetup › second Tuesday of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-11T00:00:00.000Z
    Received: Date { NaN }

      173 |
      174 |   test('second Tuesday of June 2013', () => {
    > 175 |     expect(meetup(2013, 6, 'second', 'Tuesday')).toEqual(new Date(2013, 5, 11));
          |                                                  ^
      176 |   });
      177 |
      178 |   test('second Wednesday of July 2013', () => {

      at Object.toEqual (meetup.spec.js:175:50)

  ● Meetup › second Wednesday of July 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-07-10T00:00:00.000Z
    Received: Date { NaN }

      177 |
      178 |   test('second Wednesday of July 2013', () => {
    > 179 |     expect(meetup(2013, 7, 'second', 'Wednesday')).toEqual(
          |                                                    ^
      180 |       new Date(2013, 6, 10),
      181 |     );
      182 |   });

      at Object.toEqual (meetup.spec.js:179:52)

  ● Meetup › second Wednesday of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-14T00:00:00.000Z
    Received: Date { NaN }

      183 |
      184 |   test('second Wednesday of August 2013', () => {
    > 185 |     expect(meetup(2013, 8, 'second', 'Wednesday')).toEqual(
          |                                                    ^
      186 |       new Date(2013, 7, 14),
      187 |     );
      188 |   });

      at Object.toEqual (meetup.spec.js:185:52)

  ● Meetup › second Thursday of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-12T00:00:00.000Z
    Received: Date { NaN }

      189 |
      190 |   test('second Thursday of September 2013', () => {
    > 191 |     expect(meetup(2013, 9, 'second', 'Thursday')).toEqual(
          |                                                   ^
      192 |       new Date(2013, 8, 12),
      193 |     );
      194 |   });

      at Object.toEqual (meetup.spec.js:191:51)

  ● Meetup › second Thursday of October 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-10-10T00:00:00.000Z
    Received: Date { NaN }

      195 |
      196 |   test('second Thursday of October 2013', () => {
    > 197 |     expect(meetup(2013, 10, 'second', 'Thursday')).toEqual(
          |                                                    ^
      198 |       new Date(2013, 9, 10),
      199 |     );
      200 |   });

      at Object.toEqual (meetup.spec.js:197:52)

  ● Meetup › second Friday of November 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-11-08T00:00:00.000Z
    Received: Date { NaN }

      201 |
      202 |   test('second Friday of November 2013', () => {
    > 203 |     expect(meetup(2013, 11, 'second', 'Friday')).toEqual(new Date(2013, 10, 8));
          |                                                  ^
      204 |   });
      205 |
      206 |   test('second Friday of December 2013', () => {

      at Object.toEqual (meetup.spec.js:203:50)

  ● Meetup › second Friday of December 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-12-13T00:00:00.000Z
    Received: Date { NaN }

      205 |
      206 |   test('second Friday of December 2013', () => {
    > 207 |     expect(meetup(2013, 12, 'second', 'Friday')).toEqual(
          |                                                  ^
      208 |       new Date(2013, 11, 13),
      209 |     );
      210 |   });

      at Object.toEqual (meetup.spec.js:207:50)

  ● Meetup › second Saturday of January 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-01-12T00:00:00.000Z
    Received: Date { NaN }

      211 |
      212 |   test('second Saturday of January 2013', () => {
    > 213 |     expect(meetup(2013, 1, 'second', 'Saturday')).toEqual(
          |                                                   ^
      214 |       new Date(2013, 0, 12),
      215 |     );
      216 |   });

      at Object.toEqual (meetup.spec.js:213:51)

  ● Meetup › second Saturday of February 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-02-09T00:00:00.000Z
    Received: Date { NaN }

      217 |
      218 |   test('second Saturday of February 2013', () => {
    > 219 |     expect(meetup(2013, 2, 'second', 'Saturday')).toEqual(new Date(2013, 1, 9));
          |                                                   ^
      220 |   });
      221 |
      222 |   test('second Sunday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:219:51)

  ● Meetup › second Sunday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-10T00:00:00.000Z
    Received: Date { NaN }

      221 |
      222 |   test('second Sunday of March 2013', () => {
    > 223 |     expect(meetup(2013, 3, 'second', 'Sunday')).toEqual(new Date(2013, 2, 10));
          |                                                 ^
      224 |   });
      225 |
      226 |   test('second Sunday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:223:49)

  ● Meetup › second Sunday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-14T00:00:00.000Z
    Received: Date { NaN }

      225 |
      226 |   test('second Sunday of April 2013', () => {
    > 227 |     expect(meetup(2013, 4, 'second', 'Sunday')).toEqual(new Date(2013, 3, 14));
          |                                                 ^
      228 |   });
      229 |
      230 |   test('third Monday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:227:49)

  ● Meetup › third Monday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-18T00:00:00.000Z
    Received: Date { NaN }

      229 |
      230 |   test('third Monday of March 2013', () => {
    > 231 |     expect(meetup(2013, 3, 'third', 'Monday')).toEqual(new Date(2013, 2, 18));
          |                                                ^
      232 |   });
      233 |
      234 |   test('third Monday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:231:48)

  ● Meetup › third Monday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-15T00:00:00.000Z
    Received: Date { NaN }

      233 |
      234 |   test('third Monday of April 2013', () => {
    > 235 |     expect(meetup(2013, 4, 'third', 'Monday')).toEqual(new Date(2013, 3, 15));
          |                                                ^
      236 |   });
      237 |
      238 |   test('third Tuesday of May 2013', () => {

      at Object.toEqual (meetup.spec.js:235:48)

  ● Meetup › third Tuesday of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-21T00:00:00.000Z
    Received: Date { NaN }

      237 |
      238 |   test('third Tuesday of May 2013', () => {
    > 239 |     expect(meetup(2013, 5, 'third', 'Tuesday')).toEqual(new Date(2013, 4, 21));
          |                                                 ^
      240 |   });
      241 |
      242 |   test('third Tuesday of June 2013', () => {

      at Object.toEqual (meetup.spec.js:239:49)

  ● Meetup › third Tuesday of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-18T00:00:00.000Z
    Received: Date { NaN }

      241 |
      242 |   test('third Tuesday of June 2013', () => {
    > 243 |     expect(meetup(2013, 6, 'third', 'Tuesday')).toEqual(new Date(2013, 5, 18));
          |                                                 ^
      244 |   });
      245 |
      246 |   test('third Wednesday of July 2013', () => {

      at Object.toEqual (meetup.spec.js:243:49)

  ● Meetup › third Wednesday of July 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-07-17T00:00:00.000Z
    Received: Date { NaN }

      245 |
      246 |   test('third Wednesday of July 2013', () => {
    > 247 |     expect(meetup(2013, 7, 'third', 'Wednesday')).toEqual(
          |                                                   ^
      248 |       new Date(2013, 6, 17),
      249 |     );
      250 |   });

      at Object.toEqual (meetup.spec.js:247:51)

  ● Meetup › third Wednesday of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-21T00:00:00.000Z
    Received: Date { NaN }

      251 |
      252 |   test('third Wednesday of August 2013', () => {
    > 253 |     expect(meetup(2013, 8, 'third', 'Wednesday')).toEqual(
          |                                                   ^
      254 |       new Date(2013, 7, 21),
      255 |     );
      256 |   });

      at Object.toEqual (meetup.spec.js:253:51)

  ● Meetup › third Thursday of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-19T00:00:00.000Z
    Received: Date { NaN }

      257 |
      258 |   test('third Thursday of September 2013', () => {
    > 259 |     expect(meetup(2013, 9, 'third', 'Thursday')).toEqual(new Date(2013, 8, 19));
          |                                                  ^
      260 |   });
      261 |
      262 |   test('third Thursday of October 2013', () => {

      at Object.toEqual (meetup.spec.js:259:50)

  ● Meetup › third Thursday of October 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-10-17T00:00:00.000Z
    Received: Date { NaN }

      261 |
      262 |   test('third Thursday of October 2013', () => {
    > 263 |     expect(meetup(2013, 10, 'third', 'Thursday')).toEqual(
          |                                                   ^
      264 |       new Date(2013, 9, 17),
      265 |     );
      266 |   });

      at Object.toEqual (meetup.spec.js:263:51)

  ● Meetup › third Friday of November 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-11-15T00:00:00.000Z
    Received: Date { NaN }

      267 |
      268 |   test('third Friday of November 2013', () => {
    > 269 |     expect(meetup(2013, 11, 'third', 'Friday')).toEqual(new Date(2013, 10, 15));
          |                                                 ^
      270 |   });
      271 |
      272 |   test('third Friday of December 2013', () => {

      at Object.toEqual (meetup.spec.js:269:49)

  ● Meetup › third Friday of December 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-12-20T00:00:00.000Z
    Received: Date { NaN }

      271 |
      272 |   test('third Friday of December 2013', () => {
    > 273 |     expect(meetup(2013, 12, 'third', 'Friday')).toEqual(new Date(2013, 11, 20));
          |                                                 ^
      274 |   });
      275 |
      276 |   test('third Saturday of January 2013', () => {

      at Object.toEqual (meetup.spec.js:273:49)

  ● Meetup › third Saturday of January 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-01-19T00:00:00.000Z
    Received: Date { NaN }

      275 |
      276 |   test('third Saturday of January 2013', () => {
    > 277 |     expect(meetup(2013, 1, 'third', 'Saturday')).toEqual(new Date(2013, 0, 19));
          |                                                  ^
      278 |   });
      279 |
      280 |   test('third Saturday of February 2013', () => {

      at Object.toEqual (meetup.spec.js:277:50)

  ● Meetup › third Saturday of February 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-02-16T00:00:00.000Z
    Received: Date { NaN }

      279 |
      280 |   test('third Saturday of February 2013', () => {
    > 281 |     expect(meetup(2013, 2, 'third', 'Saturday')).toEqual(new Date(2013, 1, 16));
          |                                                  ^
      282 |   });
      283 |
      284 |   test('third Sunday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:281:50)

  ● Meetup › third Sunday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-17T00:00:00.000Z
    Received: Date { NaN }

      283 |
      284 |   test('third Sunday of March 2013', () => {
    > 285 |     expect(meetup(2013, 3, 'third', 'Sunday')).toEqual(new Date(2013, 2, 17));
          |                                                ^
      286 |   });
      287 |
      288 |   test('third Sunday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:285:48)

  ● Meetup › third Sunday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-21T00:00:00.000Z
    Received: Date { NaN }

      287 |
      288 |   test('third Sunday of April 2013', () => {
    > 289 |     expect(meetup(2013, 4, 'third', 'Sunday')).toEqual(new Date(2013, 3, 21));
          |                                                ^
      290 |   });
      291 |
      292 |   test('fourth Monday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:289:48)

  ● Meetup › fourth Monday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-25T00:00:00.000Z
    Received: Date { NaN }

      291 |
      292 |   test('fourth Monday of March 2013', () => {
    > 293 |     expect(meetup(2013, 3, 'fourth', 'Monday')).toEqual(new Date(2013, 2, 25));
          |                                                 ^
      294 |   });
      295 |
      296 |   test('fourth Monday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:293:49)

  ● Meetup › fourth Monday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-22T00:00:00.000Z
    Received: Date { NaN }

      295 |
      296 |   test('fourth Monday of April 2013', () => {
    > 297 |     expect(meetup(2013, 4, 'fourth', 'Monday')).toEqual(new Date(2013, 3, 22));
          |                                                 ^
      298 |   });
      299 |
      300 |   test('fourth Tuesday of May 2013', () => {

      at Object.toEqual (meetup.spec.js:297:49)

  ● Meetup › fourth Tuesday of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-28T00:00:00.000Z
    Received: Date { NaN }

      299 |
      300 |   test('fourth Tuesday of May 2013', () => {
    > 301 |     expect(meetup(2013, 5, 'fourth', 'Tuesday')).toEqual(new Date(2013, 4, 28));
          |                                                  ^
      302 |   });
      303 |
      304 |   test('fourth Tuesday of June 2013', () => {

      at Object.toEqual (meetup.spec.js:301:50)

  ● Meetup › fourth Tuesday of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-25T00:00:00.000Z
    Received: Date { NaN }

      303 |
      304 |   test('fourth Tuesday of June 2013', () => {
    > 305 |     expect(meetup(2013, 6, 'fourth', 'Tuesday')).toEqual(new Date(2013, 5, 25));
          |                                                  ^
      306 |   });
      307 |
      308 |   test('fourth Wednesday of July 2013', () => {

      at Object.toEqual (meetup.spec.js:305:50)

  ● Meetup › fourth Wednesday of July 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-07-24T00:00:00.000Z
    Received: Date { NaN }

      307 |
      308 |   test('fourth Wednesday of July 2013', () => {
    > 309 |     expect(meetup(2013, 7, 'fourth', 'Wednesday')).toEqual(
          |                                                    ^
      310 |       new Date(2013, 6, 24),
      311 |     );
      312 |   });

      at Object.toEqual (meetup.spec.js:309:52)

  ● Meetup › fourth Wednesday of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-28T00:00:00.000Z
    Received: Date { NaN }

      313 |
      314 |   test('fourth Wednesday of August 2013', () => {
    > 315 |     expect(meetup(2013, 8, 'fourth', 'Wednesday')).toEqual(
          |                                                    ^
      316 |       new Date(2013, 7, 28),
      317 |     );
      318 |   });

      at Object.toEqual (meetup.spec.js:315:52)

  ● Meetup › fourth Thursday of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-26T00:00:00.000Z
    Received: Date { NaN }

      319 |
      320 |   test('fourth Thursday of September 2013', () => {
    > 321 |     expect(meetup(2013, 9, 'fourth', 'Thursday')).toEqual(
          |                                                   ^
      322 |       new Date(2013, 8, 26),
      323 |     );
      324 |   });

      at Object.toEqual (meetup.spec.js:321:51)

  ● Meetup › fourth Thursday of October 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-10-24T00:00:00.000Z
    Received: Date { NaN }

      325 |
      326 |   test('fourth Thursday of October 2013', () => {
    > 327 |     expect(meetup(2013, 10, 'fourth', 'Thursday')).toEqual(
          |                                                    ^
      328 |       new Date(2013, 9, 24),
      329 |     );
      330 |   });

      at Object.toEqual (meetup.spec.js:327:52)

  ● Meetup › fourth Friday of November 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-11-22T00:00:00.000Z
    Received: Date { NaN }

      331 |
      332 |   test('fourth Friday of November 2013', () => {
    > 333 |     expect(meetup(2013, 11, 'fourth', 'Friday')).toEqual(
          |                                                  ^
      334 |       new Date(2013, 10, 22),
      335 |     );
      336 |   });

      at Object.toEqual (meetup.spec.js:333:50)

  ● Meetup › fourth Friday of December 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-12-27T00:00:00.000Z
    Received: Date { NaN }

      337 |
      338 |   test('fourth Friday of December 2013', () => {
    > 339 |     expect(meetup(2013, 12, 'fourth', 'Friday')).toEqual(
          |                                                  ^
      340 |       new Date(2013, 11, 27),
      341 |     );
      342 |   });

      at Object.toEqual (meetup.spec.js:339:50)

  ● Meetup › fourth Saturday of January 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-01-26T00:00:00.000Z
    Received: Date { NaN }

      343 |
      344 |   test('fourth Saturday of January 2013', () => {
    > 345 |     expect(meetup(2013, 1, 'fourth', 'Saturday')).toEqual(
          |                                                   ^
      346 |       new Date(2013, 0, 26),
      347 |     );
      348 |   });

      at Object.toEqual (meetup.spec.js:345:51)

  ● Meetup › fourth Saturday of February 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-02-23T00:00:00.000Z
    Received: Date { NaN }

      349 |
      350 |   test('fourth Saturday of February 2013', () => {
    > 351 |     expect(meetup(2013, 2, 'fourth', 'Saturday')).toEqual(
          |                                                   ^
      352 |       new Date(2013, 1, 23),
      353 |     );
      354 |   });

      at Object.toEqual (meetup.spec.js:351:51)

  ● Meetup › fourth Sunday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-24T00:00:00.000Z
    Received: Date { NaN }

      355 |
      356 |   test('fourth Sunday of March 2013', () => {
    > 357 |     expect(meetup(2013, 3, 'fourth', 'Sunday')).toEqual(new Date(2013, 2, 24));
          |                                                 ^
      358 |   });
      359 |
      360 |   test('fourth Sunday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:357:49)

  ● Meetup › fourth Sunday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-28T00:00:00.000Z
    Received: Date { NaN }

      359 |
      360 |   test('fourth Sunday of April 2013', () => {
    > 361 |     expect(meetup(2013, 4, 'fourth', 'Sunday')).toEqual(new Date(2013, 3, 28));
          |                                                 ^
      362 |   });
      363 |
      364 |   test('last Monday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:361:49)

  ● Meetup › last Monday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-25T00:00:00.000Z
    Received: Date { NaN }

      363 |
      364 |   test('last Monday of March 2013', () => {
    > 365 |     expect(meetup(2013, 3, 'last', 'Monday')).toEqual(new Date(2013, 2, 25));
          |                                               ^
      366 |   });
      367 |
      368 |   test('last Monday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:365:47)

  ● Meetup › last Monday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-29T00:00:00.000Z
    Received: Date { NaN }

      367 |
      368 |   test('last Monday of April 2013', () => {
    > 369 |     expect(meetup(2013, 4, 'last', 'Monday')).toEqual(new Date(2013, 3, 29));
          |                                               ^
      370 |   });
      371 |
      372 |   test('last Tuesday of May 2013', () => {

      at Object.toEqual (meetup.spec.js:369:47)

  ● Meetup › last Tuesday of May 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-05-28T00:00:00.000Z
    Received: Date { NaN }

      371 |
      372 |   test('last Tuesday of May 2013', () => {
    > 373 |     expect(meetup(2013, 5, 'last', 'Tuesday')).toEqual(new Date(2013, 4, 28));
          |                                                ^
      374 |   });
      375 |
      376 |   test('last Tuesday of June 2013', () => {

      at Object.toEqual (meetup.spec.js:373:48)

  ● Meetup › last Tuesday of June 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-06-25T00:00:00.000Z
    Received: Date { NaN }

      375 |
      376 |   test('last Tuesday of June 2013', () => {
    > 377 |     expect(meetup(2013, 6, 'last', 'Tuesday')).toEqual(new Date(2013, 5, 25));
          |                                                ^
      378 |   });
      379 |
      380 |   test('last Wednesday of July 2013', () => {

      at Object.toEqual (meetup.spec.js:377:48)

  ● Meetup › last Wednesday of July 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-07-31T00:00:00.000Z
    Received: Date { NaN }

      379 |
      380 |   test('last Wednesday of July 2013', () => {
    > 381 |     expect(meetup(2013, 7, 'last', 'Wednesday')).toEqual(new Date(2013, 6, 31));
          |                                                  ^
      382 |   });
      383 |
      384 |   test('last Wednesday of August 2013', () => {

      at Object.toEqual (meetup.spec.js:381:50)

  ● Meetup › last Wednesday of August 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-08-28T00:00:00.000Z
    Received: Date { NaN }

      383 |
      384 |   test('last Wednesday of August 2013', () => {
    > 385 |     expect(meetup(2013, 8, 'last', 'Wednesday')).toEqual(new Date(2013, 7, 28));
          |                                                  ^
      386 |   });
      387 |
      388 |   test('last Thursday of September 2013', () => {

      at Object.toEqual (meetup.spec.js:385:50)

  ● Meetup › last Thursday of September 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-09-26T00:00:00.000Z
    Received: Date { NaN }

      387 |
      388 |   test('last Thursday of September 2013', () => {
    > 389 |     expect(meetup(2013, 9, 'last', 'Thursday')).toEqual(new Date(2013, 8, 26));
          |                                                 ^
      390 |   });
      391 |
      392 |   test('last Thursday of October 2013', () => {

      at Object.toEqual (meetup.spec.js:389:49)

  ● Meetup › last Thursday of October 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-10-31T00:00:00.000Z
    Received: Date { NaN }

      391 |
      392 |   test('last Thursday of October 2013', () => {
    > 393 |     expect(meetup(2013, 10, 'last', 'Thursday')).toEqual(new Date(2013, 9, 31));
          |                                                  ^
      394 |   });
      395 |
      396 |   test('last Friday of November 2013', () => {

      at Object.toEqual (meetup.spec.js:393:50)

  ● Meetup › last Friday of November 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-11-29T00:00:00.000Z
    Received: Date { NaN }

      395 |
      396 |   test('last Friday of November 2013', () => {
    > 397 |     expect(meetup(2013, 11, 'last', 'Friday')).toEqual(new Date(2013, 10, 29));
          |                                                ^
      398 |   });
      399 |
      400 |   test('last Friday of December 2013', () => {

      at Object.toEqual (meetup.spec.js:397:48)

  ● Meetup › last Friday of December 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-12-27T00:00:00.000Z
    Received: Date { NaN }

      399 |
      400 |   test('last Friday of December 2013', () => {
    > 401 |     expect(meetup(2013, 12, 'last', 'Friday')).toEqual(new Date(2013, 11, 27));
          |                                                ^
      402 |   });
      403 |
      404 |   test('last Saturday of January 2013', () => {

      at Object.toEqual (meetup.spec.js:401:48)

  ● Meetup › last Saturday of January 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-01-26T00:00:00.000Z
    Received: Date { NaN }

      403 |
      404 |   test('last Saturday of January 2013', () => {
    > 405 |     expect(meetup(2013, 1, 'last', 'Saturday')).toEqual(new Date(2013, 0, 26));
          |                                                 ^
      406 |   });
      407 |
      408 |   test('last Saturday of February 2013', () => {

      at Object.toEqual (meetup.spec.js:405:49)

  ● Meetup › last Saturday of February 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-02-23T00:00:00.000Z
    Received: Date { NaN }

      407 |
      408 |   test('last Saturday of February 2013', () => {
    > 409 |     expect(meetup(2013, 2, 'last', 'Saturday')).toEqual(new Date(2013, 1, 23));
          |                                                 ^
      410 |   });
      411 |
      412 |   test('last Sunday of March 2013', () => {

      at Object.toEqual (meetup.spec.js:409:49)

  ● Meetup › last Sunday of March 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-03-31T00:00:00.000Z
    Received: Date { NaN }

      411 |
      412 |   test('last Sunday of March 2013', () => {
    > 413 |     expect(meetup(2013, 3, 'last', 'Sunday')).toEqual(new Date(2013, 2, 31));
          |                                               ^
      414 |   });
      415 |
      416 |   test('last Sunday of April 2013', () => {

      at Object.toEqual (meetup.spec.js:413:47)

  ● Meetup › last Sunday of April 2013

    expect(received).toEqual(expected) // deep equality

    Expected: 2013-04-28T00:00:00.000Z
    Received: Date { NaN }

      415 |
      416 |   test('last Sunday of April 2013', () => {
    > 417 |     expect(meetup(2013, 4, 'last', 'Sunday')).toEqual(new Date(2013, 3, 28));
          |                                               ^
      418 |   });
      419 |
      420 |   test('last Wednesday of February 2012', () => {

      at Object.toEqual (meetup.spec.js:417:47)

  ● Meetup › last Wednesday of February 2012

    expect(received).toEqual(expected) // deep equality

    Expected: 2012-02-29T00:00:00.000Z
    Received: Date { NaN }

      419 |
      420 |   test('last Wednesday of February 2012', () => {
    > 421 |     expect(meetup(2012, 2, 'last', 'Wednesday')).toEqual(new Date(2012, 1, 29));
          |                                                  ^
      422 |   });
      423 |
      424 |   test('last Wednesday of December 2014', () => {

      at Object.toEqual (meetup.spec.js:421:50)

  ● Meetup › last Wednesday of December 2014

    expect(received).toEqual(expected) // deep equality

    Expected: 2014-12-31T00:00:00.000Z
    Received: Date { NaN }

      423 |
      424 |   test('last Wednesday of December 2014', () => {
    > 425 |     expect(meetup(2014, 12, 'last', 'Wednesday')).toEqual(
          |                                                   ^
      426 |       new Date(2014, 11, 31),
      427 |     );
      428 |   });

      at Object.toEqual (meetup.spec.js:425:51)

  ● Meetup › last Sunday of February 2015

    expect(received).toEqual(expected) // deep equality

    Expected: 2015-02-22T00:00:00.000Z
    Received: Date { NaN }

      429 |
      430 |   test('last Sunday of February 2015', () => {
    > 431 |     expect(meetup(2015, 2, 'last', 'Sunday')).toEqual(new Date(2015, 1, 22));
          |                                               ^
      432 |   });
      433 |
      434 |   test('first Friday of December 2012', () => {

      at Object.toEqual (meetup.spec.js:431:47)

  ● Meetup › first Friday of December 2012

    expect(received).toEqual(expected) // deep equality

    Expected: 2012-12-07T00:00:00.000Z
    Received: Date { NaN }

      433 |
      434 |   test('first Friday of December 2012', () => {
    > 435 |     expect(meetup(2012, 12, 'first', 'Friday')).toEqual(new Date(2012, 11, 7));
          |                                                 ^
      436 |   });
      437 | });
      438 |

      at Object.toEqual (meetup.spec.js:435:49)

Test Suites: 1 failed, 1 total
Tests:       95 failed, 95 total
Snapshots:   0 total
Time:        1.009 s
Ran all test suites matching ./LICENSE|./babel.config.js|./meetup.js|./meetup.spec.js|./node_modules|./package-lock.json|./package.json.

```
####   
#### > test  
#### > jest ./*  
####   
#### FAIL ./meetup.spec.js  
####   Meetup  
####     ✕ monteenth of May 2013 (5 ms)  
####     ✕ monteenth of August 2013 (1 ms)  
####     ✕ monteenth of September 2013  
####     ✕ tuesteenth of March 2013 (1 ms)  
####     ✕ tuesteenth of April 2013 (1 ms)  
####     ✕ tuesteenth of August 2013 (1 ms)  
####     ✕ wednesteenth of January 2013 (1 ms)  
####     ✕ wednesteenth of February 2013 (1 ms)  
####     ✕ wednesteenth of June 2013 (1 ms)  
####     ✕ thursteenth of May 2013  
####     ✕ thursteenth of June 2013 (1 ms)  
####     ✕ thursteenth of September 2013 (1 ms)  
####     ✕ friteenth of April 2013 (1 ms)  
####     ✕ friteenth of August 2013 (1 ms)  
####     ✕ friteenth of September 2013 (1 ms)  
####     ✕ saturteenth of February 2013  
####     ✕ saturteenth of April 2013  
####     ✕ saturteenth of October 2013 (1 ms)  
####     ✕ sunteenth of May 2013 (1 ms)  
####     ✕ sunteenth of June 2013  
####     ✕ sunteenth of October 2013  
####     ✕ first Monday of March 2013  
####     ✕ first Monday of April 2013  
####     ✕ first Tuesday of May 2013  
####     ✕ first Tuesday of June 2013  
####     ✕ first Wednesday of July 2013  
####     ✕ first Wednesday of August 2013 (1 ms)  
####     ✕ first Thursday of September 2013 (1 ms)  
####     ✕ first Thursday of October 2013 (1 ms)  
####     ✕ first Friday of November 2013 (1 ms)  
####     ✕ first Friday of December 2013 (1 ms)  
####     ✕ first Saturday of January 2013 (1 ms)  
####     ✕ first Saturday of February 2013 (1 ms)  
####     ✕ first Sunday of March 2013 (1 ms)  
####     ✕ first Sunday of April 2013  
####     ✕ second Monday of March 2013  
####     ✕ second Monday of April 2013 (1 ms)  
####     ✕ second Tuesday of May 2013 (1 ms)  
####     ✕ second Tuesday of June 2013 (1 ms)  
####     ✕ second Wednesday of July 2013  
####     ✕ second Wednesday of August 2013  
####     ✕ second Thursday of September 2013 (1 ms)  
####     ✕ second Thursday of October 2013  
####     ✕ second Friday of November 2013  
####     ✕ second Friday of December 2013  
####     ✕ second Saturday of January 2013  
####     ✕ second Saturday of February 2013 (1 ms)  
####     ✕ second Sunday of March 2013  
####     ✕ second Sunday of April 2013  
####     ✕ third Monday of March 2013  
####     ✕ third Monday of April 2013  
####     ✕ third Tuesday of May 2013  
####     ✕ third Tuesday of June 2013  
####     ✕ third Wednesday of July 2013  
####     ✕ third Wednesday of August 2013  
####     ✕ third Thursday of September 2013 (1 ms)  
####     ✕ third Thursday of October 2013  
####     ✕ third Friday of November 2013 (1 ms)  
####     ✕ third Friday of December 2013  
####     ✕ third Saturday of January 2013 (1 ms)  
####     ✕ third Saturday of February 2013 (1 ms)  
####     ✕ third Sunday of March 2013 (1 ms)  
####     ✕ third Sunday of April 2013 (1 ms)  
####     ✕ fourth Monday of March 2013 (1 ms)  
####     ✕ fourth Monday of April 2013  
####     ✕ fourth Tuesday of May 2013 (1 ms)  
####     ✕ fourth Tuesday of June 2013  
####     ✕ fourth Wednesday of July 2013  
####     ✕ fourth Wednesday of August 2013  
####     ✕ fourth Thursday of September 2013  
####     ✕ fourth Thursday of October 2013 (1 ms)  
####     ✕ fourth Friday of November 2013  
####     ✕ fourth Friday of December 2013 (1 ms)  
####     ✕ fourth Saturday of January 2013  
####     ✕ fourth Saturday of February 2013 (1 ms)  
####     ✕ fourth Sunday of March 2013  
####     ✕ fourth Sunday of April 2013 (1 ms)  
####     ✕ last Monday of March 2013  
####     ✕ last Monday of April 2013 (3 ms)  
####     ✕ last Tuesday of May 2013 (1 ms)  
####     ✕ last Tuesday of June 2013  
####     ✕ last Wednesday of July 2013  
####     ✕ last Wednesday of August 2013  
####     ✕ last Thursday of September 2013  
####     ✕ last Thursday of October 2013 (1 ms)  
####     ✕ last Friday of November 2013  
####     ✕ last Friday of December 2013 (1 ms)  
####     ✕ last Saturday of January 2013  
####     ✕ last Saturday of February 2013 (1 ms)  
####     ✕ last Sunday of March 2013  
####     ✕ last Sunday of April 2013  
####     ✕ last Wednesday of February 2012 (1 ms)  
####     ✕ last Wednesday of December 2014  
####     ✕ last Sunday of February 2015  
####     ✕ first Friday of December 2012  
####   
####   ● Meetup › monteenth of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       3 | describe('Meetup', () => {  
####       4 |   test('monteenth of May 2013', () => {  
####     > 5 |     expect(meetup(2013, 5, 'teenth', 'Monday')).toEqual(new Date(2013, 4, 13));  
####         |                                                 ^  
####       6 |   });  
####       7 |  
####       8 |   test('monteenth of August 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:5:49)  
####   
####   ● Meetup › monteenth of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####        7 |  
####        8 |   test('monteenth of August 2013', () => {  
####     >  9 |     expect(meetup(2013, 8, 'teenth', 'Monday')).toEqual(new Date(2013, 7, 19));  
####          |                                                 ^  
####       10 |   });  
####       11 |  
####       12 |   test('monteenth of September 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:9:49)  
####   
####   ● Meetup › monteenth of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       11 |  
####       12 |   test('monteenth of September 2013', () => {  
####     > 13 |     expect(meetup(2013, 9, 'teenth', 'Monday')).toEqual(new Date(2013, 8, 16));  
####          |                                                 ^  
####       14 |   });  
####       15 |  
####       16 |   test('tuesteenth of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:13:49)  
####   
####   ● Meetup › tuesteenth of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       15 |  
####       16 |   test('tuesteenth of March 2013', () => {  
####     > 17 |     expect(meetup(2013, 3, 'teenth', 'Tuesday')).toEqual(new Date(2013, 2, 19));  
####          |                                                  ^  
####       18 |   });  
####       19 |  
####       20 |   test('tuesteenth of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:17:50)  
####   
####   ● Meetup › tuesteenth of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       19 |  
####       20 |   test('tuesteenth of April 2013', () => {  
####     > 21 |     expect(meetup(2013, 4, 'teenth', 'Tuesday')).toEqual(new Date(2013, 3, 16));  
####          |                                                  ^  
####       22 |   });  
####       23 |  
####       24 |   test('tuesteenth of August 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:21:50)  
####   
####   ● Meetup › tuesteenth of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       23 |  
####       24 |   test('tuesteenth of August 2013', () => {  
####     > 25 |     expect(meetup(2013, 8, 'teenth', 'Tuesday')).toEqual(new Date(2013, 7, 13));  
####          |                                                  ^  
####       26 |   });  
####       27 |  
####       28 |   test('wednesteenth of January 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:25:50)  
####   
####   ● Meetup › wednesteenth of January 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-01-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       27 |  
####       28 |   test('wednesteenth of January 2013', () => {  
####     > 29 |     expect(meetup(2013, 1, 'teenth', 'Wednesday')).toEqual(  
####          |                                                    ^  
####       30 |       new Date(2013, 0, 16),  
####       31 |     );  
####       32 |   });  
####   
####       at Object.toEqual (meetup.spec.js:29:52)  
####   
####   ● Meetup › wednesteenth of February 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-02-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       33 |  
####       34 |   test('wednesteenth of February 2013', () => {  
####     > 35 |     expect(meetup(2013, 2, 'teenth', 'Wednesday')).toEqual(  
####          |                                                    ^  
####       36 |       new Date(2013, 1, 13),  
####       37 |     );  
####       38 |   });  
####   
####       at Object.toEqual (meetup.spec.js:35:52)  
####   
####   ● Meetup › wednesteenth of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       39 |  
####       40 |   test('wednesteenth of June 2013', () => {  
####     > 41 |     expect(meetup(2013, 6, 'teenth', 'Wednesday')).toEqual(  
####          |                                                    ^  
####       42 |       new Date(2013, 5, 19),  
####       43 |     );  
####       44 |   });  
####   
####       at Object.toEqual (meetup.spec.js:41:52)  
####   
####   ● Meetup › thursteenth of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       45 |  
####       46 |   test('thursteenth of May 2013', () => {  
####     > 47 |     expect(meetup(2013, 5, 'teenth', 'Thursday')).toEqual(  
####          |                                                   ^  
####       48 |       new Date(2013, 4, 16),  
####       49 |     );  
####       50 |   });  
####   
####       at Object.toEqual (meetup.spec.js:47:51)  
####   
####   ● Meetup › thursteenth of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       51 |  
####       52 |   test('thursteenth of June 2013', () => {  
####     > 53 |     expect(meetup(2013, 6, 'teenth', 'Thursday')).toEqual(  
####          |                                                   ^  
####       54 |       new Date(2013, 5, 13),  
####       55 |     );  
####       56 |   });  
####   
####       at Object.toEqual (meetup.spec.js:53:51)  
####   
####   ● Meetup › thursteenth of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       57 |  
####       58 |   test('thursteenth of September 2013', () => {  
####     > 59 |     expect(meetup(2013, 9, 'teenth', 'Thursday')).toEqual(  
####          |                                                   ^  
####       60 |       new Date(2013, 8, 19),  
####       61 |     );  
####       62 |   });  
####   
####       at Object.toEqual (meetup.spec.js:59:51)  
####   
####   ● Meetup › friteenth of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       63 |  
####       64 |   test('friteenth of April 2013', () => {  
####     > 65 |     expect(meetup(2013, 4, 'teenth', 'Friday')).toEqual(new Date(2013, 3, 19));  
####          |                                                 ^  
####       66 |   });  
####       67 |  
####       68 |   test('friteenth of August 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:65:49)  
####   
####   ● Meetup › friteenth of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       67 |  
####       68 |   test('friteenth of August 2013', () => {  
####     > 69 |     expect(meetup(2013, 8, 'teenth', 'Friday')).toEqual(new Date(2013, 7, 16));  
####          |                                                 ^  
####       70 |   });  
####       71 |  
####       72 |   test('friteenth of September 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:69:49)  
####   
####   ● Meetup › friteenth of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       71 |  
####       72 |   test('friteenth of September 2013', () => {  
####     > 73 |     expect(meetup(2013, 9, 'teenth', 'Friday')).toEqual(new Date(2013, 8, 13));  
####          |                                                 ^  
####       74 |   });  
####       75 |  
####       76 |   test('saturteenth of February 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:73:49)  
####   
####   ● Meetup › saturteenth of February 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-02-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       75 |  
####       76 |   test('saturteenth of February 2013', () => {  
####     > 77 |     expect(meetup(2013, 2, 'teenth', 'Saturday')).toEqual(  
####          |                                                   ^  
####       78 |       new Date(2013, 1, 16),  
####       79 |     );  
####       80 |   });  
####   
####       at Object.toEqual (meetup.spec.js:77:51)  
####   
####   ● Meetup › saturteenth of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       81 |  
####       82 |   test('saturteenth of April 2013', () => {  
####     > 83 |     expect(meetup(2013, 4, 'teenth', 'Saturday')).toEqual(  
####          |                                                   ^  
####       84 |       new Date(2013, 3, 13),  
####       85 |     );  
####       86 |   });  
####   
####       at Object.toEqual (meetup.spec.js:83:51)  
####   
####   ● Meetup › saturteenth of October 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-10-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       87 |  
####       88 |   test('saturteenth of October 2013', () => {  
####     > 89 |     expect(meetup(2013, 10, 'teenth', 'Saturday')).toEqual(  
####          |                                                    ^  
####       90 |       new Date(2013, 9, 19),  
####       91 |     );  
####       92 |   });  
####   
####       at Object.toEqual (meetup.spec.js:89:52)  
####   
####   ● Meetup › sunteenth of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       93 |  
####       94 |   test('sunteenth of May 2013', () => {  
####     > 95 |     expect(meetup(2013, 5, 'teenth', 'Sunday')).toEqual(new Date(2013, 4, 19));  
####          |                                                 ^  
####       96 |   });  
####       97 |  
####       98 |   test('sunteenth of June 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:95:49)  
####   
####   ● Meetup › sunteenth of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####        97 |  
####        98 |   test('sunteenth of June 2013', () => {  
####     >  99 |     expect(meetup(2013, 6, 'teenth', 'Sunday')).toEqual(new Date(2013, 5, 16));  
####           |                                                 ^  
####       100 |   });  
####       101 |  
####       102 |   test('sunteenth of October 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:99:49)  
####   
####   ● Meetup › sunteenth of October 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-10-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       101 |  
####       102 |   test('sunteenth of October 2013', () => {  
####     > 103 |     expect(meetup(2013, 10, 'teenth', 'Sunday')).toEqual(new Date(2013, 9, 13));  
####           |                                                  ^  
####       104 |   });  
####       105 |  
####       106 |   test('first Monday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:103:50)  
####   
####   ● Meetup › first Monday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-04T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       105 |  
####       106 |   test('first Monday of March 2013', () => {  
####     > 107 |     expect(meetup(2013, 3, 'first', 'Monday')).toEqual(new Date(2013, 2, 4));  
####           |                                                ^  
####       108 |   });  
####       109 |  
####       110 |   test('first Monday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:107:48)  
####   
####   ● Meetup › first Monday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-01T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       109 |  
####       110 |   test('first Monday of April 2013', () => {  
####     > 111 |     expect(meetup(2013, 4, 'first', 'Monday')).toEqual(new Date(2013, 3, 1));  
####           |                                                ^  
####       112 |   });  
####       113 |  
####       114 |   test('first Tuesday of May 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:111:48)  
####   
####   ● Meetup › first Tuesday of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-07T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       113 |  
####       114 |   test('first Tuesday of May 2013', () => {  
####     > 115 |     expect(meetup(2013, 5, 'first', 'Tuesday')).toEqual(new Date(2013, 4, 7));  
####           |                                                 ^  
####       116 |   });  
####       117 |  
####       118 |   test('first Tuesday of June 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:115:49)  
####   
####   ● Meetup › first Tuesday of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-04T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       117 |  
####       118 |   test('first Tuesday of June 2013', () => {  
####     > 119 |     expect(meetup(2013, 6, 'first', 'Tuesday')).toEqual(new Date(2013, 5, 4));  
####           |                                                 ^  
####       120 |   });  
####       121 |  
####       122 |   test('first Wednesday of July 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:119:49)  
####   
####   ● Meetup › first Wednesday of July 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-07-03T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       121 |  
####       122 |   test('first Wednesday of July 2013', () => {  
####     > 123 |     expect(meetup(2013, 7, 'first', 'Wednesday')).toEqual(new Date(2013, 6, 3));  
####           |                                                   ^  
####       124 |   });  
####       125 |  
####       126 |   test('first Wednesday of August 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:123:51)  
####   
####   ● Meetup › first Wednesday of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-07T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       125 |  
####       126 |   test('first Wednesday of August 2013', () => {  
####     > 127 |     expect(meetup(2013, 8, 'first', 'Wednesday')).toEqual(new Date(2013, 7, 7));  
####           |                                                   ^  
####       128 |   });  
####       129 |  
####       130 |   test('first Thursday of September 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:127:51)  
####   
####   ● Meetup › first Thursday of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-05T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       129 |  
####       130 |   test('first Thursday of September 2013', () => {  
####     > 131 |     expect(meetup(2013, 9, 'first', 'Thursday')).toEqual(new Date(2013, 8, 5));  
####           |                                                  ^  
####       132 |   });  
####       133 |  
####       134 |   test('first Thursday of October 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:131:50)  
####   
####   ● Meetup › first Thursday of October 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-10-03T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       133 |  
####       134 |   test('first Thursday of October 2013', () => {  
####     > 135 |     expect(meetup(2013, 10, 'first', 'Thursday')).toEqual(new Date(2013, 9, 3));  
####           |                                                   ^  
####       136 |   });  
####       137 |  
####       138 |   test('first Friday of November 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:135:51)  
####   
####   ● Meetup › first Friday of November 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-11-01T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       137 |  
####       138 |   test('first Friday of November 2013', () => {  
####     > 139 |     expect(meetup(2013, 11, 'first', 'Friday')).toEqual(new Date(2013, 10, 1));  
####           |                                                 ^  
####       140 |   });  
####       141 |  
####       142 |   test('first Friday of December 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:139:49)  
####   
####   ● Meetup › first Friday of December 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-12-06T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       141 |  
####       142 |   test('first Friday of December 2013', () => {  
####     > 143 |     expect(meetup(2013, 12, 'first', 'Friday')).toEqual(new Date(2013, 11, 6));  
####           |                                                 ^  
####       144 |   });  
####       145 |  
####       146 |   test('first Saturday of January 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:143:49)  
####   
####   ● Meetup › first Saturday of January 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-01-05T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       145 |  
####       146 |   test('first Saturday of January 2013', () => {  
####     > 147 |     expect(meetup(2013, 1, 'first', 'Saturday')).toEqual(new Date(2013, 0, 5));  
####           |                                                  ^  
####       148 |   });  
####       149 |  
####       150 |   test('first Saturday of February 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:147:50)  
####   
####   ● Meetup › first Saturday of February 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-02-02T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       149 |  
####       150 |   test('first Saturday of February 2013', () => {  
####     > 151 |     expect(meetup(2013, 2, 'first', 'Saturday')).toEqual(new Date(2013, 1, 2));  
####           |                                                  ^  
####       152 |   });  
####       153 |  
####       154 |   test('first Sunday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:151:50)  
####   
####   ● Meetup › first Sunday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-03T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       153 |  
####       154 |   test('first Sunday of March 2013', () => {  
####     > 155 |     expect(meetup(2013, 3, 'first', 'Sunday')).toEqual(new Date(2013, 2, 3));  
####           |                                                ^  
####       156 |   });  
####       157 |  
####       158 |   test('first Sunday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:155:48)  
####   
####   ● Meetup › first Sunday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-07T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       157 |  
####       158 |   test('first Sunday of April 2013', () => {  
####     > 159 |     expect(meetup(2013, 4, 'first', 'Sunday')).toEqual(new Date(2013, 3, 7));  
####           |                                                ^  
####       160 |   });  
####       161 |  
####       162 |   test('second Monday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:159:48)  
####   
####   ● Meetup › second Monday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-11T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       161 |  
####       162 |   test('second Monday of March 2013', () => {  
####     > 163 |     expect(meetup(2013, 3, 'second', 'Monday')).toEqual(new Date(2013, 2, 11));  
####           |                                                 ^  
####       164 |   });  
####       165 |  
####       166 |   test('second Monday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:163:49)  
####   
####   ● Meetup › second Monday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-08T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       165 |  
####       166 |   test('second Monday of April 2013', () => {  
####     > 167 |     expect(meetup(2013, 4, 'second', 'Monday')).toEqual(new Date(2013, 3, 8));  
####           |                                                 ^  
####       168 |   });  
####       169 |  
####       170 |   test('second Tuesday of May 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:167:49)  
####   
####   ● Meetup › second Tuesday of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-14T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       169 |  
####       170 |   test('second Tuesday of May 2013', () => {  
####     > 171 |     expect(meetup(2013, 5, 'second', 'Tuesday')).toEqual(new Date(2013, 4, 14));  
####           |                                                  ^  
####       172 |   });  
####       173 |  
####       174 |   test('second Tuesday of June 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:171:50)  
####   
####   ● Meetup › second Tuesday of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-11T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       173 |  
####       174 |   test('second Tuesday of June 2013', () => {  
####     > 175 |     expect(meetup(2013, 6, 'second', 'Tuesday')).toEqual(new Date(2013, 5, 11));  
####           |                                                  ^  
####       176 |   });  
####       177 |  
####       178 |   test('second Wednesday of July 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:175:50)  
####   
####   ● Meetup › second Wednesday of July 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-07-10T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       177 |  
####       178 |   test('second Wednesday of July 2013', () => {  
####     > 179 |     expect(meetup(2013, 7, 'second', 'Wednesday')).toEqual(  
####           |                                                    ^  
####       180 |       new Date(2013, 6, 10),  
####       181 |     );  
####       182 |   });  
####   
####       at Object.toEqual (meetup.spec.js:179:52)  
####   
####   ● Meetup › second Wednesday of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-14T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       183 |  
####       184 |   test('second Wednesday of August 2013', () => {  
####     > 185 |     expect(meetup(2013, 8, 'second', 'Wednesday')).toEqual(  
####           |                                                    ^  
####       186 |       new Date(2013, 7, 14),  
####       187 |     );  
####       188 |   });  
####   
####       at Object.toEqual (meetup.spec.js:185:52)  
####   
####   ● Meetup › second Thursday of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-12T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       189 |  
####       190 |   test('second Thursday of September 2013', () => {  
####     > 191 |     expect(meetup(2013, 9, 'second', 'Thursday')).toEqual(  
####           |                                                   ^  
####       192 |       new Date(2013, 8, 12),  
####       193 |     );  
####       194 |   });  
####   
####       at Object.toEqual (meetup.spec.js:191:51)  
####   
####   ● Meetup › second Thursday of October 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-10-10T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       195 |  
####       196 |   test('second Thursday of October 2013', () => {  
####     > 197 |     expect(meetup(2013, 10, 'second', 'Thursday')).toEqual(  
####           |                                                    ^  
####       198 |       new Date(2013, 9, 10),  
####       199 |     );  
####       200 |   });  
####   
####       at Object.toEqual (meetup.spec.js:197:52)  
####   
####   ● Meetup › second Friday of November 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-11-08T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       201 |  
####       202 |   test('second Friday of November 2013', () => {  
####     > 203 |     expect(meetup(2013, 11, 'second', 'Friday')).toEqual(new Date(2013, 10, 8));  
####           |                                                  ^  
####       204 |   });  
####       205 |  
####       206 |   test('second Friday of December 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:203:50)  
####   
####   ● Meetup › second Friday of December 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-12-13T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       205 |  
####       206 |   test('second Friday of December 2013', () => {  
####     > 207 |     expect(meetup(2013, 12, 'second', 'Friday')).toEqual(  
####           |                                                  ^  
####       208 |       new Date(2013, 11, 13),  
####       209 |     );  
####       210 |   });  
####   
####       at Object.toEqual (meetup.spec.js:207:50)  
####   
####   ● Meetup › second Saturday of January 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-01-12T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       211 |  
####       212 |   test('second Saturday of January 2013', () => {  
####     > 213 |     expect(meetup(2013, 1, 'second', 'Saturday')).toEqual(  
####           |                                                   ^  
####       214 |       new Date(2013, 0, 12),  
####       215 |     );  
####       216 |   });  
####   
####       at Object.toEqual (meetup.spec.js:213:51)  
####   
####   ● Meetup › second Saturday of February 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-02-09T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       217 |  
####       218 |   test('second Saturday of February 2013', () => {  
####     > 219 |     expect(meetup(2013, 2, 'second', 'Saturday')).toEqual(new Date(2013, 1, 9));  
####           |                                                   ^  
####       220 |   });  
####       221 |  
####       222 |   test('second Sunday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:219:51)  
####   
####   ● Meetup › second Sunday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-10T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       221 |  
####       222 |   test('second Sunday of March 2013', () => {  
####     > 223 |     expect(meetup(2013, 3, 'second', 'Sunday')).toEqual(new Date(2013, 2, 10));  
####           |                                                 ^  
####       224 |   });  
####       225 |  
####       226 |   test('second Sunday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:223:49)  
####   
####   ● Meetup › second Sunday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-14T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       225 |  
####       226 |   test('second Sunday of April 2013', () => {  
####     > 227 |     expect(meetup(2013, 4, 'second', 'Sunday')).toEqual(new Date(2013, 3, 14));  
####           |                                                 ^  
####       228 |   });  
####       229 |  
####       230 |   test('third Monday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:227:49)  
####   
####   ● Meetup › third Monday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-18T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       229 |  
####       230 |   test('third Monday of March 2013', () => {  
####     > 231 |     expect(meetup(2013, 3, 'third', 'Monday')).toEqual(new Date(2013, 2, 18));  
####           |                                                ^  
####       232 |   });  
####       233 |  
####       234 |   test('third Monday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:231:48)  
####   
####   ● Meetup › third Monday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-15T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       233 |  
####       234 |   test('third Monday of April 2013', () => {  
####     > 235 |     expect(meetup(2013, 4, 'third', 'Monday')).toEqual(new Date(2013, 3, 15));  
####           |                                                ^  
####       236 |   });  
####       237 |  
####       238 |   test('third Tuesday of May 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:235:48)  
####   
####   ● Meetup › third Tuesday of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-21T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       237 |  
####       238 |   test('third Tuesday of May 2013', () => {  
####     > 239 |     expect(meetup(2013, 5, 'third', 'Tuesday')).toEqual(new Date(2013, 4, 21));  
####           |                                                 ^  
####       240 |   });  
####       241 |  
####       242 |   test('third Tuesday of June 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:239:49)  
####   
####   ● Meetup › third Tuesday of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-18T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       241 |  
####       242 |   test('third Tuesday of June 2013', () => {  
####     > 243 |     expect(meetup(2013, 6, 'third', 'Tuesday')).toEqual(new Date(2013, 5, 18));  
####           |                                                 ^  
####       244 |   });  
####       245 |  
####       246 |   test('third Wednesday of July 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:243:49)  
####   
####   ● Meetup › third Wednesday of July 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-07-17T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       245 |  
####       246 |   test('third Wednesday of July 2013', () => {  
####     > 247 |     expect(meetup(2013, 7, 'third', 'Wednesday')).toEqual(  
####           |                                                   ^  
####       248 |       new Date(2013, 6, 17),  
####       249 |     );  
####       250 |   });  
####   
####       at Object.toEqual (meetup.spec.js:247:51)  
####   
####   ● Meetup › third Wednesday of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-21T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       251 |  
####       252 |   test('third Wednesday of August 2013', () => {  
####     > 253 |     expect(meetup(2013, 8, 'third', 'Wednesday')).toEqual(  
####           |                                                   ^  
####       254 |       new Date(2013, 7, 21),  
####       255 |     );  
####       256 |   });  
####   
####       at Object.toEqual (meetup.spec.js:253:51)  
####   
####   ● Meetup › third Thursday of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       257 |  
####       258 |   test('third Thursday of September 2013', () => {  
####     > 259 |     expect(meetup(2013, 9, 'third', 'Thursday')).toEqual(new Date(2013, 8, 19));  
####           |                                                  ^  
####       260 |   });  
####       261 |  
####       262 |   test('third Thursday of October 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:259:50)  
####   
####   ● Meetup › third Thursday of October 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-10-17T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       261 |  
####       262 |   test('third Thursday of October 2013', () => {  
####     > 263 |     expect(meetup(2013, 10, 'third', 'Thursday')).toEqual(  
####           |                                                   ^  
####       264 |       new Date(2013, 9, 17),  
####       265 |     );  
####       266 |   });  
####   
####       at Object.toEqual (meetup.spec.js:263:51)  
####   
####   ● Meetup › third Friday of November 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-11-15T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       267 |  
####       268 |   test('third Friday of November 2013', () => {  
####     > 269 |     expect(meetup(2013, 11, 'third', 'Friday')).toEqual(new Date(2013, 10, 15));  
####           |                                                 ^  
####       270 |   });  
####       271 |  
####       272 |   test('third Friday of December 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:269:49)  
####   
####   ● Meetup › third Friday of December 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-12-20T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       271 |  
####       272 |   test('third Friday of December 2013', () => {  
####     > 273 |     expect(meetup(2013, 12, 'third', 'Friday')).toEqual(new Date(2013, 11, 20));  
####           |                                                 ^  
####       274 |   });  
####       275 |  
####       276 |   test('third Saturday of January 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:273:49)  
####   
####   ● Meetup › third Saturday of January 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-01-19T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       275 |  
####       276 |   test('third Saturday of January 2013', () => {  
####     > 277 |     expect(meetup(2013, 1, 'third', 'Saturday')).toEqual(new Date(2013, 0, 19));  
####           |                                                  ^  
####       278 |   });  
####       279 |  
####       280 |   test('third Saturday of February 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:277:50)  
####   
####   ● Meetup › third Saturday of February 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-02-16T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       279 |  
####       280 |   test('third Saturday of February 2013', () => {  
####     > 281 |     expect(meetup(2013, 2, 'third', 'Saturday')).toEqual(new Date(2013, 1, 16));  
####           |                                                  ^  
####       282 |   });  
####       283 |  
####       284 |   test('third Sunday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:281:50)  
####   
####   ● Meetup › third Sunday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-17T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       283 |  
####       284 |   test('third Sunday of March 2013', () => {  
####     > 285 |     expect(meetup(2013, 3, 'third', 'Sunday')).toEqual(new Date(2013, 2, 17));  
####           |                                                ^  
####       286 |   });  
####       287 |  
####       288 |   test('third Sunday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:285:48)  
####   
####   ● Meetup › third Sunday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-21T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       287 |  
####       288 |   test('third Sunday of April 2013', () => {  
####     > 289 |     expect(meetup(2013, 4, 'third', 'Sunday')).toEqual(new Date(2013, 3, 21));  
####           |                                                ^  
####       290 |   });  
####       291 |  
####       292 |   test('fourth Monday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:289:48)  
####   
####   ● Meetup › fourth Monday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-25T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       291 |  
####       292 |   test('fourth Monday of March 2013', () => {  
####     > 293 |     expect(meetup(2013, 3, 'fourth', 'Monday')).toEqual(new Date(2013, 2, 25));  
####           |                                                 ^  
####       294 |   });  
####       295 |  
####       296 |   test('fourth Monday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:293:49)  
####   
####   ● Meetup › fourth Monday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-22T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       295 |  
####       296 |   test('fourth Monday of April 2013', () => {  
####     > 297 |     expect(meetup(2013, 4, 'fourth', 'Monday')).toEqual(new Date(2013, 3, 22));  
####           |                                                 ^  
####       298 |   });  
####       299 |  
####       300 |   test('fourth Tuesday of May 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:297:49)  
####   
####   ● Meetup › fourth Tuesday of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-28T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       299 |  
####       300 |   test('fourth Tuesday of May 2013', () => {  
####     > 301 |     expect(meetup(2013, 5, 'fourth', 'Tuesday')).toEqual(new Date(2013, 4, 28));  
####           |                                                  ^  
####       302 |   });  
####       303 |  
####       304 |   test('fourth Tuesday of June 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:301:50)  
####   
####   ● Meetup › fourth Tuesday of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-25T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       303 |  
####       304 |   test('fourth Tuesday of June 2013', () => {  
####     > 305 |     expect(meetup(2013, 6, 'fourth', 'Tuesday')).toEqual(new Date(2013, 5, 25));  
####           |                                                  ^  
####       306 |   });  
####       307 |  
####       308 |   test('fourth Wednesday of July 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:305:50)  
####   
####   ● Meetup › fourth Wednesday of July 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-07-24T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       307 |  
####       308 |   test('fourth Wednesday of July 2013', () => {  
####     > 309 |     expect(meetup(2013, 7, 'fourth', 'Wednesday')).toEqual(  
####           |                                                    ^  
####       310 |       new Date(2013, 6, 24),  
####       311 |     );  
####       312 |   });  
####   
####       at Object.toEqual (meetup.spec.js:309:52)  
####   
####   ● Meetup › fourth Wednesday of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-28T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       313 |  
####       314 |   test('fourth Wednesday of August 2013', () => {  
####     > 315 |     expect(meetup(2013, 8, 'fourth', 'Wednesday')).toEqual(  
####           |                                                    ^  
####       316 |       new Date(2013, 7, 28),  
####       317 |     );  
####       318 |   });  
####   
####       at Object.toEqual (meetup.spec.js:315:52)  
####   
####   ● Meetup › fourth Thursday of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-26T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       319 |  
####       320 |   test('fourth Thursday of September 2013', () => {  
####     > 321 |     expect(meetup(2013, 9, 'fourth', 'Thursday')).toEqual(  
####           |                                                   ^  
####       322 |       new Date(2013, 8, 26),  
####       323 |     );  
####       324 |   });  
####   
####       at Object.toEqual (meetup.spec.js:321:51)  
####   
####   ● Meetup › fourth Thursday of October 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-10-24T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       325 |  
####       326 |   test('fourth Thursday of October 2013', () => {  
####     > 327 |     expect(meetup(2013, 10, 'fourth', 'Thursday')).toEqual(  
####           |                                                    ^  
####       328 |       new Date(2013, 9, 24),  
####       329 |     );  
####       330 |   });  
####   
####       at Object.toEqual (meetup.spec.js:327:52)  
####   
####   ● Meetup › fourth Friday of November 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-11-22T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       331 |  
####       332 |   test('fourth Friday of November 2013', () => {  
####     > 333 |     expect(meetup(2013, 11, 'fourth', 'Friday')).toEqual(  
####           |                                                  ^  
####       334 |       new Date(2013, 10, 22),  
####       335 |     );  
####       336 |   });  
####   
####       at Object.toEqual (meetup.spec.js:333:50)  
####   
####   ● Meetup › fourth Friday of December 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-12-27T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       337 |  
####       338 |   test('fourth Friday of December 2013', () => {  
####     > 339 |     expect(meetup(2013, 12, 'fourth', 'Friday')).toEqual(  
####           |                                                  ^  
####       340 |       new Date(2013, 11, 27),  
####       341 |     );  
####       342 |   });  
####   
####       at Object.toEqual (meetup.spec.js:339:50)  
####   
####   ● Meetup › fourth Saturday of January 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-01-26T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       343 |  
####       344 |   test('fourth Saturday of January 2013', () => {  
####     > 345 |     expect(meetup(2013, 1, 'fourth', 'Saturday')).toEqual(  
####           |                                                   ^  
####       346 |       new Date(2013, 0, 26),  
####       347 |     );  
####       348 |   });  
####   
####       at Object.toEqual (meetup.spec.js:345:51)  
####   
####   ● Meetup › fourth Saturday of February 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-02-23T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       349 |  
####       350 |   test('fourth Saturday of February 2013', () => {  
####     > 351 |     expect(meetup(2013, 2, 'fourth', 'Saturday')).toEqual(  
####           |                                                   ^  
####       352 |       new Date(2013, 1, 23),  
####       353 |     );  
####       354 |   });  
####   
####       at Object.toEqual (meetup.spec.js:351:51)  
####   
####   ● Meetup › fourth Sunday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-24T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       355 |  
####       356 |   test('fourth Sunday of March 2013', () => {  
####     > 357 |     expect(meetup(2013, 3, 'fourth', 'Sunday')).toEqual(new Date(2013, 2, 24));  
####           |                                                 ^  
####       358 |   });  
####       359 |  
####       360 |   test('fourth Sunday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:357:49)  
####   
####   ● Meetup › fourth Sunday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-28T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       359 |  
####       360 |   test('fourth Sunday of April 2013', () => {  
####     > 361 |     expect(meetup(2013, 4, 'fourth', 'Sunday')).toEqual(new Date(2013, 3, 28));  
####           |                                                 ^  
####       362 |   });  
####       363 |  
####       364 |   test('last Monday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:361:49)  
####   
####   ● Meetup › last Monday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-25T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       363 |  
####       364 |   test('last Monday of March 2013', () => {  
####     > 365 |     expect(meetup(2013, 3, 'last', 'Monday')).toEqual(new Date(2013, 2, 25));  
####           |                                               ^  
####       366 |   });  
####       367 |  
####       368 |   test('last Monday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:365:47)  
####   
####   ● Meetup › last Monday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-29T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       367 |  
####       368 |   test('last Monday of April 2013', () => {  
####     > 369 |     expect(meetup(2013, 4, 'last', 'Monday')).toEqual(new Date(2013, 3, 29));  
####           |                                               ^  
####       370 |   });  
####       371 |  
####       372 |   test('last Tuesday of May 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:369:47)  
####   
####   ● Meetup › last Tuesday of May 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-05-28T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       371 |  
####       372 |   test('last Tuesday of May 2013', () => {  
####     > 373 |     expect(meetup(2013, 5, 'last', 'Tuesday')).toEqual(new Date(2013, 4, 28));  
####           |                                                ^  
####       374 |   });  
####       375 |  
####       376 |   test('last Tuesday of June 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:373:48)  
####   
####   ● Meetup › last Tuesday of June 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-06-25T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       375 |  
####       376 |   test('last Tuesday of June 2013', () => {  
####     > 377 |     expect(meetup(2013, 6, 'last', 'Tuesday')).toEqual(new Date(2013, 5, 25));  
####           |                                                ^  
####       378 |   });  
####       379 |  
####       380 |   test('last Wednesday of July 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:377:48)  
####   
####   ● Meetup › last Wednesday of July 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-07-31T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       379 |  
####       380 |   test('last Wednesday of July 2013', () => {  
####     > 381 |     expect(meetup(2013, 7, 'last', 'Wednesday')).toEqual(new Date(2013, 6, 31));  
####           |                                                  ^  
####       382 |   });  
####       383 |  
####       384 |   test('last Wednesday of August 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:381:50)  
####   
####   ● Meetup › last Wednesday of August 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-08-28T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       383 |  
####       384 |   test('last Wednesday of August 2013', () => {  
####     > 385 |     expect(meetup(2013, 8, 'last', 'Wednesday')).toEqual(new Date(2013, 7, 28));  
####           |                                                  ^  
####       386 |   });  
####       387 |  
####       388 |   test('last Thursday of September 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:385:50)  
####   
####   ● Meetup › last Thursday of September 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-09-26T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       387 |  
####       388 |   test('last Thursday of September 2013', () => {  
####     > 389 |     expect(meetup(2013, 9, 'last', 'Thursday')).toEqual(new Date(2013, 8, 26));  
####           |                                                 ^  
####       390 |   });  
####       391 |  
####       392 |   test('last Thursday of October 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:389:49)  
####   
####   ● Meetup › last Thursday of October 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-10-31T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       391 |  
####       392 |   test('last Thursday of October 2013', () => {  
####     > 393 |     expect(meetup(2013, 10, 'last', 'Thursday')).toEqual(new Date(2013, 9, 31));  
####           |                                                  ^  
####       394 |   });  
####       395 |  
####       396 |   test('last Friday of November 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:393:50)  
####   
####   ● Meetup › last Friday of November 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-11-29T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       395 |  
####       396 |   test('last Friday of November 2013', () => {  
####     > 397 |     expect(meetup(2013, 11, 'last', 'Friday')).toEqual(new Date(2013, 10, 29));  
####           |                                                ^  
####       398 |   });  
####       399 |  
####       400 |   test('last Friday of December 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:397:48)  
####   
####   ● Meetup › last Friday of December 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-12-27T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       399 |  
####       400 |   test('last Friday of December 2013', () => {  
####     > 401 |     expect(meetup(2013, 12, 'last', 'Friday')).toEqual(new Date(2013, 11, 27));  
####           |                                                ^  
####       402 |   });  
####       403 |  
####       404 |   test('last Saturday of January 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:401:48)  
####   
####   ● Meetup › last Saturday of January 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-01-26T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       403 |  
####       404 |   test('last Saturday of January 2013', () => {  
####     > 405 |     expect(meetup(2013, 1, 'last', 'Saturday')).toEqual(new Date(2013, 0, 26));  
####           |                                                 ^  
####       406 |   });  
####       407 |  
####       408 |   test('last Saturday of February 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:405:49)  
####   
####   ● Meetup › last Saturday of February 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-02-23T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       407 |  
####       408 |   test('last Saturday of February 2013', () => {  
####     > 409 |     expect(meetup(2013, 2, 'last', 'Saturday')).toEqual(new Date(2013, 1, 23));  
####           |                                                 ^  
####       410 |   });  
####       411 |  
####       412 |   test('last Sunday of March 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:409:49)  
####   
####   ● Meetup › last Sunday of March 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-03-31T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       411 |  
####       412 |   test('last Sunday of March 2013', () => {  
####     > 413 |     expect(meetup(2013, 3, 'last', 'Sunday')).toEqual(new Date(2013, 2, 31));  
####           |                                               ^  
####       414 |   });  
####       415 |  
####       416 |   test('last Sunday of April 2013', () => {  
####   
####       at Object.toEqual (meetup.spec.js:413:47)  
####   
####   ● Meetup › last Sunday of April 2013  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2013-04-28T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       415 |  
####       416 |   test('last Sunday of April 2013', () => {  
####     > 417 |     expect(meetup(2013, 4, 'last', 'Sunday')).toEqual(new Date(2013, 3, 28));  
####           |                                               ^  
####       418 |   });  
####       419 |  
####       420 |   test('last Wednesday of February 2012', () => {  
####   
####       at Object.toEqual (meetup.spec.js:417:47)  
####   
####   ● Meetup › last Wednesday of February 2012  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2012-02-29T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       419 |  
####       420 |   test('last Wednesday of February 2012', () => {  
####     > 421 |     expect(meetup(2012, 2, 'last', 'Wednesday')).toEqual(new Date(2012, 1, 29));  
####           |                                                  ^  
####       422 |   });  
####       423 |  
####       424 |   test('last Wednesday of December 2014', () => {  
####   
####       at Object.toEqual (meetup.spec.js:421:50)  
####   
####   ● Meetup › last Wednesday of December 2014  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2014-12-31T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       423 |  
####       424 |   test('last Wednesday of December 2014', () => {  
####     > 425 |     expect(meetup(2014, 12, 'last', 'Wednesday')).toEqual(  
####           |                                                   ^  
####       426 |       new Date(2014, 11, 31),  
####       427 |     );  
####       428 |   });  
####   
####       at Object.toEqual (meetup.spec.js:425:51)  
####   
####   ● Meetup › last Sunday of February 2015  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2015-02-22T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       429 |  
####       430 |   test('last Sunday of February 2015', () => {  
####     > 431 |     expect(meetup(2015, 2, 'last', 'Sunday')).toEqual(new Date(2015, 1, 22));  
####           |                                               ^  
####       432 |   });  
####       433 |  
####       434 |   test('first Friday of December 2012', () => {  
####   
####       at Object.toEqual (meetup.spec.js:431:47)  
####   
####   ● Meetup › first Friday of December 2012  
####   
####     expect(received).toEqual(expected) // deep equality  
####   
####     Expected: 2012-12-07T00:00:00.000Z  
####     Received: Date { NaN }  
####   
####       433 |  
####       434 |   test('first Friday of December 2012', () => {  
####     > 435 |     expect(meetup(2012, 12, 'first', 'Friday')).toEqual(new Date(2012, 11, 7));  
####           |                                                 ^  
####       436 |   });  
####       437 | });  
####       438 |  
####   
####       at Object.toEqual (meetup.spec.js:435:49)  
####   
#### Test Suites: 1 failed, 1 total  
#### Tests:       95 failed, 95 total  
#### Snapshots:   0 total  
#### Time:        1.009 s  
#### Ran all test suites matching ./LICENSE|./babel.config.js|./meetup.js|./meetup.spec.js|./node_modules|./package-lock.json|./package.json.  
#### ####  
####   
#### See the testing errors above.  
#### The tests are correct, don't try and change them.  
#### Fix the code in meetup.js to resolve the errors.  

The test calls `meetup(year, month, week, weekday)` — the `week` and `weekday` parameters are in the opposite order from what my implementation expects. That's why `DAY_TO_INDEX['teenth']` is `undefined`, producing an invalid date. Let me fix the parameter order.

meetup.js
```javascript
<<<<<<< SEARCH
export const meetup = (year, month, weekday, week) => {
  const targetDay = DAY_TO_INDEX[weekday];
=======
export const meetup = (year, month, week, weekday) => {
  const targetDay = DAY_TO_INDEX[weekday];
>>>>>>> REPLACE
```

> Tokens: 24k sent, 323 received.  
> Applied edit to meetup.js  
```

> test
> jest ./*

PASS ./meetup.spec.js
  Meetup
    ✓ monteenth of May 2013 (4 ms)
    ✓ monteenth of August 2013 (1 ms)
    ✓ monteenth of September 2013 (1 ms)
    ✓ tuesteenth of March 2013
    ✓ tuesteenth of April 2013
    ✓ tuesteenth of August 2013 (1 ms)
    ✓ wednesteenth of January 2013
    ✓ wednesteenth of February 2013 (1 ms)
    ✓ wednesteenth of June 2013 (2 ms)
    ✓ thursteenth of May 2013 (2 ms)
    ✓ thursteenth of June 2013 (2 ms)
    ✓ thursteenth of September 2013 (1 ms)
    ✓ friteenth of April 2013 (1 ms)
    ✓ friteenth of August 2013 (1 ms)
    ✓ friteenth of September 2013
    ✓ saturteenth of February 2013
    ✓ saturteenth of April 2013
    ✓ saturteenth of October 2013
    ✓ sunteenth of May 2013
    ✓ sunteenth of June 2013
    ✓ sunteenth of October 2013 (1 ms)
    ✓ first Monday of March 2013
    ✓ first Monday of April 2013
    ✓ first Tuesday of May 2013
    ✓ first Tuesday of June 2013
    ✓ first Wednesday of July 2013
    ✓ first Wednesday of August 2013
    ✓ first Thursday of September 2013
    ✓ first Thursday of October 2013 (1 ms)
    ✓ first Friday of November 2013
    ✓ first Friday of December 2013
    ✓ first Saturday of January 2013
    ✓ first Saturday of February 2013
    ✓ first Sunday of March 2013
    ✓ first Sunday of April 2013 (1 ms)
    ✓ second Monday of March 2013
    ✓ second Monday of April 2013
    ✓ second Tuesday of May 2013
    ✓ second Tuesday of June 2013
    ✓ second Wednesday of July 2013
    ✓ second Wednesday of August 2013
    ✓ second Thursday of September 2013 (1 ms)
    ✓ second Thursday of October 2013
    ✓ second Friday of November 2013
    ✓ second Friday of December 2013 (1 ms)
    ✓ second Saturday of January 2013
    ✓ second Saturday of February 2013
    ✓ second Sunday of March 2013
    ✓ second Sunday of April 2013
    ✓ third Monday of March 2013
    ✓ third Monday of April 2013
    ✓ third Tuesday of May 2013
    ✓ third Tuesday of June 2013
    ✓ third Wednesday of July 2013
    ✓ third Wednesday of August 2013
    ✓ third Thursday of September 2013
    ✓ third Thursday of October 2013 (4 ms)
    ✓ third Friday of November 2013
    ✓ third Friday of December 2013 (1 ms)
    ✓ third Saturday of January 2013
    ✓ third Saturday of February 2013
    ✓ third Sunday of March 2013
    ✓ third Sunday of April 2013 (1 ms)
    ✓ fourth Monday of March 2013
    ✓ fourth Monday of April 2013 (1 ms)
    ✓ fourth Tuesday of May 2013 (1 ms)
    ✓ fourth Tuesday of June 2013 (1 ms)
    ✓ fourth Wednesday of July 2013 (1 ms)
    ✓ fourth Wednesday of August 2013
    ✓ fourth Thursday of September 2013 (1 ms)
    ✓ fourth Thursday of October 2013
    ✓ fourth Friday of November 2013
    ✓ fourth Friday of December 2013
    ✓ fourth Saturday of January 2013
    ✓ fourth Saturday of February 2013
    ✓ fourth Sunday of March 2013
    ✓ fourth Sunday of April 2013 (1 ms)
    ✓ last Monday of March 2013
    ✓ last Monday of April 2013
    ✓ last Tuesday of May 2013
    ✓ last Tuesday of June 2013
    ✓ last Wednesday of July 2013
    ✓ last Wednesday of August 2013
    ✓ last Thursday of September 2013
    ✓ last Thursday of October 2013
    ✓ last Friday of November 2013
    ✓ last Friday of December 2013
    ✓ last Saturday of January 2013
    ✓ last Saturday of February 2013
    ✓ last Sunday of March 2013
    ✓ last Sunday of April 2013 (1 ms)
    ✓ last Wednesday of February 2012
    ✓ last Wednesday of December 2014
    ✓ last Sunday of February 2015 (1 ms)
    ✓ first Friday of December 2012

Test Suites: 1 passed, 1 total
Tests:       95 passed, 95 total
Snapshots:   0 total
Time:        0.71 s, estimated 1 s
Ran all test suites matching ./LICENSE|./babel.config.js|./meetup.js|./meetup.spec.js|./node_modules|./package-lock.json|./package.json.

```