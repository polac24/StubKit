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
        XCTAssertEqual(tested.notMetDescription(count: 3),"Called 3 times while expected never")
    }
    
    func testOnceAllowsOnlyOne() {
        let tested = StubExpectation.once
        
        XCTAssertFalse(tested.meets(count: 0))
        XCTAssert(tested.meets(count: 1))
        XCTAssertFalse(tested.meets(count: 3))
        XCTAssertEqual(tested.notMetDescription(count: 3),"Called 3 times while expected once")
    }
    
    func testAtLeastOnceAllowsMoreThanZero() {
        let tested = StubExpectation.atLeastOnce
        
        XCTAssertFalse(tested.meets(count: 0))
        XCTAssert(tested.meets(count: 1))
        XCTAssert(tested.meets(count: 3))
        XCTAssertEqual(tested.notMetDescription(count: 0),"Called 0 times while expected at least once")
    }
    
    func testTimesAllowsGivenNumber() {
        let tested3 = StubExpectation.times(3)
        let tested0 = StubExpectation.times(0)
        
        XCTAssert(tested3.meets(count: 3))
        XCTAssertFalse(tested3.meets(count: 2))
        XCTAssertFalse(tested3.meets(count: 4))
        
        XCTAssert(tested0.meets(count: 0))
        XCTAssertFalse(tested0.meets(count: 1))
        XCTAssertEqual(tested0.notMetDescription(count: 3),"Called 3 times while expected exactly 0")
    }
    
    func testAtLeastTimesAllowsSameAnfHigherNumber() {
        let tested = StubExpectation.atLeastTimes(3)
        
        XCTAssert(tested.meets(count: 3))
        XCTAssertFalse(tested.meets(count: 2))
        XCTAssert(tested.meets(count: 4))
        XCTAssertEqual(tested.notMetDescription(count: 2),"Called 2 times while expected at least 3 (or more)")
    }
    
    func testNoMoreThanAllowsSameAnfHigherNumber() {
        let tested = StubExpectation.noMoreThan(3)
        
        XCTAssert(tested.meets(count: 0))
        XCTAssert(tested.meets(count: 1))
        XCTAssert(tested.meets(count: 3))
        XCTAssertFalse(tested.meets(count: 4))
        XCTAssertEqual(tested.notMetDescription(count: 4),"Called 4 times while expected at maximum 3 (or less)")
    }
    
    func testDescriptionFormatsOneTimeCorrectly() {
        let tested = StubExpectation.times(3)

        XCTAssertEqual(tested.notMetDescription(count: 1),"Called 1 time while expected exactly 3")
    }

}
