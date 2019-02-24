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


class TestNiceStubMock: TestProtocolGlobal {
    
    lazy var takeValueTypeAction = niceStub(of: takeValueType)
    lazy var takeValueTypeActionCustom = niceStub(of: takeValueType, alwaysReturn: Void())
    func takeValueType(_ myStruct: MyStructGlobal) {
        return takeValueTypeAction(myStruct)
    }
    
    lazy var returnValueTypeAction = niceStub(of: returnValueType, alwaysReturn: MyStructGlobal())
    func returnValueType() -> MyStructGlobal {
        return returnValueTypeAction(())
    }
    lazy var takeCustomDefaultableValueTypeAction = niceStub(of: takeCustomDefaultableValueType)
    lazy var takeCustomDefaultableValueTypeActionCustom = niceStub(of: takeCustomDefaultableValueType, alwaysReturn: Void())
    func takeCustomDefaultableValueType(_ number: DefautableStructGlobal) {
        return takeCustomDefaultableValueTypeAction(number)
    }
    lazy var returnCustomDefautableValueTypeAction = niceStub(of: returnCustomDefautableValueType)
    lazy var returnCustomDefautableValueTypeActionCustom = niceStub(of: returnCustomDefautableValueType, alwaysReturn: DefautableStructGlobal())
    func returnCustomDefautableValueType() -> DefautableStructGlobal {
        return returnCustomDefautableValueTypeAction(())
    }
    
    lazy var returnObjectAction = niceStub(of: returnObject, alwaysReturn: NSObject())
    func returnObject() -> AnyObject {
        return returnObjectAction(())
    }
    
    lazy var takeDefaultableValueTypeAction = niceStub(of: takeDefaultableValueType)
    lazy var takeDefaultableValueTypeActionCustom = niceStub(of: takeDefaultableValueType, alwaysReturn: Void())
    func takeDefaultableValueType(_ number: Int) {
        takeDefaultableValueTypeAction(number)
    }
    
    lazy var returnDefautableValueTypeAction = niceStub(of: returnDefautableValueType)
    lazy var returnDefautableValueTypeActionCustom = niceStub(of: returnDefautableValueType, alwaysReturn: 1)
    func returnDefautableValueType() -> Int {
        return returnDefautableValueTypeAction(())
    }
    func returnDefautableValueTypeCustom() -> Int {
        return returnDefautableValueTypeActionCustom(())
    }
    lazy var takeTwoArgsAction = niceStub(of: takeTwoArgs)
    lazy var takeTwoArgsActionCustom = niceStub(of: takeTwoArgs, alwaysReturn: Void())
    func takeTwoArgs(v1: Int, v2: String) {
        return takeTwoArgsAction((v1, v2))
    }
    lazy var returnTupleAction = niceStub(of: returnTuple, alwaysReturn: (0,""))
    func returnTuple() -> (Int, String) {
        return returnTupleAction(())
    }
    lazy var takeTupleNamedAction = niceStub(of: takeTupleNamed)
    lazy var takeTupleNamedActionCustom = niceStub(of: takeTupleNamed, alwaysReturn: Void())
    func takeTupleNamed(_ tuple: (v1: Int, v2: String)) {
        return takeTupleNamedAction(tuple)
    }
    lazy var returnTupleNamedAction = niceStub(of: returnTupleNamed, alwaysReturn: (0,""))
    func returnTupleNamed() -> (v1: Int, v2: String) {
        return returnTupleNamedAction(())
    }
    lazy var takeEscapingAction = niceStub(of: takeEscaping)
    lazy var takeEscapingActionCustom = niceStub(of: takeEscaping, alwaysReturn: Void())
    func takeEscaping(_ f: @escaping (Int) -> (String)) {
        return takeEscapingAction(f)
    }
    lazy var takeNonscapingAction = niceStub(of: takeNonscaping)
    lazy var takeNonscapingActionCustom = niceStub(of: takeNonscaping, alwaysReturn: Void())
    func takeNonscaping(_ f: (Int) -> (String)) {
        return withoutActuallyEscaping(f) { takeNonscapingAction($0)}
    }
    lazy var returnFunctionAction = niceStub(of: returnFunction, alwaysReturn: {"\($0)"})
    func returnFunction() -> ((Int) -> (String)) {
        return returnFunctionAction(())
    }
    lazy var takeObjectAction = niceStub(of: takeObject)
    lazy var takeObjectActionCustom = niceStub(of: takeObject, alwaysReturn: Void())
    func takeObject(_ obj: AnyObject) {
        return takeObjectAction(obj)
    }
    lazy var takeAutoclosureStringAction = niceStub(of: takeAutoclosureString)
    lazy var takeAutoclosureStringActionCustom = niceStub(of: takeAutoclosureString, alwaysReturn: Void())
    func takeAutoclosureString(_ closure: @autoclosure () -> (String)) {
        return takeAutoclosureStringAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherAction = niceStub(of: takeAutoclosureStringWithOther)
    lazy var takeAutoclosureStringWithOtherActionCustom = niceStub(of: takeAutoclosureStringWithOther, alwaysReturn: Void())
    func takeAutoclosureStringWithOther(_ closure: @autoclosure () -> (String), other: String) {
        return takeAutoclosureStringWithOtherAction((closure(), other))
    }
}


