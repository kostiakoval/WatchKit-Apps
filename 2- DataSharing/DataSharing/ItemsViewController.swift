//
//  ItemsViewController.swift
//  DataSharing
//
//  Created by Konstantin Koval on 15/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var viewModel = ItemsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
  }
  
  @IBAction func createItem(sender: UITextField) {

    viewModel.append(sender.text!)
    sender.text = nil
    tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.count
  }
  
  //  MARK: TableView
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) 
    cell.textLabel?.text = viewModel.items[indexPath.row]
    return cell
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
   
    switch editingStyle {
    case .Delete:
        viewModel.removeItemAt(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    default:
        break
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    return textField.resignFirstResponder()
  }
}
