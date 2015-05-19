//
//  InterfaceController.swift
//  WatchKit-table WatchKit Extension
//
//  Created by Konstantin Koval on 11/03/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import WatchKit
import Foundation


struct RowData {
  let name: String
  let imageName: String
}

class TableController: WKInterfaceController {

  @IBOutlet weak var table: WKInterfaceTable!
  let objects: [RowData] = [
    RowData(name: "Apple", imageName: "apple58"),
    RowData(name: "Grapes", imageName: "fruit17"),
    RowData(name: "WaterMelon", imageName: "fruit30"),
    RowData(name: "Apple", imageName: "apple58"),
    RowData(name: "Grapes", imageName: "fruit17"),
    RowData(name: "WaterMelon", imageName: "fruit30")]

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()

    let rows = Array(count: objects.count, repeatedValue: "Row")
    table.setRowTypes(rows)

    for i in 0 ..< objects.count {
      let object = objects[i];
      if let row = table.rowControllerAtIndex(i) as? TableRow {
        row.label.setText(object.name)
        row.image.setImageNamed(object.imageName)
      }
    }
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

}
