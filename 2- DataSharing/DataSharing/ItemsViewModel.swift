//
//  ItemsViewModel.swift
//  DataSharing
//
//  Created by Konstantin Koval on 15/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation

struct ItemsViewModel {

  private(set) var items: [String] = []
  
  init() {
    items = load()
  }
  
  mutating func append(item: String) {
    items.append(item)
    save(items)
  }
  
  mutating func removeItemAt(index: Int) {
    items.removeAtIndex(index)
    save(items)
  }
  
  func save(items: [String]) {
    defaults?.setObject(items, forKey: itemsKey)
    print(defaults?.synchronize())
  }
  func load() -> [String] {
    return defaults?.objectForKey(itemsKey) as? [String] ?? []
  }
  
  private let itemsKey = "items"
  private let defaults = NSUserDefaults(suiteName: "group.com.kkoval.DataSharing")
}
