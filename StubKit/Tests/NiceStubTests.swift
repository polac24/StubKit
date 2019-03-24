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

class NiceStubTests: XCTestCase {
    
    private var testMock: TestStubMock!
    
    override func setUp() {
        testMock = TestStubMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testTakeValueDoesntCrash() {
        testMock.takeValueType(MyStructGlobal())
    }
    
    func testReturnValueDoesntCrash() {
        _ = testMock.returnValueType()
    }
    
    func testtakeObjectDoesntCrash() {
        _ = testMock.takeObject(NSObject())
    }
    func testreturnObjectDoesntCrash() {
        _ = testMock.returnObject()
    }
    func testtakeValueTypeDoesntCrash() {
        _ = testMock.takeValueType(MyStructGlobal())
    }
    func testreturnValueTypeDoesntCrash() {
        _ = testMock.returnValueType()
    }
    func testtakeDefaultableValueTypeDoesntCrash() {
        _ = testMock.takeDefaultableValueType(2)
    }
    func testreturnDefautableValueTypeDoesntCrash() {
        _ = testMock.returnDefautableValueType()
    }
    func testreturnDefautableValueTypeCustomDoesntCrash() {
        XCTAssertEqual(testMock.returnDefautableValueTypeCustom(), 1)
    }
    func testtakeCustomDefaultableValueTypeDoesntCrash() {
        _ = testMock.takeCustomDefaultableValueType(DefautableStructGlobal())
    }
    func testreturnCustomDefautableValueTypeDoesntCrash() {
        _ = testMock.returnCustomDefautableValueType()
    }
    func testtakeTwoArgsDoesntCrash() {
        _ = testMock.takeTwoArgs(v1: 1, v2: "A")
    }
    func testreturnTupleDoesntCrash() {
        let tuple = testMock.returnTuple()
        XCTAssertEqual(tuple.0, 0)
        XCTAssertEqual(tuple.1, "")
    }
    func testtakeTupleNamedDoesntCrash() {
        _ = testMock.takeTupleNamed((v1: 1, v2: "B"))
    }
    func testreturnTupleNamedDoesntCrash() {
        let tuple = testMock.returnTupleNamed()
        XCTAssertEqual(tuple.v1, 0)
        XCTAssertEqual(tuple.v2, "")
    }
    func testtakeEscapingDoesntCrash() {
        _ = testMock.takeEscaping({_ in return ""})
    }
    func testtakeNonscapingDoesntCrash() {
        _ = testMock.takeNonscaping({_ in return ""})
    }
    func testreturnFunctionDoesntCrash() {
        XCTAssertEqual(testMock.returnFunction()(1), "1")
    }
    func testtakeAutoclosureStringDoesntCrash() {
        _ = testMock.takeAutoclosureString("C")
    }
    func testtakeAutoclosureStringWithOtherDoesntCrash() {
        _ = testMock.takeAutoclosureStringWithOther("D", other: "Other")
    }
}
