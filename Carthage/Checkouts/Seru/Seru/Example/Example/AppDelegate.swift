//
//  AppDelegate.swift
//  Example
//
//  Created by Konstantin Koval on 27/08/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit
import Seru

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?
  var persistenceController =  PersistenceLayer()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
    let viewController = (window?.rootViewController as! UINavigationController).topViewController as! MasterViewController
    viewController.stack = persistenceController
    return true
  }

  func applicationWillTerminate(application: UIApplication) {
    persistenceController.persist()
  }
}

