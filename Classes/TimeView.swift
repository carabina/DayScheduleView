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
  override var intrinsicContentSize: CGSize {
    return CGSize(width: UIViewNoIntrinsicMetric, height: 1989.0)
  }

  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()!

    DayScheduleViewStyleKit.drawTimeView(frame: frame)

    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    let time = dateFormatter.string(from: now)

    let dateComponents =
      Calendar.current.dateComponents([.hour, .minute], from: now)
    let y = offset(for: now)
    let currentTimeFrame = CGRect(x: 0, y: y, width: frame.width, height: 21.0)

    context.saveGState()
    if 10 > dateComponents.minute! {
      let whiteFrame = CGRect(x: 0, y: y - 20.0, width: 50.0, height: 41.0)
      DayScheduleViewStyleKit.backgroundColor.setFill()
      context.fill(whiteFrame)
    } else if 50 <= dateComponents.minute! {
      let whiteFrame = CGRect(x: 0, y: y, width: 50.0, height: 41.0)
      DayScheduleViewStyleKit.backgroundColor.setFill()
      context.fill(whiteFrame)
    }

    context.restoreGState()

    DayScheduleViewStyleKit.drawCurrentTime(frame: currentTimeFrame, now: time)
  }

  func currentTimeOffset() -> CGFloat {
    return offset(for: Date())
  }

  func offset(for time: Date) -> CGFloat {
    let dateComponents =
      Calendar.current.dateComponents([.hour, .minute], from: time)
    var y: CGFloat = CGFloat(dateComponents.hour!) * 82.0
    if (30 == dateComponents.minute!) {
      y += 41.0
    } else if 0 < dateComponents.minute! && 30 > dateComponents.minute! {
      y += (40.0 * (CGFloat(dateComponents.minute!) / 30.0))
    } else if 30 < dateComponents.minute! {
      y += 41.0 + (40.0 * (CGFloat(dateComponents.minute! - 30) / 30.0))
    }

    return y
  }
}
