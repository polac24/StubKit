/*
 Copyright (c) 2019 Bartosz Polaczyk
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import XCTest
import StubKit

extension String: Error {}

class RegisterTests: XCTestCase {

    
    private var testMock: TestStrictStubMockGlobal!
    
    override func setUp() {
        testMock = TestStrictStubMockGlobal()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testRegisterVoidReturnObject() {
        testMock.takeObjectAction = registerStub(alwaysReturn: Void())
        
        // Assert
        testMock.takeObject(NSObject())
    }
    func testRegisterReturnAnyObject() {
        let obj = NSObject()
        
        testMock.returnObjectAction = registerStub(alwaysReturn: obj)
       
        XCTAssertTrue(testMock.returnObject() === obj)
    }
    
    func testRegisterReturnStruct() {
        let obj = MyStructGlobal()
        
        testMock.returnValueTypeAction = registerStub(alwaysReturn: obj)
        
        XCTAssertEqual(testMock.returnValueType(), obj)
    }
    
    func testRegisterReturnTouple() {
        
        testMock.returnTupleAction = registerStub(alwaysReturn: (1,"12"))
        
        XCTAssertEqual(testMock.returnTuple().0, 1)
        XCTAssertEqual(testMock.returnTuple().1, "12")
    }
    
    func testRegisterReturnToupleNamed() {
        
        testMock.returnTupleNamedAction = registerStub(alwaysReturn: (1,"12"))
        
        XCTAssertEqual(testMock.returnTupleNamed().0, 1)
        XCTAssertEqual(testMock.returnTupleNamed().1, "12")
    }
    
    func testRegisterReturnFunction() {
        
        testMock.returnFunctionAction = registerStub(alwaysReturn: {
            return String(describing: $0)
        })
        
        XCTAssertEqual(testMock.returnFunction()(1), "1")
    }
    
    func testRegisterReturnDefaultable() {
        
        testMock.returnDefautableValueTypeAction = registerStub()
        
        // Assert
        XCTAssertEqual(testMock.returnDefautableValueType(), 0)
    }
    
    func testRegisterTakingThrow() {
        let testMock = TestMockThrowing()
        
        testMock.takeValueTypeThrowingAction = registerStub(alwaysThrow: "Error")
        
        // Assert
        XCTAssertThrowsError(try testMock.takeValueTypeThrowing(1))
    }
    
    func testRegisterReturnThrows() {
        let testMock = TestMockThrowing()
        
        testMock.returnValueTypeThrowingAction = registerStub(alwaysThrow: "Error")
        
        // Assert
        XCTAssertThrowsError(try testMock.returnValueTypeThrowing())
    }
}

private protocol TestProtocolThrowing {
    func takeValueTypeThrowing(_ i: Int) throws
    func returnValueTypeThrowing() throws -> Int
}

private class TestMockThrowing: TestProtocolThrowing {

    lazy var takeValueTypeThrowingAction = strictStub(of: takeValueTypeThrowing)
    func takeValueTypeThrowing(_ i: Int) throws {
        return try takeValueTypeThrowingAction(i)
    }
    lazy var returnValueTypeThrowingAction = strictStub(of: returnValueTypeThrowing)
    func returnValueTypeThrowing() throws -> Int {
        return try returnValueTypeThrowingAction(())
    }
    
}
