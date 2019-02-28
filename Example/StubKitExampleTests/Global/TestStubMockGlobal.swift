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

class TestStubMockGlobal: TestProtocolGlobal {
    
    
    lazy var takeValueTypeAction = stub(of: takeValueType)
    func takeValueType(_ myStruct: MyStructGlobal) {
        return takeValueTypeAction(myStruct)
    }
    lazy var takeObjectEquatableAction = stub(of: takeObjectEquatable)
    func takeObjectEquatable(_ obj: MyClassGlobal) {
        return takeObjectEquatableAction(obj)
    }
    lazy var returnValueTypeAction = stub(of: returnValueType)
    func returnValueType() -> MyStructGlobal {
        return returnValueTypeAction(())
    }
    lazy var takeCustomDefaultableValueTypeAction = stub(of: takeCustomDefaultableValueType)
    func takeCustomDefaultableValueType(_ number: DefautableStructGlobal) {
        return takeCustomDefaultableValueTypeAction(number)
    }
    lazy var returnCustomDefautableValueTypeAction = stub(of: returnCustomDefautableValueType)
    func returnCustomDefautableValueType() -> DefautableStructGlobal {
        return returnCustomDefautableValueTypeAction(())
    }
    
    lazy var returnObjectAction = stub(of: returnObject)
    func returnObject() -> AnyObject {
        return returnObjectAction(())
    }
    
    lazy var takeDefaultableValueTypeAction = stub(of: takeDefaultableValueType)
    func takeDefaultableValueType(_ number: Int) {
        takeDefaultableValueTypeAction(number)
    }
    
    lazy var returnDefautableValueTypeAction = stub(of: returnDefautableValueType)
    func returnDefautableValueType() -> Int {
        return returnDefautableValueTypeAction(())
    }
    lazy var takeTwoArgsAction = stub(of: takeTwoArgs)
    func takeTwoArgs(v1: Int, v2: String) {
        return takeTwoArgsAction((v1, v2))
    }
    lazy var returnTupleAction = stub(of: returnTuple)
    func returnTuple() -> (Int, String) {
        return returnTupleAction(())
    }
    lazy var takeTupleNamedAction = stub(of: takeTupleNamed)
    func takeTupleNamed(_ tuple: (v1: Int, v2: String)) {
        return takeTupleNamedAction(tuple)
    }
    lazy var returnTupleNamedAction = stub(of: returnTupleNamed)
    func returnTupleNamed() -> (v1: Int, v2: String) {
        return returnTupleNamedAction(())
    }
    lazy var takeEscapingAction = stub(of: takeEscaping)
    func takeEscaping(_ f: @escaping (Int) -> (String)) {
        return takeEscapingAction(f)
    }
    lazy var takeTwoEscapingAction = stub(of: takeTwoEscaping)
    func takeTwoEscaping(_ f1: @escaping (Int) -> (String), _ f2: @escaping (String) -> (Int)) {
        return takeTwoEscapingAction((f1,f2))
    }
    lazy var takeNonscapingAction = stub(of: takeNonscaping)
    func takeNonscaping(_ f: (Int) -> (String)) {
        return withoutActuallyEscaping(f) { takeNonscapingAction($0)}
    }
    lazy var returnFunctionAction = stub(of: returnFunction)
    func returnFunction() -> ((Int) -> (String)) {
        return returnFunctionAction(())
    }
    lazy var takeObjectAction = stub(of: takeObject)
    func takeObject(_ obj: AnyObject) {
        return takeObjectAction(obj)
    }
    lazy var takeAutoclosureStringAction = stub(of: takeAutoclosureString)
    func takeAutoclosureString(_ closure: @autoclosure () -> (String)) {
        return takeAutoclosureStringAction(closure())
    }
    lazy var takeAutoclosureStringWithOtherAction = stub(of: takeAutoclosureStringWithOther)
    func takeAutoclosureStringWithOther(_ closure: @autoclosure () -> (String), other: String) {
        return takeAutoclosureStringWithOtherAction((closure(), other))
    }
    // not supported. For more details, see https://forums.swift.org/t/array-splatting-for-variadic-parameters/7175
    /*lazy var takeVarArgsAction = stub(of: takeVarArgs)
    func takeVarArgs(_ arg: Int...) {
        return takeVarArgsAction(arg)
    }
    lazy var takeVarArgsAndOtherAction = stub(of: takeVarArgsAndOther)
    func takeVarArgsAndOther(_ arg: Int..., other: String) {
        return takeVarArgsAndOtherAction((arg, other))
    }*/
}

