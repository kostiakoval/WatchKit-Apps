Seru (セル) 
=====
[![Build Status](https://travis-ci.org/kostiakoval/Seru.svg?branch=develop)](https://travis-ci.org/kostiakoval/Seru) 
[![CocoaPods](https://img.shields.io/cocoapods/v/Seru.svg)]()
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Seru.svg?style=flat)](http://cocoadocs.org/docsets/Seru)
[![Platform](https://img.shields.io/cocoapods/p/Seru.svg?style=flat)](http://cocoadocs.org/docsets/Seru)

##Core Data in Swift.

**Seru (Cell in Japanese)** is a clean and beautiful Core Data stack in Swift.  
Seru is design to be light and fast and to fit all type of applications.  

**Use example**: Setup Core Data in **1** line of code `Seru()` 
and insert object in background.

```swift
let seru = Seru()

seru.performBackgroundSave({ context in
  let person = Person(managedObjectContext: context)
  person.name = "Petter"
}
``` 
 
## Usages

#### Setup CoreData

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {            
  lazy var seruStack = Seru()
  ...
}
```

#### Actions 

Save
```swift
var seruStack: Seru
seruStack.persist()
```

Perform background save.
All the changes will be saved to the context
```swift
seruStack.performBackgroundSave({ context in
  let person = Person(managedObjectContext: context)
}
```

Perform background work
```swift
seruStack.performInBackgroundContext { context in
  let fetch = NSFetchRequest(entityName: "Person")
  var error: NSError?
  let result = context.executeFetchRequest(fetch, error: &error)
}
```



##Installation

### CocoaPods
Seru is available through [CocoaPods](http://cocoapods.org). To install :

 - Install latest version of cocoapods `[sudo] gem install cocoapods --pre`
 - Add the following line to your Podfile:
 
```
use_frameworks!
pod 'Seru'
```

### Carthage
Installation is available using the dependency manager Carthage.

 - Install Carthage `brew install carthage`
 - Add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile) file

```
github "kostiakoval/Seru"
```
-  Run `carthage update`
-  Add Seru.framework (from Carthage/build directory) to your project.

### Submodules

```
mkdir Vendor # you can keep your submodules in their own directory
git submodule add git@github.com:kostiakoval/Seru.git Vendor/Seru
git submodule update --init --recursive
```

### TODO
- [ ] CoreData Stack with background saving context
- [ ] Background data importer stack
- [ ] Error handler with UIAlertView
- [ ] Creating child contexts
- [ ] Differents CoreData Stacks support

## Author

Kostiantyn Koval  
[@KostiaKoval](https://twitter.com/KostiaKoval)

## License

Seru is available under the MIT license. See the LICENSE file for more info.


