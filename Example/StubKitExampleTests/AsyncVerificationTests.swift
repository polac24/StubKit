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

class AsyncVerificationTests: XCTestCase {
    
    private var testMock: TestStubMock!
    private let timeout = 0.1
    
    override func setUp() {
        testMock = TestStubMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testCallbackExpectationIsCalledEachTimeItMatchesPredicate () {
        var function: ((Int) -> Void) = {_ in}
        let twoExpecation = expectation(description: "Called with 2")
        twoExpecation.expectedFulfillmentCount = 2
        setupStubSequence(of: &function).when(2).callback(twoExpecation)
        
        DispatchQueue.global(qos: .userInitiated).async {
            function(1)
            function(2)
            function(3)
            function(2)
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testAttachedExpectationIsCalledOnceWhenFulfilled () {
        var function: ((Int) -> Void) = {_ in}
        let twoExpecation = expectation(description: "First called with 2")
        setupStubSequence(of: &function).when(2).expect(.once).attach(twoExpecation)
        
        DispatchQueue.global(qos: .userInitiated).async {
            function(1)
            function(2)
            function(2)
            function(3)
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    func testAttachedExpectationIsCalledOnlyOnceWhenFirstlyFulfilled () {
        var function: ((Int) -> Void) = {_ in}
        let twoExpecation = expectation(description: "First called with 2")
        setupStubSequence(of: &function).when(2).expect(.once).attach(twoExpecation)
        
        function(2)
        function(2)
        
        waitForExpectations(timeout: timeout)
    }
    
    func testAttachedExpectationIsCalledWhenControlsReturn () {
        var function: ((Int) -> Void) = {_ in}
        let twoExpecation = expectation(description: "First called with 2")
        setupStubSequence(of: &function).when(2).returns(Void()).expect(.once).attach(twoExpecation)
        
        function(2)
        function(2)
        
        waitForExpectations(timeout: timeout)
    }
    
    func testAttachedExpectationIsCalledImmediatellyWhenAlreadyMeetsExpectation () {
        var function: ((Int) -> Void) = {_ in}
        let twoExpecation = expectation(description: "First called with 2")
        let sequence = setupStubSequence(of: &function).expect(.once)
        
        function(2)
        
        sequence.attach(twoExpecation)
        
        waitForExpectations(timeout: timeout)
    }
    
    func testCallbackExpectationIsCalledForThrowing () {
        var function: ((Int) throws -> Void) = {_ in}
        let twoExpecation = expectation(description: "Called with 2")
        let oneExpecation = expectation(description: "Called with 1")

        setupStubSequence(of: &function).when(2).expect(.times(2)).attach(twoExpecation)
        setupStubSequence(of: &function).when(1).throws("Err").expect(.once).attach(oneExpecation)

        
        DispatchQueue.global(qos: .userInitiated).async {
            try? function(1)
            try? function(2)
            try? function(3)
            try? function(2)
        }
        
        waitForExpectations(timeout: timeout)
    }
}
