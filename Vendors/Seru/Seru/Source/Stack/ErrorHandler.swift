//
//  ErrorHandler.swift
//  Seru
//
//  Created by Konstantin Koval on 25/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation

public class ErrorHandler {
  
  public typealias errorHandlerType = (NSError)->()
  private var handler: errorHandlerType
  
  public init(errorHandler: errorHandlerType) {
    handler = errorHandler
  }
  
  public convenience init() {
    self.init(errorHandler: Factory.defaultErrorHandler())
  }
  
  public func handle(error: NSError) {
    handler(error)
  }
}

private extension ErrorHandler {
  
  class Factory {
    
    class func defaultErrorHandler () -> ErrorHandler.errorHandlerType {
      return { error in
        NSLog("Unresolved Core Data Error \(error), \(error.userInfo)")
        abort()
      }
    }
  }
}
