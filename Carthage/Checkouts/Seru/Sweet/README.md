Sweet
=====

[![Build Status](https://travis-ci.org/kostiakoval/Sweet.svg?branch=develop)](https://travis-ci.org/kostiakoval/Sweet)

A collection of common small boilerplate in Swift

#### AppInfo  

``` swift
 let name = AppInfo.productName 
 //Name of your project. Useful fot getting default coreData module and other things
```

#### FileHelper  

A nice API for working with files locations

``` swift
let documentDir = FileHelper.documentDirectory  
let path = FileHelper.filePath(fileName) // file path in Documents directory  
let path = FileHelper.filePath(fileName, directory: .CachesDirectory)  
// file path in CachesDirectory

```
