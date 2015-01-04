//
//  Record.swift
//  Shared CoreData
//
//  Created by Konstantin Koval on 24/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData

@objc(Record)
public class Record: NSManagedObject {

    @NSManaged public var timestamp: NSDate

}
