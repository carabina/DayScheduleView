// Copyright 2018 Naked Software, LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

/// Delegate that is invoked by `DayScheduleView` to perform actions, typically
/// as the result of user interaction with the appointments or the schedule.
///
/// - since: 1.0
public protocol DayScheduleViewDelegate: AnyObject {
  /// Notifies the delegate that an appointment was tapped in the day schedule
  /// view.
  ///
  /// - Parameters:
  ///   - dayScheduleView: The `DayScheduleView` view that the appointment was
  ///     tapped in.
  ///   - appointment: The appointment that was tapped.
  func dayScheduleView(
    _ dayScheduleView: DayScheduleView,
    appointmentTapped appointment: DayScheduleViewAppointment
  )
}

extension DayScheduleViewDelegate {
  public func dayScheduleView(
    _ dayScheduleView: DayScheduleView,
    appointmentTapped appointment: DayScheduleViewAppointment
    ) {
  }
}
