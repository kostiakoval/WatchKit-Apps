//
//  SeruStackTest.swift
//  Seru
//
//  Created by Konstantin Koval on 25/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData
import XCTest

class SeruStackTest: XCTestCase {
  var stack: PersistenceLayer!
  
  override func setUp() {
    super.setUp()
    stack = PersistenceLayer(name: "Seru", modelLocation:.AllMainBundles)
  }
  
  override func tearDown() {
    stack = nil
    super.tearDown()
  }
  
//  MARK: -Default setup
  func testSetupTrack() {
    XCTAssertNotNil(stack)
    XCTAssertNotNil(stack.errorHandler)
    XCTAssertNotNil(stack.mainMOC)
    XCTAssertNotNil(stack.managedObjectModel)
    XCTAssertNotNil(stack.persistentStoreCoordinator)
  }
  
  func testDefaulModel() {
    let entities = stack.managedObjectModel.entities as! [NSEntityDescription]
    
    XCTAssertEqual(entities.count, 1)
    XCTAssertEqual(entities.first!.name!, "Entity")
  }
  
  func testMainContext() {
    let moc = stack.mainMOC
    
    XCTAssertNotNil(moc.persistentStoreCoordinator)
    XCTAssertEqual(moc.persistentStoreCoordinator!, stack.persistentStoreCoordinator)
    XCTAssertNil(moc.parentContext)
    XCTAssertEqual(moc.concurrencyType, NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
    XCTAssertNil(moc.undoManager)
    XCTAssertEqual(moc.name!, "main")
  }
  
  func testCoordinator() {
    
    let coordinator = stack.persistentStoreCoordinator
    XCTAssertNotNil(coordinator.managedObjectModel)
    XCTAssertNotNil(coordinator.persistentStores)
    
    let stores = coordinator.persistentStores as! [NSPersistentStore]
    XCTAssertEqual(stores.count, 1)
    
    let store: NSPersistentStore = stores.first!
    XCTAssertNotNil(store.options)
    XCTAssertTrue(store.URL!.absoluteString!.hasSuffix("Documents/Seru.sqlite"))
    XCTAssertTrue(store.URL!.absoluteString!.hasPrefix("file:///"))
    XCTAssertEqual(store.type, StoreType.SQLite.coreDataType)
    XCTAssertFalse(store.readOnly)
    XCTAssertEqual(store.persistentStoreCoordinator!, coordinator)
  }

//  MARK:- Store Types
  func testInMemoryStack() {
    
    var config = PersistanceConfigurator(name: "Seru", type: .InMemory, modelLocation: .AllMainBundles)
    stack = PersistenceLayer(configurator: config)
    checkStore(StoreType.InMemory, layer: stack)
  }
  
  func testBinaryStack() {
    
    var config = PersistanceConfigurator(name: "Seru", type: .Binary, modelLocation: .AllMainBundles)
    stack = PersistenceLayer(configurator: config)
    checkStore(StoreType.Binary, layer: stack)
  }
  
  private func checkStore(expectedType: StoreType, layer: PersistenceLayer) {
    let stores = layer.persistentStoreCoordinator.persistentStores as! [NSPersistentStore]
    XCTAssertEqual(stores.count, 1)
    let store: NSPersistentStore = stores.first!
    XCTAssertEqual(store.type, expectedType.coreDataType)
  }
  
// MARK:- Store Locations
  
//  func testSharedGroupStore() {
//    var config = PersistanceConfigurator(name: "Seru", location: StoreLocationType.SharedGroup("group.test.test"), modelProvider: model)
//    stack = PersistenceLayer(configurator: config)
//  }

  
}
