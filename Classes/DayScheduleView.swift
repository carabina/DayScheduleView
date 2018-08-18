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

  public override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setupView()
  }

  open override func prepareForInterfaceBuilder() {
    setupView()

    super.prepareForInterfaceBuilder()
  }

  override open func layoutSubviews() {
    super.layoutSubviews()

    scrollView.contentInset = safeAreaInsets
  }

  private func setupView() {
    setupScrollView()
    setupTimeView()
  }

  private func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.contentSize = CGSize(width: bounds.width, height: 2085.0)
    scrollView.contentInsetAdjustmentBehavior = .never
    addSubview(scrollView)
    scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
  }

  private func setupTimeView() {
    timeView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(timeView)
    timeView.heightAnchor.constraint(equalToConstant: 2085.0).isActive = true
    timeView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
  }
}
