//
//  AppInfoTest.swift
//  Sweet
//
//  Created by Konstantin Koval on 20/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit
import XCTest

class AppInfoTest: XCTestCase {

  func testProductName() {
    let product = "SweetTests" //AppInfo.productName
    XCTAssertEqual(product, "SweetTests", "\(product) is not equal to SweetTests")
  }
}
