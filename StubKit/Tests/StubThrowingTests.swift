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



private class TestMockThrowing: TestProtocolGlobalThrowing {
    
    lazy var takeValueTypeThrowingAction = strictStub(of: takeValueTypeThrowing)
    func takeValueTypeThrowing(_ myStruct: MyStructGlobal) throws {
        return try takeValueTypeThrowingAction(myStruct)
    }
    
    lazy var returnValueTypeThrowingAction = strictStub(of: returnValueTypeThrowing)
    func returnValueTypeThrowing() throws  -> MyStructGlobal {
        return try returnValueTypeThrowingAction(())
    }
    lazy var takeCustomDefaultableValueTypeThrowingAction = strictStub(of: takeCustomDefaultableValueTypeThrowing)
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStructGlobal) throws  {
        return try takeCustomDefaultableValueTypeThrowingAction(number)
    }
    lazy var returnCustomDefautableValueTypeThrowingAction = strictStub(of: returnCustomDefautableValueTypeThrowing)
    func returnCustomDefautableValueTypeThrowing() throws  -> DefautableStructGlobal {
        return try returnCustomDefautableValueTypeThrowingAction(())
    }
    
    lazy var returnObjectThrowingAction = strictStub(of: returnObjectThrowing)
    func returnObjectThrowing() throws  -> AnyObject {
        return try returnObjectThrowingAction(())
    }
    
    lazy var takeDefaultableValueTypeThrowingAction = strictStub(of: takeDefaultableValueTypeThrowing)
    func takeDefaultableValueTypeThrowing(_ number: Int) throws  {
        try takeDefaultableValueTypeThrowingAction(number)
    }
    
    lazy var returnDefautableValueTypeThrowingAction = strictStub(of: returnDefautableValueTypeThrowing)
    func returnDefautableValueTypeThrowing() throws  -> Int {
        return try returnDefautableValueTypeThrowingAction(())
    }
    lazy var takeTwoArgsThrowingAction = strictStub(of: takeTwoArgsThrowing)
    func takeTwoArgsThrowing(v1: Int, v2: String) throws  {
        return try takeTwoArgsThrowingAction((v1, v2))
    }
    lazy var returnTupleThrowingAction = strictStub(of: returnTupleThrowing)
    func returnTupleThrowing() throws  -> (Int, String) {
        return try returnTupleThrowingAction(())
    }
    lazy var takeTupleNamedThrowingAction = strictStub(of: takeTupleNamedThrowing)
    func takeTupleNamedThrowing(_ tuple: (v1: Int, v2: String)) throws {
        return try takeTupleNamedThrowingAction(tuple)
    }
    lazy var returnTupleNamedThrowingAction = strictStub(of: returnTupleNamedThrowing)
    func returnTupleNamedThrowing() throws -> (v1: Int, v2: String) {
        return try returnTupleNamedThrowingAction(())
    }
    lazy var takeEscapingThrowingAction = strictStub(of: takeEscapingThrowing)
    func takeEscapingThrowing(_ f: @escaping (Int) -> (String)) throws {
        return try takeEscapingThrowingAction(f)
    }
    lazy var takeEscapingArgThrowingAction = strictStub(of: takeEscapingArgThrowing)
    func takeEscapingArgThrowing(_ f: @escaping (Int) throws -> (String)) {
        return takeEscapingArgThrowingAction(f)
    }
    lazy var takeTwoEscapingThrowingAction = strictStub(of: takeTwoEscapingThrowing)
    func takeTwoEscapingThrowing(_ f1: @escaping (Int) -> (String), _ f2: @escaping (String) -> (Int)) throws {
        return try takeTwoEscapingThrowing(f1,f2)
    }
    lazy var takeNonscapingThrowingAction = strictStub(of: takeNonscapingThrowing)
    func takeNonscapingThrowing(_ f: (Int) -> (String)) throws {
        return try withoutActuallyEscaping(f) { try takeNonscapingThrowingAction($0)}
    }
    lazy var takeNonscapingArgThrowingAction = strictStub(of: takeNonscapingArgThrowing)
    func takeNonscapingArgThrowing(_ f: (Int) throws -> (String)) {
        return withoutActuallyEscaping(f) { takeNonscapingArgThrowingAction($0)}
    }
    lazy var returnFunctionThrowingAction = strictStub(of: returnFunctionThrowing)
    func returnFunctionThrowing() throws -> ((Int) -> (String)) {
        return try returnFunctionThrowingAction(())
    }
    lazy var takeObjectThrowingAction = strictStub(of: takeObjectThrowing)
    func takeObjectThrowing(_ obj: AnyObject) throws {
        return try takeObjectThrowingAction(obj)
    }
    lazy var takeAutoclosureStringThrowingAction = strictStub(of: takeAutoclosureStringThrowing)
    func takeAutoclosureStringThrowing(_ closure: @autoclosure () -> (String)) throws {
        return try takeAutoclosureStringThrowingAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherThrowingAction = strictStub(of: takeAutoclosureStringWithOtherThrowing)
    func takeAutoclosureStringWithOtherThrowing(_ closure: @autoclosure () -> (String), other: String) throws {
        // Temporary workaround for https://bugs.swift.org/browse/SR-9991
        return try withoutActuallyEscaping(closure) {
            try takeAutoclosureStringWithOtherThrowingAction(($0, other))
        }
    }
    
}
