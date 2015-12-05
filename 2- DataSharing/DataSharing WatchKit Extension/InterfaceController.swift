//
//  InterfaceController.swift
//  DataSharing WatchKit Extension
//
//  Created by Konstantin Koval on 15/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  @IBOutlet weak var table: WKInterfaceTable!
  var viewModel = ItemsViewModel()
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    NSLog("%@ awakeWithContext", self)
    loadTableData()
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
  
  func loadTableData() {
    table.setNumberOfRows(viewModel.items.count, withRowType: "ItemCell")

    for (index, item) in viewModel.items.enumerate() {
      let controller = table.rowControllerAtIndex(index) as! ItemRowController
      controller.label.setText(item)
    }
  }
  
}
