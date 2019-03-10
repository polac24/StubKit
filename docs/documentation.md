
# StubKit API documentation

## Overview

- [Overview](#overview)
- [API](#api)
  * [Stubbing](#stubbing)
  * [Stub return value](#stub-return-value)
    + [Automatic return value](#automatic-return-value)
    + [Manual return type](#manual-return-type)
    + [Manual throwing](#manual-throwing)
  * [Setup](#setup)
    + [Standard setup](#standard-setup)
    + [Sequence setup](#sequence-setup)
    + [Selective setup](#selective-setup)
  * [Strict Stubbing](#strict-stubbing)
    + [Ambigious functions stub](#ambigious-functions-stub)
    + [Registration](#registration)
      - [Automatic registration](#automatic-registration)
      - [Manual registration with custom body](#manual-registration-with-custom-body)
  * [Argument verification](#argument-verification)
    + [Spy recorder](#spy-recorder)
      - [Spy a single-argument function](#spy-a-single-argument-function)
      - [Spy a multi-argument function](#spy-a-multi-argument-function)
      - [Weak spy](#weak-spy)
      - [Custom spy storage](#custom-spy-storage)
    + [Sequence verification](#sequence-verification)
- [Stubbing hints](#stubbing-hints)
  * [`@autoclosure`](#--autoclosure-)
  * [`@escaping`](#--escaping-)
  * [non-escaping arguments](#non-escaping-arguments)
  * [throwing function](#throwing-function)
  * [throwing function argument](#throwing-function-argument)
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

```swift
class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser, alwaysReturn: true)
    func addUser(name: String) -> Bool {
        return addUserAction(name)
    }
}
```

#### Manual throwing

You can customize your stub behaviour to always throw a specific error as:

```swift
class DatabaseMock: Database {
    lazy var addUserThrowingAction = stub(of: addUser, alwaysThrow: DatabaseError())
    func addUserThrowing(name: String) throws -> Bool {
        return addUserAction(name)
    }
}
```

### Setup
Using registration (for `strictStub`) and standard (nice) `stub` your function will always return the same value unilt you reregistere it with a new value. Although registrating the stub again sounds like a problem solver, keep in mind that all the assigned spies would then be unattached and skip spying arguments. Therefore StupKit provides a setup feature that can dynamically configures return value of a function without reregistration.


#### Standard setup

```swift
protocol Database {
    func addAccount(givenName: String, lastName: String) -> Int
}
class DatabaseMock: Database {
    lazy var addAccountAction = stub(of: addAccount)
    func addAccount(givenName: String, lastName: String) -> Int {
        return addAccountAction(name)
    }
}


/// Testcase body

// default behaviour
databaseMock.addAccount(givenName: "John", lastName: "Appleseed") // 0

// custom return value
setupStub(of: &databaseMock.addAccountAction, return: 1)
databaseMock.addAccount(givenName: "John", lastName: "Appleseed") // 1

// override return value
setupStub(of: &databaseMock.addAccountAction, return: 2)
databaseMock.addAccount(givenName: "John", lastName: "Appleseed") // 2
```

#### Sequence setup

Besides standard setup that specifies return value for all calls, sequence setup can specify custom return values for a single call (`returnsOnce`/`throwsOnce`) or all subsequente calls (`returns`/`throws`):

```swift
// custom return value
setupStubSequence(of: &databaseMock.addAccountAction)
    .returnsOnce(1) // 1
    .returnsOnce(2) // 2
    .returnsOnce(3) // 3
    .returns(0) // 4+
    
databaseMock.addAccount(givenName: "John", lastName: "Appleseed1") // 1
databaseMock.addAccount(givenName: "John", lastName: "Appleseed2") // 2
databaseMock.addAccount(givenName: "John", lastName: "Appleseed3") // 3
databaseMock.addAccount(givenName: "John", lastName: "Appleseed4") // 0 
databaseMock.addAccount(givenName: "John", lastName: "Appleseed5")) // 0
```

> If you don't end up stub sequence with infinite return, previous setup value has a precedance

```swift
setupStubSequence(of: &databaseMock.addAccountAction).returns(-1) // 2+
setupStubSequence(of: &databaseMock.addAccountAction)
    .returnsOnce(1) // 1
    .returnsOnce(2) // 1

databaseMock.addAccount(givenName: "John", lastName: "Appleseed") // 1
databaseMock.addAccount(givenName: "John", lastName: "Appleseed") // 2
databaseMock.addAccount(givenName: "John", lastName: "Appleseed") // -1
```


#### Selective setup

Setup can selectively return custom values, depending on call arguments. You can predicate selecting from 
* predicate 
* single-argument comparison (for `Equatable` types)
* selective argument comparison - support for functions with less than 5 arguments (e.g. `whenFirst`, `whenForth`)

```swift 
setupStubSequence(of: &databaseMock.addUserAction)
    .when("user1")
    .returns(false)
setupStubSequence(of: &databaseMock.addUserAction)
    .when("user2")
    .andReturn(true)

databaseMock.addUser(name: "user1") // false
databaseMock.addUser(name: "user2") // true
```

```swift 
setupStubSequence(of: &databaseMock.addUserAction)
    .when({$0.count > 0})
    .returns(true)

databaseMock.addUser(name: "") //  false
databaseMock.addUser(name: "user2") // true
```

```swift 
protocol Database {
    func addAccount(givenName: String, lastName: String) -> Int
}

setupStubSequence(of: &databaseMock.addAccountAction)
    .whenFirst("Tom")
    .returns(1)
    
setupStubSequence(of: &databaseMock.addAccountAction)
    .whenFirst("Derk")
    .returns(10)
    
setupStubSequence(of: &databaseMock.addAccountAction)
    .whenFirst("Tom")
    .whenFirst("Derk")
    .returns(100)

databaseMock.addUser(givenName: "Tom", lastName: "Kerk") //  1
databaseMock.addUser(givenName: "Ole", lastName: "Derk") // 10
databaseMock.addUser(givenName: "Ole", lastName: "De") // 0
databaseMock.addUser(givenName: "Tom", lastName: "Derk") // 100 - Last setup has a predecence
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
```

> Strict stubbing is very restrictive so it recommended to prefer standard stubbing instead.

#### Ambigious functions stub

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

### Argument verification 

#### Spy recorder

Once you have mock ready, you can track all of its calls and arguments by introducing a spy. `ArgRecords<T>` is a generic class that records them. For a mock functions that contain several parameteres, `T` will become a tuple with corresponding number of items. 

> `ArgRecords` has a custom subscript function which returns `Optional<T>`. Thanks to that, subscripted value can be safely passed to `XCTAssertEqual` without crashing the app when spied functions hasn't been yet called.

##### Spy a single-argument function

```swift
// addUserSpy is ArgRecords<String> as `addUser` has a single String argument 
let addUserSpy = spyCalls(of: &databaseStub.addUserAction) 
databaseMock.addUser(name: "user1")

let callArg = addUserSpy[0] // "user1"
let callCount = addUserSpy.count // 1
```

##### Spy a multi-argument function

```swift
// addAccountSpy is ArgRecords<(String, String)> as `addAccount` has two String parameters 
let addAccountSpy = spyCalls(of: &databaseStub.addAccountAction) 
databaseMock.addAccount(givenName: "given", lastName: "last")

let callArg = addUserSpy[0] // ("given","last")
let callGivenNameArg = addUserSpy[0].0 // "given"
let callLastNameArg = addUserSpy[0].1 // "last"
```

##### Weak spy

By default, a spy keeps a strong reference to all arguments passed to the spied function. If that negatively interefers with your scenario, you can leverage weakly referenced spy:

```swift
// addSomeClassSpy is ArgWeakRecords<SomeClass> 
let addSomeClassSpy = spyWeaklyCalls(of: &databaseStub.addSomeClass) 
databaseMock.addSomeClass(SomeClass())

let callArg = addSomeClassSpy[0] // `nil`, unless some other part keeps strong reference to `SomeClass()`
let callCount = addUserSpy.count // 1
```

##### Custom spy storage

By default, spy keeps track of all arguments passed to the function. To keep only a set them, you can transform it in `transform` function, before it gets stored in a spy object. 

```swift
// addAccountGivenSpy is ArgRecords<String> as only `transform` considers only the first argument  
let addAccountSpy = spyCalls(of: &databaseStub.addAccountAction, transform: {$0.0}) 
databaseMock.addAccount(givenName: "given", lastName: "last")

let callArg = addUserSpy[0] // "given"
```

#### Sequence verification

Setup sequences also can be used for expected arguments verification. 

> Keep in mind that all the **expected** sequences have to be verified by `XCTAssert` or `sequence.verify()`. Deallocation of non-verified sequence is treated as a programmer error and leads to an assertion.

```swift

let tomSequence = setupStubSequence(of: &databaseMock.addAccountAction)
    .whenFirst("Tom")
    .returns(1)
    .expect(.once)
    
    
let derkSequence = setupStubSequence(of: &databaseMock.addAccountAction)
    .whenSecond("Derk")
    .expect(.once)
    
let tomDerkSequence = setupStubSequence(of: &databaseMock.addAccountAction)
    .whenFirst("Tom")
    .whenSecond("Derk")
    .expect(.once)
    
let notVerifiedSequence = setupStubSequence(of: &databaseMock.addAccountAction)
    .expect(.never)
    
databaseMock.addUser(givenName: "Tom", lastName: "On")
databaseMock.addUser(givenName: "John", lastName: "Derk")

XCTAssert(tomSequence) // ✅
XCTAssertTrue(tomSequence.verify()) // Equivalent to above call
XCTAssert(derkSequence) // ✅
XCTAssert(tomDerkSequence) // 🛑 - "Sequence expectation not met: Called 0 times while expected once"
XCTAssertNotMet(tomDerkSequence) // ✅

💥 // notVerifiedSequence has not been verified
```

## Stubbing hints

### `@autoclosure`

> Support for @autoclosure in Swift 5.0 will change so this documentation is a subject to change

```swift
protocol Database {
    func addUser(name: @autoclosure () -> String)
}
class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser)
    func addUser(name: @autoclosure () -> String) {
        return addUserAction(name())
    }
}
```

### `@escaping`

Stubbing and spying the function with @escaping argument is really straitforward

```swift
protocol Database {
    func addUser(completion: @escaping (Bool) -> ())
}
class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser)
    func addUser(completion: @escaping (Bool) -> ()) {
        return addUserAction(name)
    }
}
```

### non-escaping arguments

Working with non-escaping functions has some limitations. Because swift opitmization assumes that closure won't be used out of a lifetime of a function's call, you have to manually guarantee that you will obey that restriction by wrapping the non-escping function call by `withoutActuallyEscaping` and **never** save it to the storage when spying:

```swift
protocol Database {
    func enumerateUsers(enumeration: (User) -> ())
}
class DatabaseMock: Database {
    lazy var enumerateUsersAction = stub(of: enumerateUsers)
    func enumerateUsers(enumeration: (User) -> ()) {
        return withoutActuallyEscaping(f) {
            enumerateUsersAction($0)
        }
    }
}

let enumerateUsers = spyCalls(of: &databaseStub.enumerateUsersAction, transform: { $0(User()) }) 
databaseMock.enumerateUsers { user in 
    // use user
}

let callCount = enumerateUsers.count // 1
```

### throwing function

To implement body of a protocol's function that can throw, you just need to prefix a call to an action with `try`

```swift
protocol Database {
    func addUser(name: String) throws
}
class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser)
    func addUser(name: String) throws {
        return try addUserAction(name)
    }
}
```

### throwing function argument 

For argument functions that may throw, no additional keyword is needed:

```swift
protocol Database {
    func addUser(completion: @escaping (Bool) throws -> ())
}
class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser)
    func addUser(completion: @escaping (Bool) throws -> ()) {
        return addUserAction(name)
    }
}
```

## Limitations

- Thread unsafe
- Generic functions
- Variadic functions

