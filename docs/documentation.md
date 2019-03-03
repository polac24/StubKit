
# StubKit API documentation

## Overview


- [API](#api)
    - [Subbing](#subbing)
- [Limitations](#limitations)

## API

### Stubbing

StubKit's term "stubbing" means that body of a protocol function has to be explicitly defined (registered) before it is ever called during test scenario. Any call to a stubbed function that hasn't been registerd crashes the test. Stubbing could be a part of strict mock implementation, where test scenario has to manually specify which functions are allowed to be called during test. 

```swift
protocol Database {
func addUser(name: String) -> Bool
}
class DatabaseMock: Database {
    lazy var addUserAction = stub(of: addUser)
    func addUser(name: String) {
    return addUserAction(name)
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

> Stubbing is very strict so it recommended to prefer nice stubbing instead.

### Nice stubbing



### Automatic nice stubbing



## Limitations

- Generic functions
- Variadic functions

