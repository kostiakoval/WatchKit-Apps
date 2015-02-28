//
//  AppDelegate.swift
//  AppsCommunication
//
//  Created by Konstantin Koval on 14/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var personViewController: PersonViewController {
    return window?.rootViewController as! PersonViewController
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }


  func application(application: UIApplication, handleWatchKitExtensionRequest
    userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)?) {
   
    if let info = userInfo as? [String: String] {
      personViewController.showPerson(info["personName"]!)
      reply.map { $0(["response" : "success"]) }
    } else {
      reply.map { $0(["response" : "fail"]) }
    }
  }

}

