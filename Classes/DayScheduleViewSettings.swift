// Copyright 2018 Naked Software, LLC
//
// This program is confidential and proprietary to Naked Software, LLC, and
// may not be reproduced, published, or disclosed to others without company
// authorization.

struct DayScheduleViewSettings {
  let hourAttributes: [NSAttributedStringKey: Any]
  let titleAttributes: [NSAttributedStringKey: Any]
  let locationAttributes: [NSAttributedStringKey: Any]
  let contentSize: CGSize
  let hourSize: CGSize
  let marginHeight: CGFloat
  let timePeriodHeight: CGFloat
  let hourHeight: CGFloat
  let hourFrame: CGRect
  let hourLineFrame: CGRect
  let halfHourLineFrame: CGRect
}
