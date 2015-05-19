//
//  Actions.swift
//  Seru
//
//  Created by Konstantin Koval on 28/02/15.
//  Copyright (c) 2015 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData

protocol StorageAtions {

  var errorHandler: ErrorHandling {get}
  var mainMOC: NSManagedObjectContext {get}

  func persist(moc: NSManagedObjectContext)
}

public class Seru {
  let stack: CoreDataStack
  let errorHandler: ErrorHandling

  public init (stack: CoreDataStack) {
    self.stack = stack
    errorHandler = ErrorHandler()
  }
  
  public convenience init(name:String = AppInfo.productName, bundle: NSBundle = NSBundle.mainBundle(), type: StoreType = .SQLite, location: StoreLocation = .PrivateFolder) {
    self.init(stack: BaseStack(name: name, bundle: bundle, type: type, location: location))
  }
  
//MARK: - Functionalioty 

  public func persist() {
    return persist(stack.mainMOC)
  }

  public func persist(moc: NSManagedObjectContext) {
    saveContext(moc)
  }
  
//MARK: - Perform

  public func performInBackgroundContext(block: (context: NSManagedObjectContext) -> Void) {
    let context = Seru.backgroundContext(parent: stack.mainMOC)
    performWorkInContext(context, block: block)
    }
  
  public func performInMainContext(block: (context: NSManagedObjectContext) -> Void) {
    performWorkInContext(stack.mainMOC, block: block)
  }
  
  func performWorkInContext(context: NSManagedObjectContext, block: (context: NSManagedObjectContext) -> Void) {
    context.performBlock {
      block(context: context)
    }
  }

  public func performBackgroundSave(block: (context: NSManagedObjectContext) -> Void) {
    self.performBackgroundSave(block, completion: nil)
  }
  
  public func performBackgroundSave(block: (context: NSManagedObjectContext) -> Void, completion: (Bool -> Void)? = nil) {
    
    let context = Seru.backgroundContext(parent: stack.mainMOC)
    context.performBlock {
      block(context: context)
      self.saveContext(context, completion: {result in
        
        if let parentContex = context.parentContext {
          self.saveContextsChain(parentContex, completion: completion);
        } else {
          call_if(completion, result)
        }
      });
    }
  }
  
//MARKL:- Context
  public class func backgroundContext(parent: NSManagedObjectContext? = nil) -> NSManagedObjectContext {
    var context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
    context.name = "Background"
    context.parentContext = parent
    return context
  }
  
//MARK: - Private
  
  //MARK: - Save
  public func saveContext(moc: NSManagedObjectContext, completion: (Bool -> Void)? = nil) {
  
    var error: NSError?
    var result: Bool = true
    
    if moc.hasChanges && !moc.save(&error) {
      self.errorHandler.handle(error!)
      result = false
    }
    main_queue_call_if(completion, result)
  }

  func saveContextsChain(moc: NSManagedObjectContext, completion: (Bool -> Void)? = nil) {

    moc.performBlock {
      self.saveContext(moc) { [unowned self] result in
        if result && moc.parentContext != nil {
          self.saveContextsChain(moc.parentContext!, completion: completion)
        } else {
          call_if(completion, result)
        }
      }
    }
  }

}

//MARK - Helpers

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
