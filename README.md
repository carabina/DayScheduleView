# Day Schedule View

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Introduction

DayScheduleView is a custom view for iOS applications. DayScheduleView will
present a single day in a scrollable 24-hour list, divided into 30 minute
periods. DayScheduleView integrates with [EventKit](https://developer.apple.com/documentation/eventkit)
and custom appointment or event management code and displays events within
the day at the time that they occur. DayScheduleView supports interaction
between the user and the appointments that are displayed in the schedule.

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
