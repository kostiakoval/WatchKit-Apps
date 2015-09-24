//
//  Counter.swift
//  Counter
//
//  Created by Konstantin Koval on 13/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation

private let counterKey = "counter"
struct Counter {
  
  private (set) var count = 0
  mutating func increase() {
    count += 1
  }
  
  func save() {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(count, forKey: counterKey)
  }
  
  mutating func load() {
   count = NSUserDefaults.standardUserDefaults().integerForKey(counterKey)
  }
  
  mutating func reset() {
    count = 0
    save()
  }
}