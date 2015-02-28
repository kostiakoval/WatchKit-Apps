//
//  FetchResultControllerDataSource.swift
//  Seru
//
//  Created by Konstantin Koval on 08/09/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class FetchResultControllerTableViewDataSource : NSObject, UITableViewDataSource {
  
  private var fetchedResultsController: NSFetchedResultsController
  //public typealias cellConfigType = (UITableViewCell, NSManagedObject) -> ()
  private var configureCell: (UITableViewCell, object: NSManagedObject) -> ()
  public var editable: Bool

  
  public init(fetchedResultsController: NSFetchedResultsController, editable: Bool = false, configureCell: (cell: UITableViewCell, object: NSManagedObject) -> ()) {
    self.fetchedResultsController = fetchedResultsController
    self.configureCell = configureCell
    self.editable = editable
  }
  
  //MARK: - Public Interface
  public func objectAtIndexPath(indexPath: NSIndexPath) -> NSManagedObject {
    return fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
  }
  
  public subscript (indexPath: NSIndexPath) -> NSManagedObject {
    return objectAtIndexPath(indexPath)
  }

 
  //MARK: - UITableViewDataSource
  
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionsInfo = self.fetchedResultsController.sectionsInfo
    let sectionInfo = sectionsInfo[section]
    return sectionInfo.numberOfObjects
  }

  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    configureCell(cell, object: self[indexPath])
    return cell
  }


// MARK: optionals
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    let sectionsInfo = self.fetchedResultsController.sections as! [NSFetchedResultsSectionInfo]
    return sectionsInfo.count
  }

//  MARK: Editable
  public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return editable
  }
  
  public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      
//      let context = persistenceController.mainMOC
//      context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
//      persistenceController.persist()
    }
  }


}

extension NSFetchedResultsController {
  
  var sectionsInfo: [NSFetchedResultsSectionInfo] {
    return sections as! [NSFetchedResultsSectionInfo]
  }
}