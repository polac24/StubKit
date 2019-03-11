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

class VerifyTests: XCTestCase {

    
    func testVerificationCanBePararel() {
        var function: ((Int) -> Void) = {_ in}
        let token = setupStubSequence(of: &function).when(1).expect(.once)
        let tokenDuplicate = setupStubSequence(of: &function).when(1).expect(.once)

        function(1)
        
        XCTAssert(token.verify())
        XCTAssert(tokenDuplicate.verify())
    }
    
    func testVerificationOneArgumentFunction() {
        var function: ((Int) -> Void) = {_ in}
        let tokenOnce = setupStubSequence(of: &function).when(1).expect(.once)

        function(1)
        
        XCTAssert(tokenOnce.verify())
    }
    
    func testVerificationFailsForNonMatchingCall() {
        var function: ((Int) -> Void) = {_ in}
        let tokenOnce = setupStubSequence(of: &function).when(1).expect(.once)
        
        function(0)
        
        XCTAssertFalse(tokenOnce.verify())
    }
    
    func testVerificationNonFirstCall() {
        var function: ((Int) -> Void) = {_ in}
        let tokenOnce = setupStubSequence(of: &function).when(1).expect(.once)
        
        function(0)
        function(1)
        
        XCTAssert(tokenOnce.verify())
    }
    
    func testVerificationWithReturn() {
        var function: ((Int) -> Int) = {_ in return 0}
        let tokenOnce = setupStubSequence(of: &function).when(1).returns(2).expect(.once)
        
        let returnValue = function(1)
        
        XCTAssertEqual(returnValue, 2)
        XCTAssert(tokenOnce.verify())
    }
    
    func testVerificationWithoutReturn() {
        var function: ((Int) -> Int) = {_ in return 0}
        let tokenOnce = setupStubSequence(of: &function).when(1).expect(.once)
        
        let returnValue = function(1)
        
        XCTAssertEqual(returnValue, 0)
        XCTAssert(tokenOnce.verify())
    }
    
    func testAssertion() {
        var function: ((()) -> Void) = {_ in }
        let tokenOnce = setupStubSequence(of: &function).expect(.once)
        
        function(())
        
        SKTVerify(tokenOnce)
    }
    
    func testVerificationWorksForThrowingSequences() throws {
        var function: ((Int) throws -> Void) = {_ in}
        let token = setupStubSequence(of: &function).when(1).expect(.once)
        
        try? function(1)
        
        XCTAssert(token.verify())
    }
    
    func testVerificationWorksForThrowingOtherSetup() throws {
        var function: ((Int) throws -> Void) = {_ in}
        let token = setupStubSequence(of: &function).when(1).expect(.once)
        let tokenDuplicate = setupStubSequence(of: &function).when(1).throws("").expect(.once)
        
        try? function(1)
        
        XCTAssert(token.verify())
        XCTAssert(tokenDuplicate.verify())
    }
}
