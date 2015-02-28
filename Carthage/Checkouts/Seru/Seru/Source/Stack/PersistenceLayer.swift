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
    self.init(configurator: PersistanceConfigurator(type: type, location: location, modelLocation: modelLocation, errorHandler: errorHandler))
  }
  
  public convenience init(name: String, type: StoreType = .SQLite, location: StoreLocationType = .PrivateFolder, modelLocation: ModelLocation = .MainBundle, errorHandler: ErrorHandler = ErrorHandler()) {
    self.init(configurator: PersistanceConfigurator(name: name, type: type, location: location, modelLocation: modelLocation, errorHandler: errorHandler))
  }
}


// MARK: - Actions
public extension PersistenceLayer {
  
  //typealias ResultType = Bool -> Void
  
  public func persist(moc: NSManagedObjectContext) {
    saveContext(moc)
  }
  
  public func persist() {
    return persist(self.mainMOC)
  }
  
  public func saveContext(moc: NSManagedObjectContext, completion: (Bool -> Void)? = nil) {
    moc.performBlock {
      var error: NSError?
      var result: Bool = true
      if moc.hasChanges && !moc.save(&error) {
        self.errorHandler.handle(error!)
        result = false
      }
      main_queue_call_if(completion, result)
    }
  }
  
  public func saveContextsChain(moc: NSManagedObjectContext, completion: (Bool -> Void)? = nil) {

    saveContext(moc) { [unowned self] result in
      if result && moc.parentContext != nil {
        self.saveContextsChain(moc.parentContext!, completion: completion)
      } else {
        call_if(completion, result)
      }
    }
  }

  
  public func performBackgroundSave(block :(context: NSManagedObjectContext) -> Void, completion: (Bool -> Void)? ) {
   
    let context = PersistenceLayer.backgroundContext(parent: mainMOC)
    context.performBlock {
     block(context: context)
      self.saveContextsChain(context, completion: completion)
    }
  }
  
  //MARKL:- Context
  public class func backgroundContext(parent: NSManagedObjectContext? = nil) -> NSManagedObjectContext {
    var context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
    context.name = "background"
    context.parentContext = parent
    return context
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


//MARK - Helpers
func if_let<T>(a: T?, f: (T) -> Void) {
  if let a = a {
    f(a)
  }
}

func call_if<P>(f: (P -> Void)?, param: P) {
  if let f = f {
     f(param)
  }
}

func main_queue_call_if<P>(f: (P -> Void)?, param: P) {
  if let f = f {
    dispatch_async(dispatch_get_main_queue(), {
      f(param)
    })
  }
}



