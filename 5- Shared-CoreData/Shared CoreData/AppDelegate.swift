//
//  AppDelegate.swift
//  Shared CoreData
//
//  Created by Konstantin Koval on 24/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit
import SharedKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var stack = Seru(location: .SharedGroup(SharedGroupName))

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    if let navigationVC = window?.rootViewController as? UINavigationController {
      if let masterVC = navigationVC.topViewController as? MasterViewController {
        masterVC.stack = stack
      }
    }

    return true
  }

  func applicationDidEnterBackground(application: UIApplication) {
    stack.persist()
  }

}

