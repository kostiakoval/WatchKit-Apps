//
//  FriendsPicker.swift
//  AppsCommunication
//
//  Created by Konstantin Koval on 14/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import WatchKit
import Foundation

class FriendsPicker: WKInterfaceController {

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    NSLog("%@ awakeWithContext", self)
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    NSLog("%@ will activate", self)
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    NSLog("%@ did deactivate", self)
    super.didDeactivate()
  }
  
  @IBAction func showBob() {
    openParent("Bob")
  }
  
  @IBAction func showSam() {
    openParent("Sam")
  }
  
  @IBAction func showKristin() {
    openParent("Kristin")    
  }
  
  func openParent(person: String) {
    var userInfo = ["personName" : person]
    WKInterfaceController.openParentApplication(userInfo, reply: { (data, error) in
      if let error = error {
        println(error)
      }
      if let data = data {
        println(data)
      }
    })
  }
}
