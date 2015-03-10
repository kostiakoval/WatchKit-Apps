//
//  MainInterfaceController.swift
//  Pages
//
//  Created by Konstantin Koval on 10/03/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import Foundation
import WatchKit

class MainInterfaceController: WKInterfaceController {

  let objects: [Int]

  override init() {
    objects = [2, 10]
    super.init()
  }

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
  }

  override func willActivate() {
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

  @IBAction func showPages(){

    let names = objects.map { x in "page" }
    presentControllerWithNames(names, contexts: objects)
  }
}
