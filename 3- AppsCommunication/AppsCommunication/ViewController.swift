//
//  ViewController.swift
//  AppsCommunication
//
//  Created by Konstantin Koval on 14/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit


class PersonViewController: UIViewController {
  @IBOutlet private weak var personName: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
//MARK: - public 
  func showPerson(name: String) {
    personName.text = name
  }

  
  
}


