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
  private let dispatchQueue = DispatchQueue(label: "timeViewQueue", qos: .utility)
  private let highlightLayer = CALayer()
  private let currentTimeLayer = CALayer()
  private let currentTimeLayerDelegate = CurrentTimeLayerDelegate()

  private var appointmentLayers = [AppointmentLayer]()
  private var timePeriods = Array(repeating: [AppointmentLayer](), count: 48)
  private var currentMinute = -1
  private var timer: Timer?

  var appointments: [DayScheduleViewAppointment]? {
    didSet {
      invalidate()
    }
  }

  var date = Date() {
    didSet {
      invalidate()
    }
  }

  var log: DayScheduleViewLogger = DayScheduleViewNullLogger() {
    didSet {
      timeLayerDelegate.log = log
      currentTimeLayerDelegate.log = log
      for appointmentLayer in appointmentLayers {
        appointmentLayer.log = log
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setupView()
  }

  deinit {
    timer?.invalidate()
  }

  var metrics: DayScheduleViewMetrics {
    get {
      return timeLayerDelegate.metrics
    }
    set {
      timeLayerDelegate.metrics = newValue
      currentTimeLayerDelegate.metrics = newValue
      setNeedsLayout()
    }
  }

  override func layoutSubviews() {
    timeLayer.frame = layer.bounds
    timeLayer.setNeedsDisplay()

    highlightLayer.frame = CGRect(
      x: metrics.hourSize.width,
      y: highlightLayer.frame.origin.y,
      width: bounds.width - metrics.hourSize.width,
      height: metrics.timePeriodHeight + 2.0
    )

    let currentTime = Calendar.current.dateComponents([.hour, .minute], from: Date())
    var y = metrics.marginHeight +
      (CGFloat(currentTime.hour!) * metrics.hourHeight)
    if currentTime.minute! > 0 && currentTime.minute! < 30 {
      y += ((CGFloat(currentTime.minute!) / 30.0) * metrics.timePeriodHeight) + 2.0
    } else if currentTime.minute! == 30 {
      y += metrics.timePeriodHeight + 3.0
    } else {
      y += ((CGFloat(currentTime.minute! - 30) / 30.0) * metrics.timePeriodHeight) + metrics.timePeriodHeight + 5.0
    }

    y -= (metrics.hourHeight / 2.0)
    currentTimeLayer.frame = CGRect(x: 0.0, y: y, width: bounds.width, height: metrics.hourHeight)
    currentTimeLayer.setNeedsDisplay()

    layoutAppointments()
  }

  func time(forPoint point: CGPoint) -> Float {
    let y = (point.y - metrics.marginHeight)
    let hour = (y / metrics.hourHeight).rounded(.down)
    let difference = y - (hour * metrics.hourHeight)
    return Float(hour + (difference < (metrics.hourHeight / 2) ? 0 : 0.5))
  }

  func hasAppointments(
    atPoint point: CGPoint,
    excludeAllDayAppointments: Bool = false
    ) -> Bool {
    let time = self.time(forPoint: point)
    let timePeriod = Int(time * 2.0)
    var appointments = timePeriods[timePeriod]
    if excludeAllDayAppointments {
      appointments = appointments.filter { !$0.appointment.isAllDay }
    }

    return !appointments.isEmpty
  }

  func appointment(atPoint point: CGPoint) -> DayScheduleViewAppointment? {
    for appointmentLayer in appointmentLayers {
      if !appointmentLayer.layer.frame.contains(point) {
        continue
      }

      return appointmentLayer.appointment
    }

    return nil
  }

  func highlightTimePeriod(atPoint point: CGPoint) {
    guard !highlightLayer.frame.contains(point) else {
      return
    }

    let time = self.time(forPoint: point)
    var y = (CGFloat(time.rounded(.down)) * metrics.hourHeight) +
      metrics.marginHeight
    if 0.0 != time.remainder(dividingBy: 1.0) {
      y += 4.0 + metrics.timePeriodHeight
    }

    let oldFrame = highlightLayer.frame
    highlightLayer.frame = CGRect(
      x: oldFrame.origin.x,
      y: y,
      width: oldFrame.width,
      height: oldFrame.height
    )
    if highlightLayer.isHidden {
      highlightLayer.isHidden = false
    }

    highlightLayer.setNeedsDisplay()
  }

  func hideHighlight() {
    highlightLayer.isHidden = true
  }

  private func setupView() {
    timeLayer.delegate = timeLayerDelegate
    timeLayer.frame = layer.bounds
    layer.addSublayer(timeLayer)

    highlightLayer.isHidden = true
    highlightLayer.backgroundColor = UIColor.yellow.cgColor
    highlightLayer.opacity = 0.25
    layer.addSublayer(highlightLayer)

    currentTimeLayer.delegate = currentTimeLayerDelegate
    layer.addSublayer(currentTimeLayer)
    currentTimeLayer.setNeedsDisplay()

    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
      self.updateCurrentTime()
    })
  }

  private func removeAppointments() {
    for appointmentLayer in appointmentLayers {
      appointmentLayer.layer.removeFromSuperlayer()
    }

    appointmentLayers.removeAll()
  }

  private func loadAppointments() {
    guard let appointments = appointments else {
      return
    }

    highlightLayer.removeFromSuperlayer()
    currentTimeLayer.removeFromSuperlayer()

    self.appointmentLayers = appointments
      .sorted { (l, r) -> Bool in
        if l.startDate < r.startDate {
          return true
        }

        if l.startDate > r.startDate {
          return false
        }

        return l.endDate > r.endDate
      }
      .map { (appointment) -> AppointmentLayer in
        let appointmentLayer =
          AppointmentLayer(settings: self.metrics, appointment: appointment)
        appointmentLayer.log = self.log
        self.appointmentLayers.append(appointmentLayer)
        appointmentLayer.layer.frame = layer.bounds
        layer.addSublayer(appointmentLayer.layer)
        return appointmentLayer
    }

    layer.addSublayer(highlightLayer)
    layer.addSublayer(currentTimeLayer)
    setNeedsLayout()
  }

  private func layoutAppointments() {
    timePeriods = Array(repeating: [AppointmentLayer](), count: 48)

    let startOfDay = Calendar.current.startOfDay(for: date)
    let endDateComponents = DateComponents(day: 1, minute: -1)
    let endOfDay =
      Calendar.current.date(byAdding: endDateComponents, to: startOfDay)!
    let totalWidth = bounds.width - metrics.hourSize.width
    let endTimeComponents = DateComponents(minute: -1)

    for appointmentLayer in appointmentLayers {
      let startDate = appointmentLayer.appointment.startDate < startOfDay
        ? startOfDay
        : appointmentLayer.appointment.startDate
      let endDate = appointmentLayer.appointment.endDate > endOfDay
        ? endOfDay
        : appointmentLayer.appointment.endDate
      let startTime =
        Calendar.current.dateComponents([.hour, .minute], from: startDate)
      let endTime =
        Calendar.current.dateComponents([.hour, .minute], from: endDate)
      var y = metrics.marginHeight +
        (CGFloat(startTime.hour!) * metrics.hourHeight) +
        2.0
      if startTime.minute! == 30 {
        y += metrics.hourHeight / 2.0
      }

      let duration = CGFloat(DateInterval(start: startDate, end: endDate).duration / 60.0)
      var height = (duration / 60.0) * metrics.hourHeight
      if (endTime.minute! % 30) == 0 || endTime.minute! == 59 {
        height -= 3.0
      }

      appointmentLayer.layer.frame = CGRect(
        x: metrics.hourSize.width,
        y: y,
        width: totalWidth,
        height: height
      )

      let indexEndTime = Calendar.current.date(byAdding: endTimeComponents, to: endDate)!
      let indexEndTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: indexEndTime)
      let startIndex = (startTime.hour! * 2) + (startTime.minute! >= 30 ? 1 : 0)
      let endIndex = (indexEndTimeComponents.hour! * 2) + (indexEndTimeComponents.minute! >= 30 ? 1 : 0)
      for i in startIndex...endIndex {
        timePeriods[i].append(appointmentLayer)
      }
    }

    for timePeriod in timePeriods {
      var x: CGFloat = metrics.hourSize.width
      for appointmentLayer in timePeriod {
        let frame = appointmentLayer.layer.frame
        let width = min(frame.width, (totalWidth - (CGFloat(timePeriod.count - 1) * 2.0)) / CGFloat(timePeriod.count))
        appointmentLayer.layer.frame = CGRect(
          x: x,
          y: frame.origin.y,
          width: width,
          height: frame.height
        )
        x += width + 2.0
      }
    }

    for appointmentLayer in appointmentLayers {
      appointmentLayer.layer.setNeedsDisplay()
    }
  }

  private func updateCurrentTime() {
    let components = Calendar.current.dateComponents([.minute], from: Date())
    guard components.minute! != currentMinute else {
      return
    }

    currentMinute = components.minute!
    setNeedsLayout()
    currentTimeLayer.setNeedsDisplay()
  }

  private func invalidate() {
    removeAppointments()
    loadAppointments()
    setNeedsDisplay()
  }
}
