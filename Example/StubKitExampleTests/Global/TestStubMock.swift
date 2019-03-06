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


class TestStubMock: TestProtocolGlobal {
    
    
    lazy var takeValueTypeAction = stub(of: takeValueType)
    lazy var takeValueTypeActionCustom = stub(of: takeValueType, alwaysReturn: Void())
    func takeValueType(_ myStruct: MyStructGlobal) {
        return takeValueTypeAction(myStruct)
    }
    lazy var takeObjectEquatableAction = stub(of: takeObjectEquatable)
    func takeObjectEquatable(_ obj: MyClassGlobal) {
        return takeObjectEquatableAction(obj)
    }
    
    lazy var returnValueTypeAction = stub(of: returnValueType, alwaysReturn: MyStructGlobal())
    func returnValueType() -> MyStructGlobal {
        return returnValueTypeAction(())
    }
    lazy var takeCustomDefaultableValueTypeAction = stub(of: takeCustomDefaultableValueType)
    lazy var takeCustomDefaultableValueTypeActionCustom = stub(of: takeCustomDefaultableValueType, alwaysReturn: Void())
    func takeCustomDefaultableValueType(_ number: DefautableStructGlobal) {
        return takeCustomDefaultableValueTypeAction(number)
    }
    lazy var returnCustomDefautableValueTypeAction = stub(of: returnCustomDefautableValueType)
    lazy var returnCustomDefautableValueTypeActionCustom = stub(of: returnCustomDefautableValueType, alwaysReturn: DefautableStructGlobal())
    func returnCustomDefautableValueType() -> DefautableStructGlobal {
        return returnCustomDefautableValueTypeAction(())
    }
    
    lazy var returnObjectAction = stub(of: returnObject, alwaysReturn: NSObject())
    func returnObject() -> AnyObject {
        return returnObjectAction(())
    }
    
    lazy var takeDefaultableValueTypeAction = stub(of: takeDefaultableValueType)
    lazy var takeDefaultableValueTypeActionCustom = stub(of: takeDefaultableValueType, alwaysReturn: Void())
    func takeDefaultableValueType(_ number: Int) {
        takeDefaultableValueTypeAction(number)
    }
    
    lazy var returnDefautableValueTypeAction = stub(of: returnDefautableValueType)
    lazy var returnDefautableValueTypeActionCustom = stub(of: returnDefautableValueType, alwaysReturn: 1)
    func returnDefautableValueType() -> Int {
        return returnDefautableValueTypeAction(())
    }
    func returnDefautableValueTypeCustom() -> Int {
        return returnDefautableValueTypeActionCustom(())
    }
    lazy var takeAndReturnDefautableValueTypeAction = stub(of: takeAndReturnDefautableValueType)
    func takeAndReturnDefautableValueType(_ number: Int) -> Int {
        return takeAndReturnDefautableValueTypeAction(number)
    }
    lazy var takeTwoArgsAction = stub(of: takeTwoArgs)
    lazy var takeTwoArgsActionCustom = stub(of: takeTwoArgs, alwaysReturn: Void())
    func takeTwoArgs(v1: Int, v2: String) {
        return takeTwoArgsAction((v1, v2))
    }
    lazy var returnTupleAction = stub(of: returnTuple, alwaysReturn: (0,""))
    func returnTuple() -> (Int, String) {
        return returnTupleAction(())
    }
    lazy var takeTupleNamedAction = stub(of: takeTupleNamed)
    lazy var takeTupleNamedActionCustom = stub(of: takeTupleNamed, alwaysReturn: Void())
    func takeTupleNamed(_ tuple: (v1: Int, v2: String)) {
        return takeTupleNamedAction(tuple)
    }
    lazy var returnTupleNamedAction = stub(of: returnTupleNamed, alwaysReturn: (0,""))
    func returnTupleNamed() -> (v1: Int, v2: String) {
        return returnTupleNamedAction(())
    }
    lazy var takeEscapingAction = stub(of: takeEscaping)
    lazy var takeEscapingActionCustom = stub(of: takeEscaping, alwaysReturn: Void())
    func takeEscaping(_ f: @escaping (Int) -> (String)) {
        return takeEscapingAction(f)
    }
    lazy var takeTwoEscapingAction = stub(of: takeTwoEscaping)
    func takeTwoEscaping(_ f1: @escaping (Int) -> (String), _ f2: @escaping (String) -> (Int)) {
        return takeTwoEscapingAction((f1,f2))
    }
    lazy var takeNonscapingAction = stub(of: takeNonscaping)
    lazy var takeNonscapingActionCustom = stub(of: takeNonscaping, alwaysReturn: Void())
    func takeNonscaping(_ f: (Int) -> (String)) {
        return withoutActuallyEscaping(f) { takeNonscapingAction($0)}
    }
    lazy var returnFunctionAction = stub(of: returnFunction, alwaysReturn: {"\($0)"})
    func returnFunction() -> ((Int) -> (String)) {
        return returnFunctionAction(())
    }
    lazy var takeObjectAction = stub(of: takeObject)
    lazy var takeObjectActionCustom = stub(of: takeObject, alwaysReturn: Void())
    func takeObject(_ obj: AnyObject) {
        return takeObjectAction(obj)
    }
    lazy var takeAutoclosureStringAction = stub(of: takeAutoclosureString)
    lazy var takeAutoclosureStringActionCustom = stub(of: takeAutoclosureString, alwaysReturn: Void())
    func takeAutoclosureString(_ closure: @autoclosure () -> (String)) {
        return takeAutoclosureStringAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherAction = stub(of: takeAutoclosureStringWithOther)
    lazy var takeAutoclosureStringWithOtherActionCustom = stub(of: takeAutoclosureStringWithOther, alwaysReturn: Void())
    func takeAutoclosureStringWithOther(_ closure: @autoclosure () -> (String), other: String) {
        return takeAutoclosureStringWithOtherAction((closure(), other))
    }
}


