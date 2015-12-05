//
//  ButtonsInterfaceController.swift
//  UI Playground
//
//  Created by Konstantin Koval on 10/01/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import WatchKit
import Foundation


class ButtonsInterfaceController: WKInterfaceController {
  
  @IBOutlet weak var button1: WKInterfaceButton!
  @IBOutlet weak var button2: WKInterfaceButton!
  @IBOutlet weak var button3: WKInterfaceButton!
  
  @IBAction func action1() {
    print("Action 1")
  }
  @IBAction func action2() {
    print("Action 2")
  }
  @ IBAction func action3() {
    print("Action 3")
  }
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    button1.setTitle("Title 1")
    button2.setTitle("Title 2")
    button3.setTitle("Title 3")
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
}

