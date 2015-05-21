//
//  InterfaceController.swift
//  Shared CoreData WatchKit Extension
//
//  Created by Konstantin Koval on 24/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import WatchKit
import Foundation
import SharedKit

class InterfaceController: WKInterfaceController {

  @IBOutlet weak var table: WKInterfaceTable!

  var objects: [Record]!
  lazy var stack = Seru(name: "Shared CoreData", location: .SharedGroup(SharedGroupName))

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
        NSLog("%@ awakeWithContext", self)
    }

    override func willActivate() {
      super.willActivate()
      objects = DataManager.loadAll(self.stack.stack.mainMOC)

      table.setNumberOfRows(objects.count, withRowType: "Row")
      for (index, record: Record) in enumerate(objects) {
        var rowController = table.rowControllerAtIndex(index) as! RowController
        let r: Record = record
        rowController.name.setText(record.timestamp.description)
      }
        // This method is called when watch view controller is about to be visible to user

        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
