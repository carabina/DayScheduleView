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

final class TimeView: UIView {
  private let timeLayer = CALayer()
  private let timeLayerDelegate = TimeLayerDelegate()
  private var timePeriods = Array(repeating: [AppointmentPanel](), count: 48)
  private let dispatchQueue = DispatchQueue(label: "timeViewQueue", qos: .utility)

  var appointments: [DayScheduleViewAppointment]? {
    didSet {
      removeAppointments()
      loadAppointments()
    }
  }

  var date = Date()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setupView()
  }

  var settings: DayScheduleViewSettings {
    get {
      return timeLayerDelegate.settings
    }
    set {
      timeLayerDelegate.settings = newValue
      setNeedsLayout()
    }
  }

  override func layoutSubviews() {
    timeLayer.frame = layer.bounds
    timeLayer.setNeedsDisplay()

    
  }

  private func setupView() {
    timeLayer.delegate = timeLayerDelegate
    timeLayer.frame = layer.bounds
    layer.addSublayer(timeLayer)
  }

  private func removeAppointments() {
    for timePeriod in timePeriods {
      if 0 == timePeriod.count {
        continue
      }

      for appointmentPanel in timePeriod {
        appointmentPanel.layer.removeFromSuperlayer()
      }
    }
  }

  private func loadAppointments() {
    guard let appointments = appointments else {
      return
    }

    dispatchQueue.async {
      var timePeriods = Array(repeating: [AppointmentPanel](), count: 48)

      let startOfDay = Calendar.current.startOfDay(for: self.date)
      let endOfDayComponents = DateComponents(day: 1, minute: -1)
      let endOfDay = Calendar.current.date(byAdding: endOfDayComponents, to: startOfDay)!
      let endTimeComponents = DateComponents(minute: -1)

      for appointment in appointments {
        var startDate = appointment.startDate!
        if startDate < startOfDay {
          startDate = startOfDay
        }

        var endDate = appointment.endDate!
        if endDate > endOfDay {
          endDate = endOfDay
        } else {
          endDate = Calendar.current.date(byAdding: endTimeComponents, to: endDate)!
        }

        let startDateComponents = Calendar.current.dateComponents([.hour, .minute], from: startDate)
        let endDateComponents = Calendar.current.dateComponents([.hour, .minute], from: endDate)
        let startIndex = (startDateComponents.hour! * 2) + (startDateComponents.minute! > 30 ? 1 : 0)
        let endIndex = (endDateComponents.hour! * 2) + (endDateComponents.minute! > 30 ? 1 : 0)
        for i in startIndex...endIndex {
          let appointmentPanel = AppointmentPanel(appointment: appointment)
          timePeriods[i].append(appointmentPanel)
        }
      }

      DispatchQueue.main.async {
        self.timePeriods = timePeriods
        self.setNeedsLayout()
      }
    }
  }
}
