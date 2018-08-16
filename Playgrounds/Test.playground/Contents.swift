//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

import DayScheduleView

let dayScheduleView = DayScheduleView(frame: CGRect(x: 0, y: 0, width: 384, height: 600))
dayScheduleView.scrollToCurrentTime()
PlaygroundPage.current.liveView = dayScheduleView
