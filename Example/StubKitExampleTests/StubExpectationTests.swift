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


class StubExpectationTests: XCTestCase {

    func testNeverAllowsOnlyNone() {
        let tested = StubExpectation.never
        
        XCTAssert(tested.meets(count: 0))
        XCTAssertFalse(tested.meets(count: 1))
        XCTAssertFalse(tested.meets(count: 3))
    }
    
    func testOnceAllowsOnlyOne() {
        let tested = StubExpectation.once
        
        XCTAssertFalse(tested.meets(count: 0))
        XCTAssert(tested.meets(count: 1))
        XCTAssertFalse(tested.meets(count: 3))
    }
    
    func testAtLeastOnceAllowsMoreThanZero() {
        let tested = StubExpectation.atLeastOnce
        
        XCTAssertFalse(tested.meets(count: 0))
        XCTAssert(tested.meets(count: 1))
        XCTAssert(tested.meets(count: 3))
    }
    
    func testTimesAllowsGivenNumber() {
        let tested3 = StubExpectation.times(3)
        let tested0 = StubExpectation.times(0)
        
        XCTAssert(tested3.meets(count: 3))
        XCTAssertFalse(tested3.meets(count: 2))
        XCTAssertFalse(tested3.meets(count: 4))
        
        XCTAssert(tested0.meets(count: 0))
        XCTAssertFalse(tested0.meets(count: 1))
    }
    
    func testAtLeastTimesAllowsSameAnfHigherNumber() {
        let tested = StubExpectation.atLeastTimes(3)
        
        XCTAssert(tested.meets(count: 3))
        XCTAssertFalse(tested.meets(count: 2))
        XCTAssert(tested.meets(count: 4))
    }
    
    func testNoMoreThanAllowsSameAnfHigherNumber() {
        let tested = StubExpectation.noMoreThan(3)
        
        XCTAssert(tested.meets(count: 0))
        XCTAssert(tested.meets(count: 1))
        XCTAssert(tested.meets(count: 3))
        XCTAssertFalse(tested.meets(count: 4))
    }

}
