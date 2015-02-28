//
//  FetchResultController.swift
//  Seru
//
//  Created by Konstantin Koval on 29/08/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData

public class FetchResultController {

  public class func make(moc: NSManagedObjectContext, entityName: String, sortKey: String, ascending: Bool = false, fetchBatchSize: Int = 20) -> NSFetchedResultsController {

    let fetchRequest = NSFetchRequest()
    let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: moc)
    fetchRequest.entity = entity
    fetchRequest.fetchBatchSize = fetchBatchSize
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: sortKey, ascending: ascending)]
  
    return make(moc, fetchRequest: fetchRequest)
  }
  
  public class func make(moc: NSManagedObjectContext, fetchRequest: NSFetchRequest, sectionNameKeyPath: String! = nil, cacheName: String! = nil) -> NSFetchedResultsController {
      let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: sectionNameKeyPath, cacheName: cacheName)
    return aFetchedResultsController
  }
  
  public class func fetch(fetchRC: NSFetchedResultsController, errorHandler: ErrorHandler) {
    var error: NSError? = nil
    if !fetchRC.performFetch(&error) {
      errorHandler.handle(error!)
    }
  }
}