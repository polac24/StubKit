
# StubKit API documentation

## Overview


- [API](#api)
    - [Subbing](#subbing)
    - [Registration](#registration)
    - [Argument verification - spy recorder](#argument-verification-spy-recorder)
- [Limitations](#limitations)

## API


### Stubbing

To prepare a mock that conforms a protocol, you have to manually create a class type that contains a single lazy var for each function of a protocol, which is then called from a body of a function, e.g.:


```swift
protocol Database {
    func addUser(name: String) -> Bool
    func addAccount(givenName: String, lastName: String) -> Bool
}

class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser)
    func addUser(name: String) {
        return addUserAction(name)
    }
    lazy var addAccountAction = stub(of: addAccount)
    func addAccount(givenName: String, lastName: String) -> Bool
        // pass all the arguments as a tuple
        return addAccountAction((givenName, lastName))
    }
}
```

For multi-parameter function, you should call the corresponding action variable with all arguments wrapped in a tuple.

> Stubs in StubKit are loose by default so mock's functions can bee freely called. 

### Stub return value

#### Automatic return value

Some types, (like `Void`, `String`, `Int` etc.) have predefined default values that stub can return without any specific declaration. You can enable automatic stubbing it for your custom types by conforming to `DefaultProvidable` type:

```swift
struct CustomType: DefaultProvidable {
    static var defaultValue =  CustomType(...)
}
```

Here is a list of predefined default values provided by StubKit library:

Type | Default value
------------ | -------------
`String` | `""`
`Bool` | `false`
`Int` | `0`
`UInt` | `0`
`Double` | `0.0`
`Decimal` | `0.0`
`CGFloat` | `0.0`
`Data` | `Data()`
`Array` | `[]`
`Dictionary` | `[:]`
`Set` | `[]`
`Optional` | `nil`
`Locale` | `Locale(identifier: "")`
`URL` | `URL(fileURLWithPath: "/")`
`URLComponents` | `URLComponents()`
`URLQueryItem` | `URLQueryItem(name: "", value: nil)`

#### Manual return type

If some return type cannot conform to `DefaultProvidable` (e.g. for a tuple) or your stub should return other value than default one, you can manually specify it while stubbing:

```
class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser, alwaysReturn: true)
    func addUser(name: String) -> Bool {
        return addUserAction(name)
    }
}
```

#### Manual throwing

You can customize your stub behaviour to always throw a specific error as:

```
class DatabaseMock: Database {
    lazy var addUserThrowingAction = stub(of: addUser, alwaysThrow: DatabaseError())
    func addUserThrowing(name: String) throws -> Bool {
        return addUserAction(name)
    }
}
```

### Strict Stubbing

StubKit's term "strict stubbing" means that body of a protocol function has to be explicitly defined (registered) before it is ever called during test scenario. Any call to a stubbed function that hasn't been registerd crashes the test. Stubbing could be a part of strict mock implementation, where test scenario has to manually specify which functions are allowed to be called during test. 

```swift
protocol Database {
func addUser(name: String) -> Bool
}
class DatabaseMock: Database {
    lazy var addUserAction = strictStub(of: addUser)
    func addUser(name: String) -> Bool {
        return addUserAction(name)
    }
}
        

/// Testcase

// no registration
databaseMock.addUser(name: "user1") // crash 💥

// automatic registration
databaseMock.addUserAction = registerStub(alwaysReturn: true)
databaseMock.addUser(name: "user1") // OK ✅

// manual registration
databaseMock.addUserAction = { _ in
    return false
}
databaseMock.addUser(name: "user1") // OK ✅
```

> Strict stubbing is very restrictive so it recommended to prefer standard stubbing instead.

##### Ambigious functions stub

If your protocol contains the same name of a function `Ambiguous use of 'addUser'` but with different number of parameters, you can give compiler a hint which to stub by adding full signature with parameters:

```swift
protocol DatabaseProtocol {
    func addUser(_ name: String) -> Bool
    func addUser(_ name: String, at: Date) -> Bool
}
class DatabaseProtocolMock: DatabaseProtocol {
    lazy var addUserAction = stub(of: addUser(_:))
    func addUser(_ name: String) -> Bool {
        return addUserAction(name)
    }
    lazy var addUserAtAction = stub(of: addUser(_:at:))
    func addUser(_ name: String, at date: Date) -> Bool {
        return addUserAtAction((name, date))
    }
}
```

However, for overloaded functions, above approach doesn't work so you need to specify stub's return type:

```swift
protocol DatabaseProtocol {
    func addUser(_ name: String) -> Bool
    func addUser(_ id: Int) -> Bool
}
class DatabaseProtocolMock: DatabaseProtocol {
    lazy var addUserAction:(String) -> Bool = stub(of: addUser)
    func addUser(_ name: String) -> Bool {
        return addUserAction(name)
    }
    lazy var addUserIntAction:(Int) -> Bool = stub(of: addUser)
    func addUser(_ name: Int) -> Bool {
        return addUserIntAction(name)
    }
}
```

#### Registration

You can change the return value for your mock for a specific instance by "registering" it. Register can by done automatically or manually. 

##### Automatic registration


```swift
databaseMock.addUserAction = registerStub(alwaysReturn: true)
```

Alternatively, to specify throwing function, you can register it with `alwaysThrow` parameter: 
```swift
databaseMock.addUserThrowingAction = registerStub(alwaysThrow: DatabaseError())
```


##### Manual registration with custom body

Optionally, you may specify custom behaviour that happens when given function is called:

```swift
databaseMock.addUserAction = { _ in 
    return true
}
```

### Argument verification - spy recorder

Once you have mock ready, you can track all of its calls and arguments by introducing a spy. `ArgRecords<T>` is a generic class that records them. For a mock functions that contain several parameteres, `T` will become a tuple with corresponding number of items. 

> `ArgRecords` has a custom subscript function which returns `Optional<T>`. Thanks to that, subscripted value can be safely passed to `XCTAssertEqual` without crashing the app when spied functions hasn't been yet called.

#### Spy a single-argument function

```swift
// addUserSpy is ArgRecords<String> as `addUser` has a single String argument 
let addUserSpy = spyCalls(of: &databaseStub.addUserAction) 
databaseMock.addUser(name: "user1")

let callArg = addUserSpy[0] // "user1"
let callCount = addUserSpy.count // 1
```

#### Spy a multi-argument function

```swift
// addAccountSpy is ArgRecords<(String, String)> as `addAccount` has two String parameters 
let addAccountSpy = spyCalls(of: &databaseStub.addAccountAction) 
databaseMock.addAccount(givenName: "given", lastName: "last")

let callArg = addUserSpy[0] // ("given","last")
let callGivenNameArg = addUserSpy[0].0 // "given"
let callLastNameArg = addUserSpy[0].1 // "last"
```

#### Weak spy

By default, a spy keeps a strong reference to all arguments passed to the spied function. If that negatively interefers with your scenario, you can leverage weakly referenced spy:

```swift
// addSomeClassSpy is ArgWeakRecords<SomeClass> 
let addSomeClassSpy = spyWeaklyCalls(of: &databaseStub.addSomeClass) 
databaseMock.addSomeClass(SomeClass())

let callArg = addSomeClassSpy[0] // `nil`, unless some other part keeps strong reference to `SomeClass()`
let callCount = addUserSpy.count // 1
```

#### Custom spy storage

By default, spy keeps track of all arguments passed to the function. To keep only a set them, you can transform it in `transform` function, before it gets stored in a spy object. 

```swift
// addAccountGivenSpy is ArgRecords<String> as only `transform` considers only the first argument  
let addAccountSpy = spyCalls(of: &databaseStub.addAccountAction, transform: {$0.0}) 
databaseMock.addAccount(givenName: "given", lastName: "last")

let callArg = addUserSpy[0] // "given"
```

## Limitations

- Thread unsafe
- Generic functions
- Variadic functions

