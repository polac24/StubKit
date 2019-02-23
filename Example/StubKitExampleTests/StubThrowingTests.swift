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

class StubThrowingTests: XCTestCase {
    
    private var testMock: TestMockThrowing!
    
    override func setUp() {
        testMock = TestMockThrowing()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testRuntimeDoesntCrash() {
    }
}




private protocol TestProtocolThrowing {
    func takeObjectThrowing(_ obj:AnyObject) throws
    func returnObjectThrowing() throws -> AnyObject
    func takeValueTypeThrowing(_ struct: MyStructGlobal) throws
    func returnValueTypeThrowing() throws -> MyStructGlobal
    func takeDefaultableValueTypeThrowing(_ number: Int) throws
    func returnDefautableValueTypeThrowing() throws -> Int
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStructGlobal) throws
    func returnCustomDefautableValueTypeThrowing() throws -> DefautableStructGlobal
    func takeTwoArgsThrowing(v1: Int, v2: String) throws
    func returnTupleThrowing() throws -> (Int, String)
    func takeTupleNamedThrowing(_ tuple: (v1: Int, v2: String)) throws
    func returnTupleNamedThrowing() throws -> (v1: Int, v2: String)
    func takeEscapingThrowing(_: @escaping (Int) -> (String)) throws
    func takeNonscapingThrowing(_: (Int) -> (String)) throws
    func returnFunctionThrowing() throws -> ((Int) -> (String))
    func takeAutoclosureStringThrowing(_: @autoclosure () -> (String)) throws
    func takeAutoclosureStringWithOtherThrowing(_: @autoclosure () -> (String), other: String) throws
    
}

private class TestMockThrowing: TestProtocolThrowing {
    
    lazy var takeValueTypeThrowingAction = stub(of: takeValueTypeThrowing)
    func takeValueTypeThrowing(_ myStruct: MyStructGlobal) throws {
        return try takeValueTypeThrowingAction(myStruct)
    }
    
    lazy var returnValueTypeThrowingAction = stub(of: returnValueTypeThrowing)
    func returnValueTypeThrowing() throws  -> MyStructGlobal {
        return try returnValueTypeThrowingAction(())
    }
    lazy var takeCustomDefaultableValueTypeThrowingAction = stub(of: takeCustomDefaultableValueTypeThrowing)
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStructGlobal) throws  {
        return try takeCustomDefaultableValueTypeThrowingAction(number)
    }
    lazy var returnCustomDefautableValueTypeThrowingAction = stub(of: returnCustomDefautableValueTypeThrowing)
    func returnCustomDefautableValueTypeThrowing() throws  -> DefautableStructGlobal {
        return try returnCustomDefautableValueTypeThrowingAction(())
    }
    
    lazy var returnObjectThrowingAction = stub(of: returnObjectThrowing)
    func returnObjectThrowing() throws  -> AnyObject {
        return try returnObjectThrowingAction(())
    }
    
    lazy var takeDefaultableValueTypeThrowingAction = stub(of: takeDefaultableValueTypeThrowing)
    func takeDefaultableValueTypeThrowing(_ number: Int) throws  {
        try takeDefaultableValueTypeThrowingAction(number)
    }
    
    lazy var returnDefautableValueTypeThrowingAction = stub(of: returnDefautableValueTypeThrowing)
    func returnDefautableValueTypeThrowing() throws  -> Int {
        return try returnDefautableValueTypeThrowingAction(())
    }
    lazy var takeTwoArgsThrowingAction = stub(of: takeTwoArgsThrowing)
    func takeTwoArgsThrowing(v1: Int, v2: String) throws  {
        return try takeTwoArgsThrowingAction((v1, v2))
    }
    lazy var returnTupleThrowingAction = stub(of: returnTupleThrowing)
    func returnTupleThrowing() throws  -> (Int, String) {
        return try returnTupleThrowingAction(())
    }
    lazy var takeTupleNamedThrowingAction = stub(of: takeTupleNamedThrowing)
    func takeTupleNamedThrowing(_ tuple: (v1: Int, v2: String)) throws {
        return try takeTupleNamedThrowingAction(tuple)
    }
    lazy var returnTupleNamedThrowingAction = stub(of: returnTupleNamedThrowing)
    func returnTupleNamedThrowing() throws -> (v1: Int, v2: String) {
        return try returnTupleNamedThrowingAction(())
    }
    lazy var takeEscapingThrowingAction = stub(of: takeEscapingThrowing)
    func takeEscapingThrowing(_ f: @escaping (Int) -> (String)) throws {
        return try takeEscapingThrowingAction(f)
    }
    lazy var takeNonscapingThrowingAction = stub(of: takeNonscapingThrowing)
    func takeNonscapingThrowing(_ f: (Int) -> (String)) throws {
        return try withoutActuallyEscaping(f) { try takeNonscapingThrowingAction($0)}
    }
    lazy var returnFunctionThrowingAction = stub(of: returnFunctionThrowing)
    func returnFunctionThrowing() throws -> ((Int) -> (String)) {
        return try returnFunctionThrowingAction(())
    }
    lazy var takeObjectThrowingAction = stub(of: takeObjectThrowing)
    func takeObjectThrowing(_ obj: AnyObject) throws {
        return try takeObjectThrowingAction(obj)
    }
    lazy var takeAutoclosureStringThrowingAction = stub(of: takeAutoclosureStringThrowing)
    func takeAutoclosureStringThrowing(_ closure: @autoclosure () -> (String)) throws {
        return try takeAutoclosureStringThrowingAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherThrowingAction = stub(of: takeAutoclosureStringWithOtherThrowing)
    func takeAutoclosureStringWithOtherThrowing(_ closure: @autoclosure () -> (String), other: String) throws {
        return try takeAutoclosureStringWithOtherThrowingAction((closure(), other))
    }
    
}
