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

class SequenceCallbacksTests: XCTestCase {
    
    private var testMock: TestStubMock!
    
    override func setUp() {
        testMock = TestStubMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testCallbackIsCalledForNonFilteredSequence() {
        var callbackArgs:[Int] = []
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction)
            .callback({
                callbackArgs.append($0)
            })
        
        _ = testMock.takeAndReturnDefautableValueType(1)
        _ = testMock.takeAndReturnDefautableValueType(2)
        _ = testMock.takeAndReturnDefautableValueType(3)
        
        XCTAssertEqual(callbackArgs, [1,2,3])
    }
    
    func testCallbackIsCalledForFilteredSequence() {
        var callbackArgs:[String] = []
        setupStubSequence(of: &testMock.takeTwoArgsAction)
            .whenFirst(1)
            .whenSecond("v3")
            .callback({
                callbackArgs.append($0.1)
            })
        
        _ = testMock.takeTwoArgs(v1: 1, v2: "v1")
        _ = testMock.takeTwoArgs(v1: 2, v2: "v2")
        _ = testMock.takeTwoArgs(v1: 1, v2: "v3")

        XCTAssertEqual(callbackArgs, ["v3"])
    }
    
    func testCallbackIsCalledForThrowingSequence() throws {
        let throwingMock = TestStubThrowingMock()
        var callbackArgs:[Int] = []
        setupStubSequence(of: &throwingMock.takeDefaultableValueTypeThrowingAction)
            .callback({
                callbackArgs.append($0)
            })
        
        _ = try throwingMock.takeDefaultableValueTypeThrowing(1)
        _ = try throwingMock.takeDefaultableValueTypeThrowing(2)
        _ = try throwingMock.takeDefaultableValueTypeThrowing(3)
        
        XCTAssertEqual(callbackArgs, [1,2,3])
    }
    
    func testCallbackIsCalledForThrownSequence() throws {
        let throwingMock = TestStubThrowingMock()
        var callbackArgs:[Int] = []
        setupStubSequence(of: &throwingMock.takeDefaultableValueTypeThrowingAction)
            .callback({
                callbackArgs.append($0)
            })
            .throws("Error")
        
        _ = try? throwingMock.takeDefaultableValueTypeThrowing(1)
        _ = try? throwingMock.takeDefaultableValueTypeThrowing(2)
        _ = try? throwingMock.takeDefaultableValueTypeThrowing(3)
        
        XCTAssertEqual(callbackArgs, [1,2,3])
    }
    
    func testA(){
        var s:((String) -> Void) = {_ in }
        setupStubSequence(of: &s)
            .callback {
                print("Add user: \($0)")
            }
        
        setupStubSequence(of: &s)
            .when("user2")
            .callback {_ in
                print("User 2 added")
            }
        
        
        s( "user1") // prints "Add user: user1"
        s( "user2") // prints "Add user: user1" and "User 2 added"
    }

}
