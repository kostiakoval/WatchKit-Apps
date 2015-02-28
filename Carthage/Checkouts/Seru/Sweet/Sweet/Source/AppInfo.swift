//
//  AppInfo.swift
//  MyMovies
//
//  Created by Konstantin Koval on 25/08/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import Foundation

public class AppInfo {
    
  public class var productName: String {
    
    if let dic = NSBundle.mainBundle().infoDictionary {
      return dic ["CFBundleName"] as! String
    }
    assertionFailure("can't get CFBundleName")
  }
}