//
//  ManagedObject.swift
//  Seru
//
//  Created by Konstantin Koval on 29/08/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData
/*
public protocol ManagedObjectInfo {
  
  class func entityName () -> String
  class func entity(inContext moc: NSManagedObjectContext) -> NSEntityDescription
}


extension NSManagedObject : ManagedObjectInfo{

  public class func entityName () -> String {
    let fullName: NSString = NSStringFromClass(self)
    let dot = fullName.rangeOfString(".", options: NSStringCompareOptions.BackwardsSearch)
    let className = fullName.substringFromIndex(dot.location + dot.length)
    return className
  }

  public class func entity(inContext moc: NSManagedObjectContext) -> NSEntityDescription {
    let name = entityName()
    return NSEntityDescription.entityForName(name, inManagedObjectContext: moc)!
  }

  public class func insert(inContext moc: NSManagedObjectContext) -> Self {
    let object = self(entity: entity(inContext: moc), insertIntoManagedObjectContext: moc)
    return object
  }
}
*/