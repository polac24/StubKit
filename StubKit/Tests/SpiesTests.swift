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

class SpiesTests: XCTestCase {

    
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
    lazy var returnsInternalAction = strictStub(of:returnsInternal)
    func returnsInternal() -> InternalType {
        return returnsInternalAction(())
    }
    
    lazy var takeObjectAction = strictStub(of: takeObject)
    func takeObject(_ obj: AnyObject) {
        return takeObjectAction(obj)
    }
    lazy var returnBoolAction = strictStub(of: returnBool)
    func returnBool() -> Bool {
        return returnBoolAction(())
    }
    lazy var returnIntAction = strictStub(of: returnInt)
    func returnInt() -> Int {
        return returnIntAction(())
    }
    
    
}
