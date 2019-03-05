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

class RegisterSequenceTests: XCTestCase {
    
    
    private var testMock: TestStubMock!
    private var testThrowingMock: TestStubThrowingMock!

    
    override func setUp() {
        testMock = TestStubMock()
        testThrowingMock = TestStubThrowingMock()
    }
    
    override func tearDown() {
        testMock = nil
        testThrowingMock = nil
    }
    
    func testRegisterSequence() {
        registerStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .andReturn(0)
            .andReturn(1)
            .andReturn(2)
        
        let returns = Array(0..<3).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [0,1,2])
    }
    
    func testRegisterSequenceWithEndlessReturn() {
        registerStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .andReturn(0)
            .andReturn(1)
            .andReturn(2)
            .andReturnLater(3)
        
        let returns = Array(0..<5).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    func testRegisterSequenceWithEndlessReturnAppended() {
        registerStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .andReturn(0)
            .andReturn(1)
            .andReturn(2)
            .andReturnLater(3)
            .andReturn(4)
        
        let returns = Array(0..<5).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    
    func testRegisterSequenceCallsStandardWhenRunOut() {
        testMock.returnDefautableValueTypeAction = registerStub(alwaysReturn: 10)
        registerStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .andReturn(-1)
            .andReturn(-2)
        
        let returns = Array(0..<3).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [-1,-2,10])
    }
    
    func testRegisterThrowingSequence() throws {
        registerStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .andReturn(0)
            .andReturn(1)
            .andReturn(2)
        
        let returns = try Array(0..<3).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,1,2])
    }
    
    func testRegisterThrowingSequenceThrows() {
        registerStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .andReturn(1)
            .andThrow("Throw")
            .andThrow("Throw2")
        
        let returns = Array(0..<3).map({_ in try? testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [1,nil,nil])
    }
    
    func testRegisterThrowingSequenceWithEndlessReturn() throws {
        registerStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .andReturn(0)
            .andReturn(1)
            .andReturn(2)
            .andReturnLater(3)
        
        let returns = try Array(0..<5).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    func testRegisterThrowingSequenceWithEndlessReturnAppended() throws {
        registerStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .andReturn(0)
            .andReturn(1)
            .andReturn(2)
            .andReturnLater(3)
            .andReturn(4)
        
        let returns = try Array(0..<5).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    
    func testRegisterThrowingSequenceWithEndlessThrowAppended() {
        registerStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .andReturn(0)
            .andThrowLater("Throw")
        
        let returns = Array(0..<3).map({_ in try? testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,nil,nil])
    }
    
    func testRegisterThrowingSequenceCallsStandardWhenRunOut() {
        testThrowingMock.returnDefautableValueTypeThrowingAction = registerStub(alwaysReturn: 10)
        registerStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .andReturn(-1)
            .andThrow("Throw")
        
        let returns = Array(0..<3).map({_ in try? testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [-1,nil,10])
    }
}

