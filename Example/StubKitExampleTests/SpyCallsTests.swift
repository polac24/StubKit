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

class SpyCallsTests: XCTestCase {
    
    private var testMock: TestNiceStubMock!
    
    override func setUp() {
        testMock = TestNiceStubMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testTakeValueSpies() {
        let args = spyCalls(of: &testMock.takeValueTypeAction)
        _ = testMock.takeValueType(MyStructGlobal())
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], MyStructGlobal())
    }
    
    func testReturnValueSpies() {
        let args = spyCalls(of: &testMock.returnValueTypeAction)
        _ = testMock.returnValueType()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    
    func testtakeObjectSpies() {
        let obj = NSObject()
        let args = spyCalls(of: &testMock.takeObjectAction)
        _ = testMock.takeObject(obj)
        XCTAssertEqual(args.count, 1)
        XCTAssertTrue(args[0] === obj)
    }
    func testreturnObjectSpies() {
        let args = spyCalls(of: &testMock.returnObjectAction)
        _ = testMock.returnObject()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeValueTypeSpies() {
        let args = spyCalls(of: &testMock.takeValueTypeAction)
        _ = testMock.takeValueType(MyStructGlobal())
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], MyStructGlobal())
    }
    func testreturnValueTypeSpies() {
        let args = spyCalls(of: &testMock.returnValueTypeAction)
        _ = testMock.returnValueType()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeDefaultableValueTypeSpies() {
        let args = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        _ = testMock.takeDefaultableValueType(2)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], 2)
    }
    func testreturnDefautableValueTypeSpies() {
        let args = spyCalls(of: &testMock.returnDefautableValueTypeAction)
        _ = testMock.returnDefautableValueType()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeCustomDefaultableValueTypeSpies() {
        let args = spyCalls(of: &testMock.takeCustomDefaultableValueTypeAction)
        _ = testMock.takeCustomDefaultableValueType(DefautableStructGlobal())
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testreturnCustomDefautableValueTypeSpies() {
        let args = spyCalls(of: &testMock.returnCustomDefautableValueTypeAction)
        _ = testMock.returnCustomDefautableValueType()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeTwoArgsSpies() {
        let args = spyCalls(of: &testMock.takeTwoArgsAction)
        _ = testMock.takeTwoArgs(v1: 1, v2: "A")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, 1)
        XCTAssertEqual(args[0]?.1, "A")
    }
    func testreturnTupleSpies() {
        let args = spyCalls(of: &testMock.returnTupleAction)
        _ = testMock.returnTuple()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeTupleNamedSpies() {
        let args = spyCalls(of: &testMock.takeTupleNamedAction)
        _ = testMock.takeTupleNamed((v1: 1, v2: "B"))
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, 1)
        XCTAssertEqual(args[0]?.1, "B")
    }
    func testreturnTupleNamedSpies() {
        let args = spyCalls(of: &testMock.returnTupleNamedAction)
        _ = testMock.returnTupleNamed()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeEscapingSpies() {
        let args = spyCalls(of: &testMock.takeEscapingAction)
        _ = testMock.takeEscaping({_ in return "P"})
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?(0), "P")
    }
    
    func testtakeTwoEscapingSpies() {
        let args = spyCalls(of: &testMock.takeTwoEscapingAction)
        _ = testMock.takeTwoEscaping({_ in return "P"}, {_ in 1} )
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0(1), "P")
        XCTAssertEqual(args[0]?.1("1"), 1)
    }
    
    func testtakeNonscapingSpies() {
        let args = spyCalls(of: &testMock.takeNonscapingAction, transform: {($0(1),$0(2))})
        _ = testMock.takeNonscaping({return "\($0)"})
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, "1")
        XCTAssertEqual(args[0]?.1, "2")
    }
    func testreturnFunctionSpies() {
        let args = spyCalls(of: &testMock.returnFunctionAction)
        _ = testMock.returnFunction()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeAutoclosureStringSpies() {
        let args = spyCalls(of: &testMock.takeAutoclosureStringAction)
        _ = testMock.takeAutoclosureString("C")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], "C")
    }
    func testtakeAutoclosureStringWithOtherSpiesAllowsToSpyNonAutoclosure() {
        let args = spyCalls(of: &testMock.takeAutoclosureStringWithOtherAction)
        _ = testMock.takeAutoclosureStringWithOther("D", other: "Other")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.1, "Other")
    }
    func testtakeAutoclosureStringWithOtherSpiesAllowsToSpyAutoclosure() {
        let args = spyCalls(of: &testMock.takeAutoclosureStringWithOtherAction, transform: {($0.0(),$0.1)})
        _ = testMock.takeAutoclosureStringWithOther("D", other: "Other")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, "D")
        XCTAssertEqual(args[0]?.1, "Other")
    }
}

