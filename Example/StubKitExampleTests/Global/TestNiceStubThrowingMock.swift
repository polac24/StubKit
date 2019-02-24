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

class TestNiceStubThrowingMock: TestProtocolGlobalThrowing {
    
    lazy var takeValueTypeThrowingAction = niceStub(of: takeValueTypeThrowing)
    lazy var takeValueTypeThrowingActionCustom = niceStub(of: takeValueTypeThrowing, alwaysReturn: Void())
    func takeValueTypeThrowing(_ myStruct: MyStructGlobal) throws {
        return try takeValueTypeThrowingAction(myStruct)
    }
    
    lazy var returnValueTypeThrowingAction = niceStub(of: returnValueTypeThrowing, alwaysReturn: MyStructGlobal())
    func returnValueTypeThrowing() throws -> MyStructGlobal {
        return try returnValueTypeThrowingAction(())
    }
    lazy var takeCustomDefaultableValueTypeThrowingAction = niceStub(of: takeCustomDefaultableValueTypeThrowing)
    lazy var takeCustomDefaultableValueTypeThrowingActionCustom = niceStub(of: takeCustomDefaultableValueTypeThrowing, alwaysReturn: Void())
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStructGlobal) throws {
        return try takeCustomDefaultableValueTypeThrowingAction(number)
    }
    lazy var returnCustomDefautableValueTypeThrowingAction = niceStub(of: returnCustomDefautableValueTypeThrowing)
    lazy var returnCustomDefautableValueTypeThrowingActionCustom = niceStub(of: returnCustomDefautableValueTypeThrowing, alwaysReturn: DefautableStructGlobal())
    func returnCustomDefautableValueTypeThrowing() throws -> DefautableStructGlobal {
        return try returnCustomDefautableValueTypeThrowingAction(())
    }
    
    lazy var returnObjectThrowingAction = niceStub(of: returnObjectThrowing, alwaysReturn: NSObject())
    func returnObjectThrowing() throws -> AnyObject {
        return try returnObjectThrowingAction(())
    }
    
    lazy var takeDefaultableValueTypeThrowingAction = niceStub(of: takeDefaultableValueTypeThrowing)
    lazy var takeDefaultableValueTypeThrowingActionCustom = niceStub(of: takeDefaultableValueTypeThrowing, alwaysReturn: Void())
    func takeDefaultableValueTypeThrowing(_ number: Int) throws {
        try takeDefaultableValueTypeThrowingAction(number)
    }
    
    lazy var returnDefautableValueTypeThrowingAction = niceStub(of: returnDefautableValueTypeThrowing)
    lazy var returnDefautableValueTypeThrowingActionCustom = niceStub(of: returnDefautableValueTypeThrowing, alwaysReturn: 1)
    func returnDefautableValueTypeThrowing() throws -> Int {
        return try returnDefautableValueTypeThrowingAction(())
    }
    func returnDefautableValueTypeCustomThrowing() throws -> Int {
        return try returnDefautableValueTypeThrowingActionCustom(())
    }
    lazy var takeTwoArgsThrowingAction = niceStub(of: takeTwoArgsThrowing)
    lazy var takeTwoArgsThrowingActionCustom = niceStub(of: takeTwoArgsThrowing, alwaysReturn: Void())
    func takeTwoArgsThrowing(v1: Int, v2: String) throws {
        return try takeTwoArgsThrowingAction((v1, v2))
    }
    lazy var returnTupleThrowingAction = niceStub(of: returnTupleThrowing, alwaysReturn: (0,""))
    func returnTupleThrowing() throws -> (Int, String) {
        return try returnTupleThrowingAction(())
    }
    lazy var takeTupleNamedThrowingAction = niceStub(of: takeTupleNamedThrowing)
    lazy var takeTupleNamedThrowingActionCustom = niceStub(of: takeTupleNamedThrowing, alwaysReturn: Void())
    func takeTupleNamedThrowing(_ tuple: (v1: Int, v2: String)) throws {
        return try takeTupleNamedThrowingAction(tuple)
    }
    lazy var returnTupleNamedThrowingAction = niceStub(of: returnTupleNamedThrowing, alwaysReturn: (0,""))
    func returnTupleNamedThrowing() throws -> (v1: Int, v2: String) {
        return try returnTupleNamedThrowingAction(())
    }
    lazy var takeEscapingThrowingAction = niceStub(of: takeEscapingThrowing)
    lazy var takeEscapingThrowingActionCustom = niceStub(of: takeEscapingThrowing, alwaysReturn: Void())
    func takeEscapingThrowing(_ f: @escaping (Int) -> (String)) throws {
        return try takeEscapingThrowingAction(f)
    }
    lazy var takeNonscapingThrowingAction = niceStub(of: takeNonscapingThrowing)
    lazy var takeNonscapingThrowingActionCustom = niceStub(of: takeNonscapingThrowing, alwaysReturn: Void())
    func takeNonscapingThrowing(_ f: (Int) -> (String)) throws {
        return try withoutActuallyEscaping(f) { try takeNonscapingThrowingAction($0)}
    }
    lazy var returnFunctionThrowingAction = niceStub(of: returnFunctionThrowing, alwaysReturn: {"\($0)"})
    func returnFunctionThrowing() throws -> ((Int) -> (String)) {
        return try returnFunctionThrowingAction(())
    }
    lazy var takeObjectThrowingAction = niceStub(of: takeObjectThrowing)
    lazy var takeObjectThrowingActionCustom = niceStub(of: takeObjectThrowing, alwaysReturn: Void())
    func takeObjectThrowing(_ obj: AnyObject) throws {
        return try takeObjectThrowingAction(obj)
    }
    lazy var takeAutoclosureStringThrowingAction = niceStub(of: takeAutoclosureStringThrowing)
    lazy var takeAutoclosureStringThrowingActionCustom = niceStub(of: takeAutoclosureStringThrowing, alwaysReturn: Void())
    func takeAutoclosureStringThrowing(_ closure: @autoclosure () -> (String)) throws {
        return try takeAutoclosureStringThrowingAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherThrowingAction = niceStub(of: takeAutoclosureStringWithOtherThrowing)
    lazy var takeAutoclosureStringWithOtherThrowingActionCustom = niceStub(of: takeAutoclosureStringWithOtherThrowing, alwaysReturn: Void())
    func takeAutoclosureStringWithOtherThrowing(_ closure: @autoclosure () -> (String), other: String) throws {
        return try takeAutoclosureStringWithOtherThrowingAction((closure(), other))
    }
}


