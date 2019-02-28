# StubKit

[![CI Status](https://img.shields.io/travis/polac24/StubKit.svg?style=flat)](https://travis-ci.org/polac24/StubKit)
[![Version](https://img.shields.io/cocoapods/v/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)
[![License](https://img.shields.io/cocoapods/l/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)
[![Platform](https://img.shields.io/cocoapods/p/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)

## Description

StubKit provides a set of functions that speed up a process of creation of Swift mocks. It's goal is to require minimal amount of developer's work in mock creation while  leveraging Swift's type system type integrity for safety. 

Stubs created using StubKit provide a full introspection of function calls, passed arguments and allow to declarativly specify its return value.  

### Sample

```swift 
protocol Database {
  func addUser(name: String) -> Bool
}


class DatabaseStub: Database {    
  lazy var addUserAction = niceStub(of: addUser)  
  func addUser(name: String) -> Bool {     
    return addUserAction(name)    
  }
}

// Arange
var databaseStub = DatabaseStub()
let addUserArgs = spyCalls(of: &databaseStub.addUserAction)
...
// Assert
XCTAssertEqual(addUserArgs.count, 1)
XCTAssertEqual(addUserArgs[0], "User1")
```

To prepare a mock, create a lazy instance variable for each function of your protocol and initialize its initial value using provided in StubKit `stub` or `niceStub` function. In a body of a protocol function, call that dedicated variable with all received arguments. 

In the test body, you define a spy object that tracks all calls and its arguments that can be then verified in an assert section


## Requirements

## Installation

### Carthage



### CocoaPods

StubKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'StubKit'
```

## Author

Bartosz Polaczyk, polac24@gmail.com

## License

StubKit is available under the MIT license. See the LICENSE file for more info.
