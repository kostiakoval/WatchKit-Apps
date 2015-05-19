//
//  StackTest.swift
//  Seru
//
//  Created by Konstantin Koval on 01/03/15.
//  Copyright (c) 2015 Konstantin Koval. All rights reserved.
//

import Foundation
import XCTest
import CoreData
import Seru
import Nimble

class BaseStackTest: XCTestCase {
  var stack: BaseStack!
  
  override func setUp() {
    super.setUp()
    stack = BaseStack(name: "Seru", bundle: NSBundle(forClass: BaseStackTest.self))
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
    func testStactCreateion() {
    // This is an example of a functional test case.
    expect(stack).toNot(beNil())
    expect(stack.model.entities.count).to(equal(1))
    expect(stack.mainMOC).toNot(beNil())
    expect(stack.coordinator).toNot(beNil())
  }
}
