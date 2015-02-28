//
//  FetchedResultsControllerDelegateHandler.swift
//  Seru
//
//  Created by Konstantin Koval on 08/09/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class FetchedResultsControllerDelegateHandler : NSFetchedResultsControllerDelegate {
  
  private var tableView: UITableView;
  private var configureCell: (cell: UITableViewCell, atIndexPath: NSIndexPath) -> ()

  
  public init (tableView: UITableView, configureCell: (cell: UITableViewCell, atIndexPath: NSIndexPath) -> ()) {
    self.tableView = tableView
    self.configureCell = configureCell
  }
  
//  MARK: NSFetchedResultsControllerDelegate
  public func controllerWillChangeContent(controller: NSFetchedResultsController) {
    self.tableView.beginUpdates()
  }

  public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    switch type {
    case .Insert:
      self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
    case .Delete:
      self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
    default:
      return
    }
  }
  
  public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert:
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    case .Delete:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    case .Update:
      configureCell(cell: tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
    case .Move:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    default:
      return
    }
  }
  
  public func controllerDidChangeContent(controller: NSFetchedResultsController) {
    self.tableView.endUpdates()
  }
  
  /*
  // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
  // In the simplest, most efficient, case, reload the table view.
  self.tableView.reloadData()
  }
  */

}
