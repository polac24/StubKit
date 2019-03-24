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
import StubKit

class TestStrictStubMockGlobal: TestProtocolGlobal {
    
    lazy var simpleFunctionAction = strictStub(of: simpleFunction)
    func simpleFunction() {
        return simpleFunctionAction(())
    }
    lazy var takeValueTypeAction = strictStub(of: takeValueType)
    func takeValueType(_ myStruct: MyStructGlobal) {
        return takeValueTypeAction(myStruct)
    }
    lazy var takeObjectEquatableAction = strictStub(of: takeObjectEquatable)
    func takeObjectEquatable(_ obj: MyClassGlobal) {
        return takeObjectEquatableAction(obj)
    }
    lazy var returnValueTypeAction = strictStub(of: returnValueType)
    func returnValueType() -> MyStructGlobal {
        return returnValueTypeAction(())
    }
    lazy var takeCustomDefaultableValueTypeAction = strictStub(of: takeCustomDefaultableValueType)
    func takeCustomDefaultableValueType(_ number: DefautableStructGlobal) {
        return takeCustomDefaultableValueTypeAction(number)
    }
    lazy var returnCustomDefautableValueTypeAction = strictStub(of: returnCustomDefautableValueType)
    func returnCustomDefautableValueType() -> DefautableStructGlobal {
        return returnCustomDefautableValueTypeAction(())
    }
    
    lazy var returnObjectAction = strictStub(of: returnObject)
    func returnObject() -> AnyObject {
        return returnObjectAction(())
    }
    
    lazy var takeDefaultableValueTypeAction = strictStub(of: takeDefaultableValueType)
    func takeDefaultableValueType(_ number: Int) {
        takeDefaultableValueTypeAction(number)
    }
    
    lazy var returnDefautableValueTypeAction = strictStub(of: returnDefautableValueType)
    func returnDefautableValueType() -> Int {
        return returnDefautableValueTypeAction(())
    }
    
    lazy var takeAndReturnDefautableValueTypeAction = strictStub(of: takeAndReturnDefautableValueType)
    func takeAndReturnDefautableValueType(_ number: Int) -> Int {
        return takeAndReturnDefautableValueTypeAction(number)
    }
    lazy var takeTwoArgsAction = strictStub(of: takeTwoArgs)
    func takeTwoArgs(v1: Int, v2: String) {
        return takeTwoArgsAction((v1, v2))
    }
    lazy var returnTupleAction = strictStub(of: returnTuple)
    func returnTuple() -> (Int, String) {
        return returnTupleAction(())
    }
    lazy var takeTupleNamedAction = strictStub(of: takeTupleNamed)
    func takeTupleNamed(_ tuple: (v1: Int, v2: String)) {
        return takeTupleNamedAction(tuple)
    }
    lazy var returnTupleNamedAction = strictStub(of: returnTupleNamed)
    func returnTupleNamed() -> (v1: Int, v2: String) {
        return returnTupleNamedAction(())
    }
    lazy var takeEscapingAction = strictStub(of: takeEscaping)
    func takeEscaping(_ f: @escaping (Int) -> (String)) {
        return takeEscapingAction(f)
    }
    lazy var takeTwoEscapingAction = strictStub(of: takeTwoEscaping)
    func takeTwoEscaping(_ f1: @escaping (Int) -> (String), _ f2: @escaping (String) -> (Int)) {
        return takeTwoEscapingAction((f1,f2))
    }
    lazy var takeNonscapingAction = strictStub(of: takeNonscaping)
    func takeNonscaping(_ f: (Int) -> (String)) {
        return withoutActuallyEscaping(f) { takeNonscapingAction($0)}
    }
    lazy var returnFunctionAction = strictStub(of: returnFunction)
    func returnFunction() -> ((Int) -> (String)) {
        return returnFunctionAction(())
    }
    lazy var takeObjectAction = strictStub(of: takeObject)
    func takeObject(_ obj: AnyObject) {
        return takeObjectAction(obj)
    }
    lazy var takeAutoclosureStringAction = strictStub(of: takeAutoclosureString)
    func takeAutoclosureString(_ closure: @autoclosure () -> (String)) {
        return takeAutoclosureStringAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherAction = strictStub(of: takeAutoclosureStringWithOther)
    func takeAutoclosureStringWithOther(_ closure: @autoclosure () -> (String), other: String) {
        return takeAutoclosureStringWithOtherAction((closure(), other))
    }
    // not supported. For more details, see https://forums.swift.org/t/array-splatting-for-variadic-parameters/7175
    /*lazy var takeVarArgsAction = strictStub(of: takeVarArgs)
    func takeVarArgs(_ arg: Int...) {
        return takeVarArgsAction(arg)
    }
    lazy var takeVarArgsAndOtherAction = strictStub(of: takeVarArgsAndOther)
    func takeVarArgsAndOther(_ arg: Int..., other: String) {
        return takeVarArgsAndOtherAction((arg, other))
    }*/
}

