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

  private func setupView() {
    setupScrollView()
    setupTimeView()
  }

  private func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.contentSize = CGSize(width: bounds.width, height: 1920.0)
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
    timeView.heightAnchor.constraint(equalToConstant: 1920.0)
  }
}
