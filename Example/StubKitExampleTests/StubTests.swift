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

class StubTests: XCTestCase {
    
    private var testMock: TestMock!
    
    override func setUp() {
        testMock = TestMock()
    }
    
    override func tearDown() {
        testMock = nil
        
        
    }
    
}


private struct MyStruct {}
private struct DefautableStruct {}
extension DefautableStruct: DefaultProvidable {
    static var defaultValue = DefautableStruct()
}

private protocol TestProtocol {
    func takeObject(_ obj:AnyObject)
    func returnObject() -> AnyObject
    func takeValueType(_ struct: MyStruct)
    func returnValueType() -> MyStruct
    func takeDefaultableValueType(_ number: Int)
    func returnDefautableValueType() -> Int
    func takeCustomDefaultableValueType(_ number: DefautableStruct)
    func returnCustomDefautableValueType() -> DefautableStruct
    func takeTwoArgs(v1: Int, v2: String)
    func returnTuple() -> (Int, String)
    func takeTupleNamed(_ tuple: (v1: Int, v2: String))
    func returnTupleNamed() -> (v1: Int, v2: String)
    func takeEscaping(_: @escaping (Int) -> (String))
    func takeNonscaping(_: (Int) -> (String))
    func returnFunction() -> ((Int) -> (String))
    func takeAutoclosureString(_: @autoclosure () -> (String))
    func takeAutoclosureStringWithOther(_: @autoclosure () -> (String), other: String)
}
private protocol TestProtocolThrowing {
    func takeObjectThrowing(_ obj:AnyObject) throws
    func returnObjectThrowing() throws -> AnyObject
    func takeValueTypeThrowing(_ struct: MyStruct) throws
    func returnValueTypeThrowing() throws -> MyStruct
    func takeDefaultableValueTypeThrowing(_ number: Int) throws
    func returnDefautableValueTypeThrowing() throws -> Int
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStruct) throws
    func returnCustomDefautableValueTypeThrowing() throws -> DefautableStruct
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

private class TestMock: TestProtocol {
    
    lazy var takeValueTypeAction = stub(of: takeValueType)
    func takeValueType(_ myStruct: MyStruct) {
        return takeValueTypeAction(myStruct)
    }
    
    lazy var returnValueTypeAction = stub(of: returnValueType)
    func returnValueType() -> MyStruct {
        return returnValueTypeAction(())
    }
    lazy var takeCustomDefaultableValueTypeAction = stub(of: takeCustomDefaultableValueType)
    func takeCustomDefaultableValueType(_ number: DefautableStruct) {
        return takeCustomDefaultableValueTypeAction(number)
    }
    lazy var returnCustomDefautableValueTypeAction = stub(of: returnCustomDefautableValueType)
    func returnCustomDefautableValueType() -> DefautableStruct {
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
}
private class TestMockThrowing: TestProtocolThrowing {
    
    lazy var takeValueTypeThrowingAction = stub(of: takeValueTypeThrowing)
    func takeValueTypeThrowing(_ myStruct: MyStruct) throws {
        return try takeValueTypeThrowingAction(myStruct)
    }
    
    lazy var returnValueTypeThrowingAction = stub(of: returnValueTypeThrowing)
    func returnValueTypeThrowing() throws  -> MyStruct {
        return try returnValueTypeThrowingAction(())
    }
    lazy var takeCustomDefaultableValueTypeThrowingAction = stub(of: takeCustomDefaultableValueTypeThrowing)
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStruct) throws  {
        return try takeCustomDefaultableValueTypeThrowingAction(number)
    }
    lazy var returnCustomDefautableValueTypeThrowingAction = stub(of: returnCustomDefautableValueTypeThrowing)
    func returnCustomDefautableValueTypeThrowing() throws  -> DefautableStruct {
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
