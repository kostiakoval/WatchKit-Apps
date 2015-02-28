//
//  FileHelpTest.swift
//  Sweet
//
//  Created by Konstantin Koval on 20/12/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

import UIKit
import XCTest

class FileHelpTest: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testDocumentDirectory() {
    
    // This is an example of a functional test case.
    let documentDir = FileHelper.documentDirectory
    XCTAssertNotNil(documentDir, "documentDirectory must be not nil")
    XCTAssertTrue(documentDir.hasSuffix("Documents"), "it must be Documents directory")
  }
  
  func testfilePath() {
    let fileName = "test.txt"
    let path = FileHelper.filePath(fileName)
    checkPathForFileName(path, fileName: fileName)
    XCTAssertTrue(path.hasSuffix("Documents/\(fileName)"), "by defaul it should be in Documents folder")
  }
  
  func testfilePathInCasheDirectory() {
    let fileName = "test.txt"
    let path = FileHelper.filePath(fileName, directory: .CachesDirectory)
    checkPathForFileName(path, fileName: fileName)
    XCTAssertTrue(path.hasSuffix("Library/Caches/\(fileName)"), "It should be in Library/Caches folder")
  }
  
  //  MARK:- Private
  
    private func checkPathForFileName(path: String, fileName:String) {
      XCTAssertNotNil(path, "Must return a path to file")
      XCTAssertTrue(path.hasSuffix(fileName), "It has to be correct file name")
    }
}
