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

class ArgRecordsTests: XCTestCase {

    private var testMock: TestMock!
    
    override func setUp() {
        testMock = TestMock()
        testMock.takeObjectAction = registerStub()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testSpyKeepsStrongArgReference() {
        let weakArgs = spyCalls(of: &testMock.takeObjectAction)
        let scopeResult = applyWeak(NSObject()) {
            testMock.takeObject($0)
        }
        
        XCTAssertEqual(weakArgs.count, 1)
        XCTAssertNotNil(scopeResult)
    }
    
    func testReleasedArgSpy_deallocArguments() {
        let scopeResult = applyWeak(NSObject()) {
            _ = spyCalls(of: &testMock.takeObjectAction)
            testMock.takeObject($0)
        }
        
        XCTAssertNil(scopeResult)
    }
    
    func testReassignedArgSpy_deallocArguments() {
        _ = spyCalls(of: &testMock.takeObjectAction)
        let scopeResult = applyWeak(NSObject()) {
            testMock.takeObject($0)
            _ = spyCalls(of: &testMock.takeObjectAction)
        }
        XCTAssertNil(scopeResult)
    }
}

private protocol TestProtocol {
    func takeObject(_ obj:AnyObject)
}

private class TestMock: TestProtocol {
    lazy var takeObjectAction = strictStub(of: takeObject)
    func takeObject(_ obj: AnyObject) {
        return takeObjectAction(obj)
    }
}
