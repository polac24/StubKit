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

class SpyCallsThrowingTests: XCTestCase {
    
    private var testMock: TestNiceStubThrowingMock!
    
    override func setUp() {
        testMock = TestNiceStubThrowingMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testTakeValueSpies() throws {
        let args = spyCalls(of: &testMock.takeValueTypeThrowingAction)
        _ = try testMock.takeValueTypeThrowing(MyStructGlobal())
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], MyStructGlobal())
    }
    
    func testReturnValueSpies() throws {
        let args = spyCalls(of: &testMock.returnValueTypeThrowingAction)
        _ = try testMock.returnValueTypeThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    
    func testtakeObjectSpies() throws {
        let obj = NSObject()
        let args = spyCalls(of: &testMock.takeObjectThrowingAction)
        _ = try testMock.takeObjectThrowing(obj)
        XCTAssertEqual(args.count, 1)
        XCTAssertTrue(args[0] === obj)
    }
    func testreturnObjectSpies() throws {
        let args = spyCalls(of: &testMock.returnObjectThrowingAction)
        _ = try testMock.returnObjectThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeValueTypeSpies() throws {
        let args = spyCalls(of: &testMock.takeValueTypeThrowingAction)
        _ = try testMock.takeValueTypeThrowing(MyStructGlobal())
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], MyStructGlobal())
    }
    func testreturnValueTypeSpies() throws {
        let args = spyCalls(of: &testMock.returnValueTypeThrowingAction)
        _ = try testMock.returnValueTypeThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeDefaultableValueTypeSpies() throws {
        let args = spyCalls(of: &testMock.takeDefaultableValueTypeThrowingAction)
        _ = try testMock.takeDefaultableValueTypeThrowing(2)
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], 2)
    }
    func testreturnDefautableValueTypeSpies() throws {
        let args = spyCalls(of: &testMock.returnDefautableValueTypeThrowingAction)
        _ = try testMock.returnDefautableValueTypeThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeCustomDefaultableValueTypeSpies() throws {
        let args = spyCalls(of: &testMock.takeCustomDefaultableValueTypeThrowingAction)
        _ = try testMock.takeCustomDefaultableValueTypeThrowing(DefautableStructGlobal())
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testreturnCustomDefautableValueTypeSpies() throws {
        let args = spyCalls(of: &testMock.returnCustomDefautableValueTypeThrowingAction)
        _ = try testMock.returnCustomDefautableValueTypeThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeTwoArgsSpies() throws {
        let args = spyCalls(of: &testMock.takeTwoArgsThrowingAction)
        _ = try testMock.takeTwoArgsThrowing(v1: 1, v2: "A")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, 1)
        XCTAssertEqual(args[0]?.1, "A")
    }
    func testreturnTupleSpies() throws {
        let args = spyCalls(of: &testMock.returnTupleThrowingAction)
        _ = try testMock.returnTupleThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeTupleNamedSpies() throws {
        let args = spyCalls(of: &testMock.takeTupleNamedThrowingAction)
        _ = try testMock.takeTupleNamedThrowing((v1: 1, v2: "B"))
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, 1)
        XCTAssertEqual(args[0]?.1, "B")
    }
    func testreturnTupleNamedSpies() throws {
        let args = spyCalls(of: &testMock.returnTupleNamedThrowingAction)
        _ = try testMock.returnTupleNamedThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeEscapingSpies() throws {
        let args = spyCalls(of: &testMock.takeEscapingThrowingAction)
        _ = try testMock.takeEscapingThrowing({_ in return "P"})
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?(0), "P")
    }
    func testtakeNonscapingSpies() throws {
        let args = spyCalls(of: &testMock.takeNonscapingThrowingAction, transform: {($0(1), $0(2))})
        _ = try testMock.takeNonscapingThrowing({"\($0)"})
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, "1")
        XCTAssertEqual(args[0]?.1, "2")
    }
    func testreturnFunctionSpies() throws {
        let args = spyCalls(of: &testMock.returnFunctionThrowingAction)
        _ = try testMock.returnFunctionThrowing()
        XCTAssertEqual(args.count, 1)
        XCTAssertNotNil(args[0])
    }
    func testtakeAutoclosureStringSpies() throws {
        let args = spyCalls(of: &testMock.takeAutoclosureStringThrowingAction)
        _ = try testMock.takeAutoclosureStringThrowing("C")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0], "C")
    }
    func testtakeAutoclosureStringWithOtherSpiesAllowsToSpyNonAutoclosure() throws {
        let args = spyCalls(of: &testMock.takeAutoclosureStringWithOtherThrowingAction)
        _ = try testMock.takeAutoclosureStringWithOtherThrowing("D", other: "Other")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.1, "Other")
    }
    func x_testtakeAutoclosureStringWithOtherSpiesAllowsToSpyAutoclosure() throws {
        let args = spyCalls(of: &testMock.takeAutoclosureStringWithOtherThrowingAction)
        _ = try testMock.takeAutoclosureStringWithOtherThrowing("D", other: "Other")
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0(), "D") // Prohibited, see SR-9991
    }
}

