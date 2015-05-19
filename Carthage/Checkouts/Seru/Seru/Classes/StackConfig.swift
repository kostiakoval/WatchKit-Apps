//
//  StackConfig.swift
//  Seru
//
//  Created by Konstantin Koval on 01/03/15.
//  Copyright (c) 2015 Konstantin Koval. All rights reserved.
//

import Foundation
import CoreData

//MARK: - Model

func modelWithName(name: String, inBundle bundle: NSBundle) -> NSManagedObjectModel {
  if let modelURL = bundle.URLForResource(name, withExtension: "momd") {
    if let model = NSManagedObjectModel(contentsOfURL:modelURL) {
      return model
    }
  }
  assertionFailure("Model with name is not available")
}

//MARK: Store Coordinator

public enum StoreType {
  case SQLite
  case Binary
  case InMemory
  
  public var coreDataType: String {
    switch self {
    case .SQLite: return NSSQLiteStoreType
    case .Binary: return NSBinaryStoreType
    case .InMemory: return NSInMemoryStoreType
    }
  }
}

public enum StoreLocation {
  case PrivateFolder // NSDomentDirectiry Folder
  case SharedGroup(String) // Located in shared Group directory
}


func storeUrl(name: String, #type: StoreType, #location: StoreLocation) -> NSURL? {
  
  switch (type, location) {
    
  case (.Binary, .PrivateFolder):
    return NSURL.fileURLWithPath(FileHelper.filePath("\(name).data"))
  case (.SQLite, .PrivateFolder):
    return NSURL.fileURLWithPath(FileHelper.filePath("\(name).sqlite"))
  case (_, .SharedGroup(let group)):
    return FileHelper.sharedFilePath(group)(file: "\(name).sqlite")
  case (_, _):
    return nil
  }
}
