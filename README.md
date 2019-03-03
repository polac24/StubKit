# StubKit

[![CI Status](https://img.shields.io/travis/polac24/StubKit.svg?style=flat)](https://travis-ci.org/polac24/StubKit)
[![Version](https://img.shields.io/cocoapods/v/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)
[![License](https://img.shields.io/cocoapods/l/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)
[![Platform](https://img.shields.io/cocoapods/p/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)

## Overview:

- [Description](#description)
- [Sample](#sample)
- [API Documentation](docs/documentation.md)
- [Requirements](#requirements)
- [Installation](#installation)
    - [Carthage](#carthage)
    - [CocoaPods](#cocoapods)

## Description

StubKit provides a set of functions that speed up a process of creation of Swift mocks. It's goal is to require minimal amount of developer's work in mock creation while  leveraging Swift's type system type integrity for safety. 

Stubs created using StubKit provide a full introspection of function calls, passed arguments and allow to declarativly specify its return value.  

## Sample

```swift 
protocol Database {
  func addUser(name: String) -> Bool
}

// Mock creation
class DatabaseStub: Database {    
  lazy var addUserAction = niceStub(of: addUser)  
  func addUser(name: String) -> Bool {     
    return addUserAction(name)    
  }
}

// Arange
var databaseStub = DatabaseStub()
let addUserSpy = spyCalls(of: &databaseStub.addUserAction)
// Act
...
// Assert
XCTAssertEqual(addUserSpy, ["User1"])
```

To prepare a mock:
1. create a lazy instance variable for each function of your protocol and initialize its initial value using provided in StubKit `stub` or `niceStub` function
2. In a body of a protocol function, call that dedicated variable with all received arguments. 
3. In the test body, you define a spy object that tracks all calls and its arguments 

Mock verification:
1. Compare spy to the expected array of call arguments


## API Documentation

For API documentation, see external documnet [Documentation](docs/documentation.md)

## Requirements

Swift | StubKit
------------ | -------------
`4.2` | `~> 0`
`5.0` | TBD

## Installation

### Carthage

Add the following line to your `Cartfile`:

```
github "polac24/StubKit" ~> 0
```

For detailed instruction to integrate carthage dependency, see [Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

### CocoaPods

StubKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add `StubKit` dependency for your testing target, like:

```ruby
target 'StubKitExampleTests' do
    inherit! :search_paths
    pod 'StubKit'
end
```

## Author

Bartosz Polaczyk, polac24@gmail.com

## License

StubKit is available under the MIT license. See the LICENSE file for more info.
