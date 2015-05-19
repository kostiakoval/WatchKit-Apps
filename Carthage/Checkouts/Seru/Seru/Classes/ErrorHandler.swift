//
//  ErrorHandler.swift
//  Seru
//
//  Created by Konstantin Koval on 25/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation

public typealias ErrorHandlerType = NSError -> Void

public protocol ErrorHandling {
  func handle(error: NSError)
  func handle(errorMessage: String)
}

public struct ErrorHandler : ErrorHandling  {
  
  //MARK: - ErrorHandling
  public func handle(error: NSError) {
    let message = "Unresolved Core Data Error \(error), \(error.userInfo)"
    handleError(message)
  }
  
  public func handle(errorMessage: String) {
    handleError(errorMessage)
  }
  
  private func handleError(error: String) {
    println(error)
    abort()
  }
}



