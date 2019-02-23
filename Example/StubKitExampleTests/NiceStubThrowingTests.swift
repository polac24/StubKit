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
        _ = try testMock.takeAutoclosureStringThrowing("D")
    }
}


private class TestNiceStubThrowingMock: TestProtocolGlobalThrowing {
    
    lazy var takeValueTypeAction = niceStub(of: takeValueTypeThrowing)
    lazy var takeValueTypeActionCustom = niceStub(of: takeValueTypeThrowing, alwaysReturn: Void())
    func takeValueTypeThrowing(_ myStruct: MyStructGlobal) throws {
        return try takeValueTypeAction(myStruct)
    }
    
    lazy var returnValueTypeAction = niceStub(of: returnValueTypeThrowing, alwaysReturn: MyStructGlobal())
    func returnValueTypeThrowing() throws -> MyStructGlobal {
        return try returnValueTypeAction(())
    }
    lazy var takeCustomDefaultableValueTypeAction = niceStub(of: takeCustomDefaultableValueTypeThrowing)
    lazy var takeCustomDefaultableValueTypeActionCustom = niceStub(of: takeCustomDefaultableValueTypeThrowing, alwaysReturn: Void())
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStructGlobal) throws {
        return try takeCustomDefaultableValueTypeAction(number)
    }
    lazy var returnCustomDefautableValueTypeAction = niceStub(of: returnCustomDefautableValueTypeThrowing)
    lazy var returnCustomDefautableValueTypeActionCustom = niceStub(of: returnCustomDefautableValueTypeThrowing, alwaysReturn: DefautableStructGlobal())
    func returnCustomDefautableValueTypeThrowing() throws -> DefautableStructGlobal {
        return try returnCustomDefautableValueTypeAction(())
    }
    
    lazy var returnObjectAction = niceStub(of: returnObjectThrowing, alwaysReturn: NSObject())
    func returnObjectThrowing() throws -> AnyObject {
        return try returnObjectAction(())
    }
    
    lazy var takeDefaultableValueTypeAction = niceStub(of: takeDefaultableValueTypeThrowing)
    lazy var takeDefaultableValueTypeActionCustom = niceStub(of: takeDefaultableValueTypeThrowing, alwaysReturn: Void())
    func takeDefaultableValueTypeThrowing(_ number: Int) throws {
        try takeDefaultableValueTypeAction(number)
    }
    
    lazy var returnDefautableValueTypeAction = niceStub(of: returnDefautableValueTypeThrowing)
    lazy var returnDefautableValueTypeActionCustom = niceStub(of: returnDefautableValueTypeThrowing, alwaysReturn: 1)
    func returnDefautableValueTypeThrowing() throws -> Int {
        return try returnDefautableValueTypeAction(())
    }
    func returnDefautableValueTypeCustomThrowing() throws -> Int {
        return try returnDefautableValueTypeActionCustom(())
    }
    lazy var takeTwoArgsAction = niceStub(of: takeTwoArgsThrowing)
    lazy var takeTwoArgsActionCustom = niceStub(of: takeTwoArgsThrowing, alwaysReturn: Void())
    func takeTwoArgsThrowing(v1: Int, v2: String) throws {
        return try takeTwoArgsAction((v1, v2))
    }
    lazy var returnTupleAction = niceStub(of: returnTupleThrowing, alwaysReturn: (0,""))
    func returnTupleThrowing() throws -> (Int, String) {
        return try returnTupleAction(())
    }
    lazy var takeTupleNamedAction = niceStub(of: takeTupleNamedThrowing)
    lazy var takeTupleNamedActionCustom = niceStub(of: takeTupleNamedThrowing, alwaysReturn: Void())
    func takeTupleNamedThrowing(_ tuple: (v1: Int, v2: String)) throws {
        return try takeTupleNamedAction(tuple)
    }
    lazy var returnTupleNamedAction = niceStub(of: returnTupleNamedThrowing, alwaysReturn: (0,""))
    func returnTupleNamedThrowing() throws -> (v1: Int, v2: String) {
        return try returnTupleNamedAction(())
    }
    lazy var takeEscapingAction = niceStub(of: takeEscapingThrowing)
    lazy var takeEscapingActionCustom = niceStub(of: takeEscapingThrowing, alwaysReturn: Void())
    func takeEscapingThrowing(_ f: @escaping (Int) -> (String)) throws {
        return try takeEscapingAction(f)
    }
    lazy var takeNonscapingAction = niceStub(of: takeNonscapingThrowing)
    lazy var takeNonscapingActionCustom = niceStub(of: takeNonscapingThrowing, alwaysReturn: Void())
    func takeNonscapingThrowing(_ f: (Int) -> (String)) throws {
        return try withoutActuallyEscaping(f) { try takeNonscapingAction($0)}
    }
    lazy var returnFunctionAction = niceStub(of: returnFunctionThrowing, alwaysReturn: {"\($0)"})
    func returnFunctionThrowing() throws -> ((Int) -> (String)) {
        return try returnFunctionAction(())
    }
    lazy var takeObjectAction = niceStub(of: takeObjectThrowing)
    lazy var takeObjectActionCustom = niceStub(of: takeObjectThrowing, alwaysReturn: Void())
    func takeObjectThrowing(_ obj: AnyObject) throws {
        return try takeObjectAction(obj)
    }
    lazy var takeAutoclosureStringAction = niceStub(of: takeAutoclosureStringThrowing)
    lazy var takeAutoclosureStringActionCustom = niceStub(of: takeAutoclosureStringThrowing, alwaysReturn: Void())
    func takeAutoclosureStringThrowing(_ closure: @autoclosure () -> (String)) throws {
        return try takeAutoclosureStringAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherAction = niceStub(of: takeAutoclosureStringWithOtherThrowing)
    lazy var takeAutoclosureStringWithOtherActionCustom = niceStub(of: takeAutoclosureStringWithOtherThrowing, alwaysReturn: Void())
    func takeAutoclosureStringWithOtherThrowing(_ closure: @autoclosure () -> (String), other: String) throws {
        return try takeAutoclosureStringWithOtherAction((closure(), other))
    }
}


