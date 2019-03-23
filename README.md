# StubKit

[![Build Status](https://travis-ci.org/polac24/StubKit.svg?branch=master)](https://travis-ci.org/polac24/StubKit)
[![codecov](https://codecov.io/gh/polac24/StubKit/branch/master/graph/badge.svg)](https://codecov.io/gh/polac24/StubKit)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![SPM Compatible](https://img.shields.io/badge/SPM-campatible-green.svg?style=flat)](https://swift.org/package-manager/)
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
- [Author](#author)
- [License](#license)

## Description

StubKit provides a set of functions that speed up a process of creation of Swift stubs/mocks. It's goal is to require minimal amount of developer's work in mock creation while  leveraging Swift's type system type integrity for safety without meta programming nor any code-generation. 

Stubs created using StubKit provide :
* a full introspection of function calls
* passed arguments
* control to declarativly specify its return value(s)
* verify mock's expectations (synchronous and asynchronous) 

## Sample

```swift 
// Sample protocol to work with
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
```
Calls and arguments verification:
```swift
let addUserSpy = spyCalls(of: &databaseStub.addUserAction)
let addAccountSpy = spyCalls(of: &databaseStub.addAccountAction)

databaseStub.addUser(name: "User1") // return 0 (Int's default)
try databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // returns 0

XCTAssertEqual(addUserSpy, ["User1"])
XCTAssertEqual(addAccountSpy.count, 1)
XCTAssertEqual(addAccountSpy[0]?.0, "John")
XCTAssertEqual(addAccountSpy[0]?.1, "Appleseed")
```
Control return value on fly
```swift
setupStubSequence(of: &databaseStub.addUserAction).returns(11)
setupStubSequence(of: &databaseStub.addAccountAction)
    .returnsOnce(1)
    .throws(DatabseError.ioError)

databaseStub.addUser(name: "User2") // return 11
try databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // returns 1
try databaseStub.addAccount(givenName: "John", lastName: "Appleseed") // throws `DatabseError.ioError`
```
Synchronous mock verification
```swift
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
SKTVerify(appleseedSquence) // ✅
XCTAssert(appleseedSquence.verify()) // ✅ - equivalent to SKTVerify(appleseedSquence)
```
Asynchronous mock verification
```swift
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
```

## Full API Documentation

For API documentation, see external document: [API Documentation](docs/documentation.md)

## Requirements

Swift | StubKit
------------ | -------------
`4.2` | `~> 0`
`5.0` | TBD

## Installation

<details><summary>Swift Package Manager</summary>

To depend on the StubKit package, you need to declare your dependency in your `Package.swift`:


```swift
// it's early days here so we haven't tagged a version yet, but will soon
.package(url: "https://github.com/polac24/StubKit.git",  from: "0.0.6")
```

and to your application/library target, add "StubKit" to your dependencies.

</details>

<details><summary>Carthage</summary>

Add the following line to your `Cartfile`:

```
github "polac24/StubKit" ~> 0
```

For detailed instruction to integrate carthage dependency, see [Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

</details>
<details><summary>CocoaPods</summary>

StubKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add `StubKit` dependency for your testing target, like:

```ruby
target 'StubKitExampleTests' do
    inherit! :search_paths
    pod 'StubKit'
end
```
</details>

## Author

Bartosz Polaczyk, polac24@gmail.com

## License

StubKit is available under the MIT license. See the LICENSE file for more info.
