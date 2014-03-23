![Banner](https://raw.githubusercontent.com/MatthewYork/Resources/master/DateTools/DateToolsHeader.png)

## DateTools

DateTools was written to streamline date and time handling in Objective-C. Classes and concepts from other languages served as an inspiration for DateTools, especially the [DateTime](http://msdn.microsoft.com/en-us/library/system.datetime(v=vs.110).aspx) structure and [Time Period Library](Time Period Library) for .NET. Through these classes and others, DateTools removes the boilerplate required to access date components, handles more nuanced date comparisons, and serves as the foundation for entirely new concepts like Time Periods and their collections.


## Installation

**Cocoapods - Pending!**
<code>pod 'DateTools'</code>

**Manual Installation**
All the classes required for DateTools are located in the DateTools folder in the root of this repository. They are listed below:

* <code>DateTools.h</code>
* <code>NSDate+DateTools.{h,m}</code>
* <code>DTConstants.h</code>
* <code>DTError.{h,m}</code>
* <code>DTTimePeriod.{h,m}</code>
* <code>DTTimePeriodGroup.{h,m}</code>
* <code>DTTimePeriodCollection.{h,m}</code>
* <code>DTTimePeriodChain.{h,m}</code>

<code>DateTools.h</code> contains the headers for all the other files. Import this if you want to link to the entire framework.

## Table of Contents

* [**NSDate+DateTools**](#nsdate-datetools)
  * [Time Ago](#time-ago)
  * [Date Components](#date-components)
  * [Date Editing](#date-editing)
  * [Date Comparison](#date-comparison)
  * [Formatted Date Strings](#formatted-date-strings)
* [**Time Periods**](#time-periods)
  * [Introduction](#initialization)
  * [Time Period Info](#time-period-info)
  * [Manipulation](#manipulation)
  * [Relationships](#relationships) 
* [**Time Period Groups**](#time-period-groups)
  * [Introduction](#introduction)
  * [Time Period Collections](#time-period-collections)
  * [Time Period Chains](#time-period-chains)
* [**Unit Tests**](#unit-tests)
* [**Credits**](#credits)
* [**License**](#license)

##NSDate+DateTools

One of the missions of DateTools was to make NSDate feel more complete. There are many other languages that allow direct access to information about dates from their date classes, but NSDate (sadly) does not. It safely works only in the Unix time offsets through the <code>timeIntervalSince...</code> methods for building dates. But that's not <i>always</i> what we want to do. Sometimes, we would like to work with dates based on their date components (like year, month, day, etc) at a more abstract level. This is where DateTools comes in.

####Time Ago

No date library would be complete without the ability to quickly make an NSString based on how much earlier a date is than now. DateTools has you covered. These "time ago" strings come in a long a short form, with the latter closely resembling Twitter. There are many libraries that do this, so I wanted to pull it into this one.

```objc
NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:-4];
NSLog(@"Time Ago: %@", timeAgoDate.timeAgoSinceNow);
NSLog(@"Time Ago: %@", timeAgoDate.shortTimeAgoSinceNow);

//Output:
//Time Ago: 4 seconds ago
//Time Ago: 4s
```

####Date Components

There is a lot of boilerplate associated with getting date components from an NSDate. You have to set up a calendar, use the desired flags for the components you want, and finally extract them out of the calendar. 

With DateTools, this:

```objc
//Create calendar
NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];

//Get components
NSInteger year = calendar.year;
NSInteger month = calendar.month;
```

...becomes this:
```objc
NSInteger year = date.year;
NSInteger month = date.month;
```

And if you would like to use a non-Gregorian calendar, that option is available as well.
```objc
NSInteger day = [date dayWithCalendar:calendar];
```

If you would like to override the default calendar that DateTools uses, simply change it in the <code>defaultCalendar</code> method of <code>NSDate+DateTools.m</code>.

####Date Editing

The date editing makes it easy to make a date earlier or later by adding and subtracting date components. For instance, if you would like a date that is 1 year later from a given date, simply call the method <code>dateByAddingYears</code>.

With DateTools, this:
```objc
//Create calendar
NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSDate defaultCalendar]];
NSDateComponents *components = [[NSDateComponents alloc] init];

//Make changes
[components setYear:1];

//Get new date with updated year
NSDate *newDate = [calendar dateByAddingComponents:components toDate:date options:0];
```

...becomes this:
```objc
NSDate *newDate = [self.controlDate dateByAddingYears:1];
```

Subtraction of date components is also fully supported through the <code>dateBySubtractingYears</code>

####Date Comparison

One of the biggest reasons for the DateTools category on NSDate was to greatly increase the flexibility of date comparisons. NSDate gives you four basic methods:
* isEqualToDate:
* earlierDate:
* laterDate:
* compare:

<code>earlierDate:</code> and <code>laterDate:</code> are great, but it would be nice to have a boolean response to help when building logic in code. DateTools has a set of proxy methods that do just that as well as a few other methods for extended flexibility. The new methods are:
* isEarlierThan
* isEarlierThanOrEqualTo
* isLaterThan
* isLaterThanOrEqualTo

These methods are great for comparing dates in a boolean fashion, but what if we want to compare the dates and return some meaningful information about how far they are apart? NSDate comes with two methods <code>timeIntervalSinceDate:</code> and <code>timeIntervalSinceNow</code> which gives you a <code>double</code> offset representing the number of seconds between the two dates. This is great and all, but there are times when I want to know how many years or days something is away. For this, DateTools goes back to the ever-trusty NSCalendar and abstracts all the necessary code out for you.

With Date Tools, this:
```objc
NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSDate defaultCalendar]];
NSDate *earliest = [firstDate earlierDate:secondDate];
NSDate *latest = (secondDate == firstDate) ? secondDate : firstDate;
NSInteger multiplier = (secondDate == firstDate) ? -1 : 1;
NSDateComponents *components = [calendar components:allCalendarUnitFlags fromDate:earliest toDate:latest options:0];
NSInteger yearsApart = multiplier*(components.month + 12*components.year);
```
..becomes this:
```objc
NSInteger yearsApart = [firstDate yearsFrom:secondDate];
```
Methods for comparison in this category include:
* <code>yearsFrom:</code>, <code>yearsUntil</code>, <code>yearsAgo</code>, <code>yearsEarlierThan:</code>, <code>yearsLaterThan:</code>
* <code>monthsFrom:</code>, <code>monthsUntil</code>, <code>monthsAgo</code>, <code>monthsEarlierThan:,</code> <code>monthsLaterThan:</code>
* <code>weeksFrom:</code>, <code>weeksUntil</code>, <code>weeksAgo</code>, <code>weeksEarlierThan:</code>, <code>weeksLaterThan:</code>
* <code>daysFrom:</code>, <code>daysUntil</code>, <code>daysAgo</code>, <code>daysEarlierThan:</code>, <code>daysLaterThan:</code>
* <code>hoursFrom:</code>, <code>hoursUntil</code>, <code>hoursAgo</code>, <code>hoursEarlierThan:</code>, <code>hoursLaterThan:</code>
* <code>minutesFrom:</code>, <code>minutesUntil</code>, <code>minutesAgo</code>, <code>minutesEarlierThan:, <code>minutesLaterThan:</code>
* <code>secondsFrom:</code>, <code>secondsUntil</code>, <code>secondsAgo,</code> <code>secondsEarlierThan:, <code>secondsLaterThan:</code>

####Formatted Date Strings

Just for kicks, DateTools has a few convenience methods for quickly creating strings from dates. Those two methods <code>formattedDateWithStyle:</code> and <code>formattedDateWithFormat:</code>. The current locale is used unless otherwise specified by additional method parameters. Again, just for kicks, really.

##Time Periods

####Introduction

####Time Period Info

####Manipulation

####Relationships

##Time Period Groups

####Introduction

####Time Period Collections

####Time Period Chains

##Unit Tests
Unit tests were performed on all the major classes in the library for quality assurance. You can find theses under the "Tests" folder at the top of the library. There are over 300 test cases in all!

If you ever find a test case that is incomplete, please open an issue so we can get it fixed.

##Credits

Many thanks to the .NET team for their DateTime class and a major thank you to [Jani Giannoudis](http://www.codeproject.com/Members/Jani-Giannoudis) for his work on ITimePeriod.

##License

The MIT License (MIT)

Copyright (c) 2014 Matthew York

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
