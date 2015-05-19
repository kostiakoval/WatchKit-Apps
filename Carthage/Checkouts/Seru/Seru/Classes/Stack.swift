//
//  Stack.swift
//  Seru
//
//  Created by Konstantin Koval on 28/02/15.
//  Copyright (c) 2015 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData

public protocol CoreDataStack {
  
  var mainMOC: NSManagedObjectContext {get}
  var model: NSManagedObjectModel {get}
  var coordinator: NSPersistentStoreCoordinator {get}
}

public class BaseStack: CoreDataStack {
  
  public let mainMOC: NSManagedObjectContext
  public let model: NSManagedObjectModel
  public let coordinator: NSPersistentStoreCoordinator
  
  public init(name:String = AppInfo.productName, bundle: NSBundle = NSBundle.mainBundle(), type: StoreType = .SQLite, location: StoreLocation = .PrivateFolder) {

    model = modelWithName(name, inBundle: bundle)
    coordinator =  NSPersistentStoreCoordinator(managedObjectModel: model)
    
    //setupCoordinator
    let url = storeUrl(name, type: type, location: location)
    BaseStack.setupStore(coordinator, type: type, configuration: nil, URL: url)

    mainMOC = BaseStack.mainMOC(coordinator)
  }
  
//MARK: - Internal 
  
  class func mainMOC (storeCoordinator:  NSPersistentStoreCoordinator) -> NSManagedObjectContext {
    let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    moc.persistentStoreCoordinator = storeCoordinator
    moc.name = "main"
    return moc
  }
  
  class func setupStore(coordinator: NSPersistentStoreCoordinator, type:StoreType, configuration: String?, URL: NSURL?) -> NSError? {
    
    let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption:true]
    var error: NSError?
    coordinator.addPersistentStoreWithType(type.coreDataType, configuration: configuration, URL: URL, options: options, error: &error)
    return error
  }
}