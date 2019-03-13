# StubKit

[![CI Status](https://img.shields.io/travis/polac24/StubKit.svg?style=flat)](https://travis-ci.org/polac24/StubKit)
[![Version](https://img.shields.io/cocoapods/v/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)
[![License](https://img.shields.io/cocoapods/l/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)
[![Platform](https://img.shields.io/cocoapods/p/StubKit.svg?style=flat)](https://cocoapods.org/pods/StubKit)

## Overview:

- [Overview:](#overview-)
- [Description](#description)
- [Sample](#sample)
- [API Documentation](docs/documentation.md)
- [Requirements](#requirements)
- [Installation](#installation)
  * [Carthage](#carthage)
  * [CocoaPods](#cocoapods)
- [Author](#author)
- [License](#license)

## Description

StubKit provides a set of functions that speed up a process of creation of Swift stubs/mocks. It's goal is to require minimal amount of developer's work in mock creation while  leveraging Swift's type system type integrity for safety without meta programming nor code-generation. 

Stubs created using StubKit provide :
* a full introspection of function calls
* passed arguments
* control to declarativly specify its return value(s)
* verify mock's expectations (synchronous and asynchronous) 

## Sample

```swift 
// Protocol to work with
protocol Database {
  func addUser(name: String) -> Int
  func addAccount(givenName: String, lastName: String) throws -> Int
}

// Mock creation
class DatabaseStub: Database {    
  lazy var addUserAction = stub(of: addUser)  
  func addUser(name: String) -> Int {     
    return addUserAction(name)    
  }
  
  lazy var addAccountAction = stub(of: addAccount)  
  func addAccount(givenName: String, lastName: String) throws -> Int {
    return try addAccountAction((givenName, lastName))    
  }
}

// Arange
let databaseStub = DatabaseStub()

// ------ Calls and arguments verification
let addUserSpy = spyCalls(of: &databaseStub.addUserAction)
let addAccountSpy = spyCalls(of: &databaseStub.addAccountAction)

try databaseStub.addUser(name: "User1") // return 0 (Int default)
try databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // returns 0

XCTAssertEqual(addUserSpy, ["User1"])
XCTAssertEqual(addAccountSpy.count, 1)
XCTAssertEqual(addAccountSpy[0]?.0, "John")
XCTAssertEqual(addAccountSpy[0]?.1, "Appleseed")

// ------ Return control
setupStubSequence(of: &databaseStub.addUserAction).returns(11)
setupStubSequence(of: &databaseStub.addAccountAction)
    .returnsOnce(1)
    .throws(DatabseError.ioError)

databaseStub.addUser(name: "User2") // return 11
databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // returns 1
databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // throws

// ------ Verify synchronously
let user3Squence = setupStubSequence(of: &databaseStub.addUserAction)
    .when("User3")
    .expect(.once)
let user3TwiceSquence = setupStubSequence(of: &databaseStub.addUserAction)
    .when("User3")
    .expect(.times(2))
let appleseedSquence = setupStubSequence(of: &databaseStub.addAccountAction)
    .whenSecond("Appleseed")
    .expect(.atLeastOnce)
    .returns(99)
    
databaseStub.addUser(name: "User3") // return 0
try databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // returns 99
try databaseStub.addAccount(givenName: "Tim", lastName: "Appleseed") // returns 99

SKTVerify(user3Squence) // ✅
SKTVerify(user3TwiceSquence) // 🛑
XCTAssert(user3TwiceSquence.verify()) // 🛑 - equivalent to SKTVerify
SKTVerify(appleseedSquence) // ✅

// ------ Verify asynchronously
setupStubSequence(of: &databaseStub.addUserAction)
    .when("User3")
    .expect(.once)
    .attach(expectation(description: "User3 added once"))
setupStubSequence(of: &databaseStub.addAccountAction)
    .whenFirst("John")
    .expect(.once)
    .attach(expectation(description: "John added once"))
    .returns(100)
    
DispatchQueue.global(qos: .background).async {
    databaseStub.addUser(name: "User3") // return 0
    try? databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // returns 100
    try? databaseStub.addAccount(givenName: "Tim", lastName: "Appleseed") // returns 99
}

waitForExpectations(timeout: 0.1) //✅

// ------ Final spy
XCTAssertEqual(addUserSpy, ["User1","User2","User3","User4"]) //✅
XCTAssertEqual(addAccountSpy.count, 7) //✅
```


## Full API Documentation

For API documentation, see external document: [API Documentation](docs/documentation.md)

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
