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

####Time Ago

####DAte Components

####Date Editing

####Date Comparison

####Formatted Date Strings

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
