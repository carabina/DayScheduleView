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

final class TimeLayerDelegate: NSObject {
  let hourAttributes: [NSAttributedStringKey: Any]
  let hourSize: CGSize
  let heightOffset: CGFloat
  
  override init() {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .right
    hourAttributes = [
      .font: UIFont.preferredFont(forTextStyle: .caption1),
      .paragraphStyle: paragraphStyle
    ]

    let time = NSString(string: "12:00 AM")
    let size = time.size(withAttributes: hourAttributes)
    let hourWidth = size.width.rounded(.up) + 16.0
    heightOffset = size.height / 2.0
    hourSize = CGSize(width: hourWidth, height: size.height)
  }
}

extension TimeLayerDelegate: CALayerDelegate {
  func draw(_ layer: CALayer, in ctx: CGContext) {
    UIGraphicsPushContext(ctx)

    let hourFrame = CGRect(x: 0.0, y: 10.0 - heightOffset, width: hourSize.width - 8.0, height: hourSize.height)
    NSString(string: "12 AM").draw(in: hourFrame, withAttributes: hourAttributes)

    UIColor.black.setFill()

    UIGraphicsPopContext()

    draw(hour: "12 AM", at: CGRect(x: 0.0, y: 10.0, width: layer.bounds.width, height: 86.0), in: ctx)
    draw(hour: "1 AM", at: CGRect(x: 0.0, y: 96.0, width: layer.bounds.width, height: 86.0), in: ctx)
    draw(hour: "2 AM", at: CGRect(x: 0.0, y: 182.0, width: layer.bounds.width, height: 86.0), in: ctx)
  }

  private func draw(hour: String, at frame: CGRect, in ctx: CGContext) {
    UIGraphicsPushContext(ctx)
    let hourFrame = CGRect(x: frame.origin.x, y: frame.origin.y - heightOffset, width: hourSize.width - 8.0, height: hourSize.height)
    NSString(string: hour).draw(in: hourFrame, withAttributes: hourAttributes)
    UIGraphicsPopContext()

    let hourLineFrame = CGRect(x: frame.origin.x + hourSize.width, y: frame.origin.y, width: frame.width - hourSize.width, height: 1.0)
    UIColor.black.setFill()
    ctx.fill(hourLineFrame)

    let halfHourLineFrame = CGRect(x: hourLineFrame.origin.x, y: hourLineFrame.origin.y + 42.0, width: hourLineFrame.width, height: 1.0)
    ctx.fill(halfHourLineFrame)
  }
}
