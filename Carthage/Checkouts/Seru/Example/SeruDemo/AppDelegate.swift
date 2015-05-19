//
//  AppDelegate.swift
//  SeruDemo
//
//  Created by Konstantin Koval on 04/03/15.
//  Copyright (c) 2015 Kostiantyn Koval. All rights reserved.
//

import UIKit
import Seru

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var seruStack = Seru()
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    let viewController = (window?.rootViewController as UINavigationController).topViewController as MasterViewController
    viewController.seruStack = seruStack
   
    /*
    //Different way to setup seru
    let seru1 = Seru(name: "Seru")
    var seru2 = Seru(bundle: NSBundle(forClass: AppDelegate.self))
    var seru3 = Seru(name: "Seru", bundle: NSBundle.mainBundle())
    var seru4 = Seru(name: "Seru", bundle: NSBundle.mainBundle(), type: .SQLite, location: .PrivateFolder)
    var seru5 = Seru(location: .SharedGroup("grop.myApp.data"))
    */
    return true
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    seruStack.persist()
  }
  
  func applicationWillTerminate(application: UIApplication) {
    seruStack.persist()
  }
}

