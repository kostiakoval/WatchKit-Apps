//
//  MasterViewController.swift
//  test111
//
//  Created by Konstantin Koval on 27/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit
import CoreData
import Seru

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

  var stack: PersistenceLayer!
  var objects: [NSManagedObject]!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationItem.leftBarButtonItem = self.editButtonItem()

    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
    self.navigationItem.rightBarButtonItem = addButton
    fetch()
  }
  
  func updateTable() {
    fetch()
    tableView.reloadData()
  }


  func fetch() {
    let fetch = NSFetchRequest(entityName: "Entity")
    var error: NSError?
    if let result = stack.mainMOC.executeFetchRequest(fetch, error: &error) as? [NSManagedObject] {
      objects = result
    }
  }
  
  func insertNewObject(sender: AnyObject) {
    
    var object = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: stack.mainMOC) as! NSManagedObject
    object.setValue(NSDate(), forKey: "time")
    stack.persist()
    updateTable()
  }

  // MARK: - Table View

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    self.configureCell(cell, atIndexPath: indexPath)
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      let context = self.stack.mainMOC
      context.deleteObject(objects[indexPath.row] as NSManagedObject)
      stack.persist()
      updateTable()
    }
  }

  func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
    let object = objects[indexPath.row]
    cell.textLabel!.text = object.valueForKey("time")!.description
  }
}

