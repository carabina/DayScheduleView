# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2018-09-02

### Fixed

* I fixed a bug in `DayScheduleView` when attempting to highlight a time
  period. The point of the time period to highlight was not being properly
  transformed to the underlying scrollable view.
* `DayScheduleView` was not properly invalidating and updating when the
  `invalidate` function was called.
* `DayScheduleView.hideHighlight` was not hiding the highlight layer.

## [0.3.0] - 2018-09-02

### Changed

* I changed the interface for `DayScheduleViewDelegate` to make the
  notification methods optional. It did not make sense to have them always
  required if a user is not interested in either tapping appointments or
  long presses.
  
## [0.2.0] - 2018-09-02

### Changed

* I added `@objc` attributes to the `DayScheduleViewDelegate` protocol. It
  is necessary to expose `DayScheduleViewDelegate` to Objective-C for another
  project that is adding RxSwift support to `DayScheduleView`.
* I added the `@objc` attribute to the `DayScheduleViewAppointment` protocol.
  This was necessary because `DayScheduleViewAppointment` is used as a
  parameter type for the notifications in the `DayScheduleViewDelegate`
  protocol.
* I converted `DayScheduleViewAppointmentEKEventAdapter` from a `struct` to a
  `class`. This was necessary because `DayScheduleViewAppointment` was exposed
  to Objective-C and Objective-C can't interop with Swift structs.

## [0.1.0] - 2018-09-01

Welcome to the first release of [DayScheduleView](https://github.com/nakedsoftware/DayScheduleView).
DayScheduleView is a custom view for iOS applications that presents a single
day as 30 minute time periods. DayScheduleView can integrate with EventKit or
custom appointment data sources to display scheduled appointments or events
throughout the day. DayScheduleView has support for tapping or long touches
of events, and provides support for implementing drag-and-drop operations with
visual feedback during a drop operation.

### Added

* Created the `DayScheduleView` class with the initial API.
* Created the `DayScheduleViewAppointment` protocol for exposing appointment
  or event information to `DayScheduleView`.
* Created the `DayScheduleViewDataSource` protocol for allowing
  `DayScheduleView` to query and retrieve appointments for a day from a data
  source.
* Created the `DayScheduleViewDelegate` protocol and added events to notify
  the delegate if an appointment is tapped or long pressed.
* Created the `EKEventStoreDataSource` class that adapts the
  `DayScheduleViewDataSource` protocol to an EventKit `EKEventStore` object.
* Created the `DayScheduleViewAggregateDataSource` class that loads
  appointments from multiple data sources for display in the
  `DayScheduleView` view.
* Add support for integrating `DayScheduleView` into an application using
  [Carthage](https://github.com/carthage/carthage). Support is provided for
  both dynamic and static iOS frameworks.
* Add support for integrating `DayScheduleView` into an application using
  CocoaPods.
