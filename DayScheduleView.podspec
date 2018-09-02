# Copyright 2018 Naked Software, LLC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

Pod::Spec.new do |s|

  s.name         = "DayScheduleView"
  s.version      = "0.3.1"
  s.summary      = "Single day calendar or schedule view with EventKit and drag-and-drop support."
  s.description  = <<-DESC
  DayScheduleView is a custom control for iOS applications. DayScheduleView
  presents a single 24-hour day and allows the user to view EventKit or other
  events directly in the day. DayScheduleView supports drag-and-drop to allow
  the user to drop new events on the schedule and create new appointments.
                   DESC
  s.homepage     = "https://github.com/nakedsoftware/DayScheduleView"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author             = { "Naked Software, LLC" => "support@naked.software" }
  s.social_media_url   = "http://twitter.com/mfcollins3"
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/nakedsoftware/DayScheduleView.git", :tag => "#{s.version}" }
  s.source_files  = "Classes"
  s.swift_version = "4.1"
end
