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

class NiceStubThrowingTests: XCTestCase {
    
    private var testMock: TestNiceStubThrowingMock!
    
    override func setUp() {
        testMock = TestNiceStubThrowingMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testTakeValueDoesntCrash() throws {
        try testMock.takeValueTypeThrowing(MyStructGlobal())
    }
    
    func testReturnValueDoesntCrash() throws {
        _ = try testMock.returnValueTypeThrowing()
    }
    
    func testtakeObjectDoesntCrash() throws {
        _ = try testMock.takeObjectThrowing(NSObject())
    }
    func testreturnObjectDoesntCrash() throws {
        _ = try testMock.returnObjectThrowing()
    }
    func testtakeValueTypeDoesntCrash() throws {
        _ = try testMock.takeValueTypeThrowing(MyStructGlobal())
    }
    func testreturnValueTypeDoesntCrash() throws {
        _ = try testMock.returnValueTypeThrowing()
    }
    func testtakeDefaultableValueTypeDoesntCrash() throws {
        _ = try testMock.takeDefaultableValueTypeThrowing(2)
    }
    func testreturnDefautableValueTypeDoesntCrash() throws {
        _ = try testMock.returnDefautableValueTypeThrowing()
    }
    func testreturnDefautableValueTypeCustomDoesntCrash() throws {
        XCTAssertEqual(try testMock.returnDefautableValueTypeCustomThrowing(), 1)
    }
    func testtakeCustomDefaultableValueTypeDoesntCrash() throws {
        _ = try testMock.takeCustomDefaultableValueTypeThrowing(DefautableStructGlobal())
    }
    func testreturnCustomDefautableValueTypeDoesntCrash() throws {
        _ = try testMock.returnCustomDefautableValueTypeThrowing()
    }
    func testtakeTwoArgsDoesntCrash() throws {
        _ = try testMock.takeTwoArgsThrowing(v1: 1, v2: "A")
    }
    func testreturnTupleDoesntCrash() throws {
        let tuple = try testMock.returnTupleThrowing()
        XCTAssertEqual(tuple.0, 0)
        XCTAssertEqual(tuple.1, "")
    }
    func testtakeTupleNamedDoesntCrash() throws {
        _ = try testMock.takeTupleNamedThrowing((v1: 1, v2: "B"))
    }
    func testreturnTupleNamedDoesntCrash() throws {
        let tuple = try testMock.returnTupleNamedThrowing()
        XCTAssertEqual(tuple.v1, 0)
        XCTAssertEqual(tuple.v2, "")
    }
    func testtakeEscapingDoesntCrash() throws {
        _ = try testMock.takeEscapingThrowing({_ in return ""})
    }
    func testtakeNonscapingDoesntCrash() throws {
        _ = try testMock.takeNonscapingThrowing({_ in return ""})
    }
    func testreturnFunctionDoesntCrash() throws {
        XCTAssertEqual(try testMock.returnFunctionThrowing()(1), "1")
    }
    func testtakeAutoclosureStringDoesntCrash() throws {
        _ = try testMock.takeAutoclosureStringThrowing("C")
    }
    func testtakeAutoclosureStringWithOtherDoesntCrash() throws {
        _ = try testMock.takeAutoclosureStringWithOtherThrowing("D", other: "Other")
    }
}

