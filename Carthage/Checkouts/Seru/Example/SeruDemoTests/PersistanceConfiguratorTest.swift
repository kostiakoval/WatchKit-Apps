//
//  PersistanceConfiguratorTest.swift
//  Seru
//
//  Created by Konstantin Koval on 26/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import XCTest
import CoreData
import Seru

class PersistanceConfiguratorTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testConfigurator() {

    let config = PersistanceConfigurator(name: "MyTestName")

    XCTAssertEqual(config.type, StoreType.SQLite)
    XCTAssertEqual(config.location, StoreLocationType.PrivateFolder)
  }
  
  func testDefaultModelProvider() {
    let config = PersistanceConfigurator(name: "MyTestName")
    XCTAssertNotNil(config.modelProvider())
  }
  
  func testModelProvider() {

    let modelProvider : ModelProviderType = {
      let bundle = NSBundle(forClass: PersistenceStack.self)
      return NSManagedObjectModel.mergedModelFromBundles([bundle])!
    }
    let config = PersistanceConfigurator(name: "MyTestName", modelLocation:.Custom(modelProvider))
    
    let model = config.modelProvider()
    XCTAssertNotNil(model)
    let entities = model.entities as! [NSEntityDescription]
    
    XCTAssertEqual(entities.count, 1)
    XCTAssertEqual(entities.first!.name!, "Entity")
  }  
}
