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

/// `DayScheduleView` presents a 24-hour period as a scrollable day view.
/// `DayScheduleView` will display appointments on the schedule and supports
/// drag-and-drop to drop new items on the view.
///
/// - since: 1.0
@IBDesignable
open class DayScheduleView: UIView {
  private let scrollView = UIScrollView()
  private let timeView = TimeView()
  private var timeViewHeight: NSLayoutConstraint!
  private let operationQueue = DispatchQueue(label: "myQueue", qos: .utility)

  /// The object that acts as the data source for appointments to be displayed
  /// in the view.
  public weak var dataSource: DayScheduleViewDataSource? {
    didSet {
      loadAppointments()
    }
  }

  /// The date that should be displayed in the schedule view.
  public var date: Date {
    get {
      return timeView.date
    }
    set {
      timeView.date = newValue
      loadAppointments()
    }
  }

  public weak var delegate: DayScheduleViewDelegate?

  /// Initializes and returns a day schedule view object having the given frame.
  ///
  /// - Parameter frame: A rectangle specifying the initial location and size
  ///   of the day schedule view in its superview's coordinates.
  public override init(frame: CGRect) {
    super.init(frame: frame)

    #if !TARGET_INTERFACE_BUILDER
      setupView()
    #endif
  }

  /// Initializes and returns a day schedule view from the coded data.
  ///
  /// - Parameter aDecoder: The `NSCoder` object to use to deserialize the
  ///   day schedule view settings.
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setupView()
  }

  /// Initializes the day schedule view in order for the schedule view to render
  /// properly in Interface Builder.
  open override func prepareForInterfaceBuilder() {
    setupView()

    super.prepareForInterfaceBuilder()
  }

  override open func layoutSubviews() {
    scrollView.contentInset = safeAreaInsets

    let newSettings = calculateSettings()
    scrollView.contentSize = newSettings.contentSize
    timeViewHeight.constant = newSettings.contentSize.height
    timeView.settings = newSettings

    super.layoutSubviews()
  }

  /// Reloads all of the appointments for the current day and updates the day
  /// schedule view.
  public func invalidate() {
    loadAppointments()
    setNeedsDisplay()
  }

  /// For the specified point, calculates the time period that the point belongs
  /// to.
  ///
  /// - Parameter point: The point within the coordinate system of the day
  ///   schedule view.
  /// - Returns: A decimal value indicating the approximate time that the point
  ///   belongs to. The integer part of the return value indicates the hour
  ///   and will be between `0` and `23` inclusive. The fractional part will be
  ///   `.0` if the point is within the first 30 minutes of the hour, and `.5`
  ///   if the point is within the second 30 minutes of the hour.
  public func time(forPoint point: CGPoint) -> Float {
    let scrollViewPoint = convert(point, to: scrollView)
    let timeViewPoint = scrollView.convert(scrollViewPoint, to: timeView)
    return timeView.time(forPoint: timeViewPoint)
  }

  public func hasAppointments(atPoint point: CGPoint) -> Bool {
    return timeView.hasAppointments(atPoint: point)
  }

  private func setupView() {
    setupScrollView()
    setupTimeView()
  }

  private func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(scrollView)
    scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
  }

  private func setupTimeView() {
    timeView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(timeView)
    timeViewHeight = timeView.heightAnchor.constraint(equalToConstant: 2085.0)
    timeViewHeight.isActive = true
    timeView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    timeView.addGestureRecognizer(tapGestureRecognizer)

    let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    timeView.addGestureRecognizer(longPressGestureRecognizer)
  }

  @objc private func handleTap(_ sender: UITapGestureRecognizer) {
    let point = sender.location(in: timeView)
    guard let appointment = timeView.appointment(atPoint: point) else {
      return
    }

    delegate?.dayScheduleView(self, appointmentTapped: appointment)
  }

  @objc private func handleLongPress(_ sender: UILongPressGestureRecognizer) {
    guard UIGestureRecognizerState.began == sender.state else {
      return
    }
    
    let point = sender.location(in: timeView)
    guard let appointment = timeView.appointment(atPoint: point) else {
      return
    }

    delegate?.dayScheduleView(self, appointmentLongPressed: appointment)
  }

  private func calculateSettings() -> DayScheduleViewSettings {
    let hourStyle = NSMutableParagraphStyle()
    hourStyle.alignment = .right
    let caption1Font = UIFont.preferredFont(forTextStyle: .caption1)
    let hourAttributes: [NSAttributedStringKey: Any] = [
      .font: caption1Font,
      .paragraphStyle: hourStyle,
      .foregroundColor: UIColor(displayP3Red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
    ]
    let hourSize = NSString(string: "10 AM").size(withAttributes: hourAttributes)
    let timeSize = CGSize(width: hourSize.width.rounded(.up) + 16.0, height: hourSize.height)
    let halfHourHeight = hourSize.height / 2.0
    let marginHeight = max(10.0, halfHourHeight).rounded(.up)

    let descriptor = caption1Font.fontDescriptor.withSymbolicTraits(.traitBold)!
    let titleFont = UIFont(descriptor: descriptor, size: 0.0)
    let locationFont = UIFont.preferredFont(forTextStyle: .caption2)
    let titleParagraphStyle = NSMutableParagraphStyle()
    titleParagraphStyle.lineBreakMode = .byTruncatingTail
    let titleAttributes: [NSAttributedStringKey: Any] = [
      .font: titleFont,
      .paragraphStyle: titleParagraphStyle
    ]
    let locationParagraphStyle = NSMutableParagraphStyle()
    locationParagraphStyle.lineBreakMode = .byTruncatingTail
    let locationAttributes: [NSAttributedStringKey: Any] = [
      .font: locationFont,
      .paragraphStyle: locationParagraphStyle
    ]
    let titleSize = NSString(string: "Sample title").size(withAttributes: titleAttributes)
    let locationSize = NSString(string: "Sample Location").size(withAttributes: locationAttributes)
    let timePeriodHeight = max(40.0, (titleSize.height + locationSize.height).rounded(.up) + 8)
    let scheduleHeight = (2 * marginHeight) + 25.0 + 24.0 + 96.0 + (48 * timePeriodHeight)
    let contentSize = CGSize(width: bounds.width, height: scheduleHeight)
    let hourHeight = (2 * timePeriodHeight) + 6.0

    let hourOriginY = marginHeight - halfHourHeight
    let hourFrame = CGRect(
      x: 8.0,
      y: hourOriginY,
      width: hourSize.width.rounded(.up),
      height: hourSize.height
    )
    let hourLineFrame = CGRect(
      x: timeSize.width,
      y: marginHeight,
      width: bounds.width - timeSize.width,
      height: 1.0
    )
    let halfHourLineFrame = hourLineFrame.offsetBy(dx: 0.0, dy: 3.0 + timePeriodHeight)

    return DayScheduleViewSettings(
      hourAttributes: hourAttributes,
      titleAttributes: titleAttributes,
      locationAttributes: locationAttributes,
      contentSize: contentSize,
      hourSize: timeSize,
      marginHeight: marginHeight,
      timePeriodHeight: timePeriodHeight,
      hourHeight: hourHeight,
      hourFrame: hourFrame,
      hourLineFrame: hourLineFrame,
      halfHourLineFrame: halfHourLineFrame
    )
  }

  private func loadAppointments() {
    guard let dataSource = dataSource else {
      return
    }

    operationQueue.async {
      let startDate = Calendar.current.startOfDay(for: self.date)
      let endDateComponents = DateComponents(day: 1)
      let endDate = Calendar.current.date(byAdding: endDateComponents, to: startDate)!
      let appointments = dataSource.dayScheduleView(self, appointmentsWithStart: startDate, end: endDate)
      DispatchQueue.main.async {
        self.timeView.appointments = appointments
      }
    }
  }
}
