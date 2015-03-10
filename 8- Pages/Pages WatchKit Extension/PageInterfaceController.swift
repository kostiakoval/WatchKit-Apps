//
//  InterfaceController.swift
//  Pages WatchKit Extension
//
//  Created by Konstantin Koval on 10/03/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import WatchKit
import Foundation


class PageInterfaceController: WKInterfaceController {

  var page: Int?
  @IBOutlet private weak var pageNumber: WKInterfaceLabel!

  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)

    if let number = context as? Int {
      self.page = number
      pageNumber.setText("\(number)")
    }
  }

  override func willActivate() {
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

}
