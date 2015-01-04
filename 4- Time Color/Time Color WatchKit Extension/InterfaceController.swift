//
//  InterfaceController.swift
//  Time Color WatchKit Extension
//
//  Created by Konstantin Koval on 19/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import WatchKit
import Foundation


class TimeColorController: WKInterfaceController {

  @IBOutlet weak var timeLabel: WKInterfaceLabel!
  @IBOutlet private weak var background: WKInterfaceGroup!

  @IBOutlet private weak var coloHash: WKInterfaceLabel!
  
  var timer: NSTimer?
  let timeNumberformatter = NSDateFormatter()
  let timeFormatter = NSDateFormatter()

  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    timeNumberformatter.dateFormat = "HHmmss"
    timeFormatter.dateFormat = "HH:mm:ss"
    // Configure interface objects here.
    NSLog("%@ awakeWithContext", self)
  }
  
  override func willActivate() {

    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "tick:", userInfo: nil, repeats: true)
    
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    NSLog("%@ will activate", self)
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    NSLog("%@ did deactivate", self)
    timer?.invalidate()
    super.didDeactivate()
  }
  
  func tick(timer: NSTimer) {
    let now = NSDate()
    let string = timeNumberformatter.stringFromDate(now)
    let timeString = timeFormatter.stringFromDate(now)

    coloHash.setText("#\(string)")
    timeLabel.setText(timeString)
  
    background.setBackgroundColor(string.UIColor)
  }

}
