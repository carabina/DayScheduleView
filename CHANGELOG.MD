# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.6.0] - 2018-09-07

### Changed

* I changed the `DayScheduleView.date` property to be optional and it no
  longer defaults to *today*. It is required that the `date` property is set
  when initializing `DayScheduleView`.

### Fixed

* I fixed a layout error in `DayScheduleView` where the `date` property is
  set to an earlier date than the appointments that are currently in memory.
  The layout algorithm was failing due to a reverse interval error.
  
## [0.5.0] - 2018-09-05

### Changed

* The `hasAppointments(atPoint:)` function on `DayScheduleView` was changed
  to `hasAppointments(atPoint:excludeAllDayAppointments:)`. The additional
  boolean parameter will allow users to specify whether or not to consider
  all day appointments for conflicts. As an example of why you would want to
  set this to `true` is holidays. Holidays will appear as all day appointments
  and application users would not be able to schedule any Pomodoros on a
  holiday. By setting this to `true`, applications can allow users to schedule
  Pomodoros on a holiday.
  
## [0.4.1] - 2018-09-03

### Fixed

* The `DayScheduleViewLogger`, `DayScheduleViewNullLogger`, and
  `DayScheduleViewStandardOutputLogger` types were not included in the iOS
  static framework build target. This caused Carthage builds to fail. I 
  corrected this.

## [0.4.0] - 2018-09-03

### Added

* Created the `DayScheduleViewLogger` protocol. `DayScheduleViewLoggger` is
  used by `DayScheduleView` and other types to output diagnostic messages from
  `DayScehduleView` at runtime. These messages can be used to monitor how
  `DayScheduleView` works and to diagnose and fix runtime errors found in a
  consuming application.
* Created the `DayScheduleViewNullLogger` structure type.
  `DayScheduleViewNullLogger` is used as the default implementation of the
  `DayScheduleViewLogger` protocol and does not output any messages at runtime.
* Created the `DayScheduleViewStandardOutputLogger` structure type.
  `DayScheduleViewStandardOutputLogger` will output log messages to standard
  output at runtime, based on the configured logging level.
* I added the `log` property to `DayScheduleView`. The `log` property allows
  a user to set the `DayScheduleViewLogger` instance that `DayScheduleView`
  should use at runtime to output log messages.
* I added the `log` property to `EKEventStoreDataSource`. The `log` property
  allows a user to set the `DayScheduleViewLogger` instance that
  `EKEventStoreDataSource` should use at runtime to output log messages.
* I added the `log` property to `DayScheduleViewAggregateDataSource`. The
  `log` property allows a user to set the `DayScheduleViewLogger` instance
  that `DayScheduleViewAggregateDataSource` should use at runtime to output
  log messages.
  
## [0.3.2] - 2018-09-02

### Fixed

* I fixed a bug in `TimeView.hasAppointment(atPoint:)`. This method was not
  correctly calculating the time period and was returning the incorrect
  result as to whether other appointments existed in the time period
  represented by the point. I corrected the logic so that the correct result
  is being returned.

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
