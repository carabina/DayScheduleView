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

import UIKit
import EventKit

import DayScheduleView

class ViewController: UIViewController {
  private var eventStore: EKEventStore!
  private var eventStoreDataSource: EKEventStoreDataSource?

  var dayScheduleView: DayScheduleView {
    return view as! DayScheduleView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    eventStore = EKEventStore()
    addEventStoreDataSource()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    NotificationCenter.default.addObserver(self, selector: #selector(eventStoreChanged(_:)), name: .EKEventStoreChanged, object: nil)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    NotificationCenter.default.removeObserver(self)
  }

  @objc private func eventStoreChanged(_ notification: Notification) {
    dayScheduleView.invalidate()
  }

  private func addEventStoreDataSource() {
    switch EKEventStore.authorizationStatus(for: .event) {
    case .authorized:
      doAddEventStoreDataSource()

    case .denied, .restricted:
      break

    case .notDetermined:
      requestCalendarAuthorization()
    }
  }

  private func requestCalendarAuthorization() {
    eventStore.requestAccess(to: .event) { granted, error in
      if let error = error {
        print("ERROR: \(error)")
        return
      }

      if granted {
        self.doAddEventStoreDataSource()
      }
    }
  }

  private func doAddEventStoreDataSource() {
    eventStoreDataSource = EKEventStoreDataSource(eventStore: eventStore)
    dayScheduleView.dataSource = eventStoreDataSource
  }
}

