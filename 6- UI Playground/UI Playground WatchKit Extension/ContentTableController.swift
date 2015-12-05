//
//  ContentTableController.swift
//  UI Playground
//
//  Created by Konstantin Koval on 17/01/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import WatchKit
import Foundation

class RowController: NSObject {
  
  @IBOutlet weak var titleLabel: WKInterfaceLabel!
}

class ContentTableController: WKInterfaceController {
  
  @IBOutlet weak var table: WKInterfaceTable!
  let objects = ["Vertical", "Horizontal", "Mixed",
    "Pos - Vertical", "Pos - Horizontal","Pos - Centering",
    "Size - Fit Content","Size - Relative","Size - Fixed", "Size - Fix One",
    "Order", "Long Scroll"]
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    table.setRowTypes(Array(count: objects.count, repeatedValue:"Row"))
    for (index, obj) in objects.enumerate() {
      let controller = table.rowControllerAtIndex(index) as! RowController
      controller.titleLabel.setText(obj)
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
    pushControllerWithName(objects[rowIndex], context: nil)
  }
  
}
