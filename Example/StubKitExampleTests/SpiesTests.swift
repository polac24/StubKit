import XCTest
import StubKit

class SpiesTests: XCTestCase {
    
    
    func testWeakSpyDoesntKeepStrongArgReference() {
        let testMock = TestMock()
        testMock.takeObjectAction = registerStub()
        let weakArgs = spyWeaklyCalls(of: &testMock.takeObjectAction)
        weak var argWeakReference: AnyObject?
        do {
            let object = NSObject()
            argWeakReference = object
            testMock.takeObject(object)
        }
        XCTAssertEqual(weakArgs.count, 1)
        XCTAssertNil(argWeakReference)
    }
    
    func testSpyKeepsStrongArgReference() {
        let testMock = TestMock()
        testMock.takeObjectAction = registerStub()
        let weakArgs = spyCalls(of: &testMock.takeObjectAction)
        weak var argWeakReference: AnyObject?
        do {
            let object = NSObject()
            argWeakReference = object
            testMock.takeObject(object)
        }
        XCTAssertEqual(weakArgs.count, 1)
        XCTAssertNotNil(argWeakReference)
    }
    
    func testNiceConformance() {
        let testMock = TestMock()
        testMock.returnBoolAction = registerStub()
        
        XCTAssertFalse(testMock.returnBool())
    }
    func testNiceIntConformance() {
        let testMock = TestMock()
        testMock.returnIntAction = registerStub()
        
        XCTAssertEqual(testMock.returnInt(), 0)
    }
    
    func testDefaultableRegister_allowsToSpecifyCustomReturn() {
        let testMock = TestMock()
        testMock.returnIntAction = registerStub(alwaysReturn: 1)
        
        XCTAssertEqual(testMock.returnInt(), 1)
    }
    
    func testInternalConformanceToDefaultable() {
        let testMock = TestMock()
        testMock.returnsInternalAction = registerStub()
    }
    
}

private protocol TestProtocol {
    func takeObject(_ obj:AnyObject)
    func returnsInternal() -> InternalType
    func returnBool()->Bool
    func returnInt()->Int
}

struct InternalType: DefaultProvidable {
    static var defaultValue =  InternalType()
}

private class TestMock: TestProtocol {
    lazy var returnsInternalAction = stub(of:returnsInternal)
    func returnsInternal() -> InternalType {
        return returnsInternalAction(())
    }
    
    lazy var takeObjectAction = stub(of: takeObject)
    func takeObject(_ obj: AnyObject) {
        return takeObjectAction(obj)
    }
    lazy var returnBoolAction = stub(of: returnBool)
    func returnBool() -> Bool {
        return returnBoolAction(())
    }
    lazy var returnIntAction = stub(of: returnInt)
    func returnInt() -> Int {
        return returnIntAction(())
    }
    
    
}
