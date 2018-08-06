# Day Schedule View

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Introduction

This repository implements a day schedule view control for iOS applications.
The day schedule view allows the user to view a 24-hour day and all of the
appointments that have been scheduled on that day. The day schedule view
supports [EventKit](https://developer.apple.com/documentation/eventkit) for
displaying calendar events in the schedule.

## Installation

Day Schedule View is compatible with [Carthage](https://github.com/Carthage/Cartage)
or [CocoaPods](https://cocoapods.org).

### Carthage Installation

Day Schedule View is installable using [Carthage](https://github.com/Carthage/Carthage).
To use Day Schedule View in your own project, add the following line to your
`Cartfile`:

    github "nakedsoftware/DayScheduleView"

Next, run:

    carthage update

This will download the source code or binary release package for Day Schedule
View and make the framework available for your application.

Day Schedule View is available as either a dynamically-linked framework for
iOS applications, or as a statically linked framework. We recommend using the
statically-linked framework for performance reasons.

### CocoaPods Installation

To use Day Schedule View in your own project, add the following line to your
`Podfile` for the target that you want to link Day Schedule View into:

    pod 'DayScheduleView'

Then install the source code into your application or framework:

    pod install
