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

  /// Initializes the `DayScheduleView` instance to occupy the specified frame.
  ///
  /// - parameter frame: The frame rectangle to display the `DayScheduleView`
  ///   view
  public override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  /// Initializes the `DayScheduleView` instance from a persisted state such as
  /// a storyboard.
  ///
  /// - parameter aDecoder: The `NSCoder` object to use to read the
  ///   `DayScheduleView` information from.
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setupView()
  }

  /// The data source is used by `DayScheduleView` to provide appointments that
  /// will be displayed in the user's day.
  public weak var dataSource: DayScheduleViewDataSource?

  /// `DayScheduleView` invokes methods on the delegate in response to user
  /// actions. The delegate allows the parent to implement actions in response
  /// to the user tapping or pressing activities and interacting with the
  /// schedule.
  public weak var delegate: DayScheduleViewDelegate?

  /// Configures the view hierarchy for `DayScheduleView` so that the view
  /// renders properly when being used in Interface Builder to design a
  /// storyboard.
  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
  }

  /// Scrolls the `DayScheduleView` so that the current time is being shown in
  /// the visible area of the scroll view.
  public func scrollToCurrentTime() {
    let offset = timeView.currentTimeOffset()
    print("offset = \(offset)")
    let rect = CGRect(
      x: 0,
      y: offset - 10.0,
      width: frame.width,
      height: scrollView.bounds.height / 2.0)
    print("current time rect = \(rect)")
    scrollView.scrollRectToVisible(rect, animated: true)
  }

  private func setupView() {
    setupScrollView()
    setupTimeView()
  }

  private func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.contentSize =
      CGSize(width: bounds.width, height: timeView.intrinsicContentSize.height)
    scrollView.backgroundColor = DayScheduleViewStyleKit.backgroundColor
    addSubview(scrollView)
    scrollView.topAnchor
      .constraint(equalTo: safeAreaLayoutGuide.topAnchor)
      .isActive = true
    scrollView.bottomAnchor
      .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
      .isActive = true
    scrollView.leadingAnchor
      .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
      .isActive = true
    scrollView.trailingAnchor
      .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
      .isActive = true
  }

  private func setupTimeView() {
    timeView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(timeView)
    timeView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    timeView.heightAnchor.constraint(equalToConstant: timeView.intrinsicContentSize.height)
  }
}
