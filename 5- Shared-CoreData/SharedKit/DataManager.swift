//
//  DataManager.swift
//  Shared CoreData
//
//  Created by Konstantin Koval on 24/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData

public class DataManager {

  public class func loadAll(contex: NSManagedObjectContext) -> Array<Record> {
    let fetch = NSFetchRequest(entityName: "Record")
    var er: NSError? = nil
    let result_maybe = contex.executeFetchRequest(fetch, error: &er)
    if let result = result_maybe as? [Record] {
      return result
    }
    assertionFailure("Can't load Records")
    fatalError("Erro")
  }

  public class func insertNewRecord(context: NSManagedObjectContext) -> Record {
    let r: Record = NSEntityDescription.insertNewObjectForEntityForName("Record", inManagedObjectContext: context) as! Record
    r.timestamp = NSDate()
    return r
  }

}
