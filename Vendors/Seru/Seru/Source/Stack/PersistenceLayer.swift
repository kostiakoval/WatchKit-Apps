//
//  CoreDataStack.swift
//  MyMovies
//
//  Created by Konstantin Koval on 20/08/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData
import Sweet


public class PersistenceLayer {
  
  public var errorHandler: ErrorHandler
  
  public var mainMOC: NSManagedObjectContext
  var managedObjectModel: NSManagedObjectModel
  var persistentStoreCoordinator: NSPersistentStoreCoordinator
  
  public init(configurator: PersistanceConfigurator, factory: FactoryType = Factory()) {
    
    self.errorHandler = configurator.errorHandler
    
    managedObjectModel = configurator.modelProvider()
    persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    mainMOC = factory.mainMOC(persistentStoreCoordinator)
    configurator.setupStoreCoordinator(persistentStoreCoordinator)
  }
}

//MARK:- Initializers
public extension PersistenceLayer {
  
  public convenience init(type: StoreType = .SQLite, location: StoreLocationType = .PrivateFolder, modelLocation: ModelLocation = .MainBundle, errorHandler: ErrorHandler = ErrorHandler()) {
    self.init(configurator: PersistanceConfigurator(type: type, location: location, errorHandler: errorHandler, modelLocation: modelLocation))
  }
  
  public convenience init(name: String, type: StoreType = .SQLite, location: StoreLocationType = .PrivateFolder, modelLocation: ModelLocation = .MainBundle, errorHandler: ErrorHandler = ErrorHandler()) {
    self.init(configurator: PersistanceConfigurator(name: name, type: type, location: location, errorHandler: errorHandler, modelLocation: modelLocation))
  }
}


// MARK: - Actions
extension PersistenceLayer {
  
  public func persist(moc: NSManagedObjectContext) -> Bool {
    return saveContext(moc)
  }
  
  public func persist() -> Bool {
    return persist(self.mainMOC)
  }
  
  public func saveContext(moc: NSManagedObjectContext) -> Bool {
    var error: NSError?
    if moc.hasChanges && !moc.save(&error) {
      self.errorHandler.handle(error!)
      return false
    }
    return true
  }
}

//MARK: - Factory

public protocol FactoryType {
  func mainMOC (storeCoordinator:  NSPersistentStoreCoordinator) -> NSManagedObjectContext
}

class Factory: FactoryType {
  
  final func mainMOC (storeCoordinator:  NSPersistentStoreCoordinator) -> NSManagedObjectContext {
    let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    moc.persistentStoreCoordinator = storeCoordinator
    moc.name = "main"
    return moc
  }
}
