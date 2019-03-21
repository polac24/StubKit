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

class ThrowingGenericStubTests: XCTestCase {
    
    private var testMock: TestMock!
    
    override func setUp() {
        testMock = TestMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testTakingGeneric() throws {
        let spy = spyCalls(of: &testMock.takeGenericInt)
        
        try testMock.takeGeneric(1)
        
        XCTAssertEqual(spy, [1])
    }
    
    func testTakingGenericAlternative() throws {
        let spy = spyCalls(of: &testMock.takeGenericString)
        
        try testMock.takeGeneric("T")
        
        XCTAssertEqual(spy, ["T"])
    }
    
    func testTakingGenericAlternativeSelectsOnlySpecificType() throws {
        let spyBase = spyCalls(of: &testMock.takeGenericBase)
        let spyDerived = spyCalls(of: &testMock.takeGenericDerived)
        
        try testMock.takeGeneric(DerivedClass())
        
        XCTAssertEqual(spyBase.count, 0)
        XCTAssertEqual(spyDerived.count, 1)
    }
    
    func testReturningGeneric() throws {
        let spy = spyCalls(of: &testMock.returnGenericInt)
        setupStubSequence(of: &testMock.returnGenericInt).returns(3)
        
        let returned:Int = try testMock.returnGeneric()
        
        XCTAssertEqual(spy.count, 1)
        XCTAssertEqual(returned, 3)
    }
    
    func testTakeGenericReturnStatic() throws {
        let spy = spyCalls(of: &testMock.takeGenericReturnStaticInt)
        
        _ = try testMock.takeGenericReturnStatic(3)
        
        XCTAssertEqual(spy, [3])
    }
    
    func testReturnsDefaultGenericValue() throws {
        let spy = spyCalls(of: &testMock.returnGenericTakeStaticInt)
        
        let returned: Int = try testMock.returnGenericTakeStatic("a")
        
        XCTAssertEqual(spy, ["a"])
        XCTAssertEqual(returned, 0)
    }
    
    func testReturnsDefaultValue() throws {
        let spy = spyCalls(of: &testMock.returnGenericTakeStaticInt)
        
        let returned: Int = try testMock.returnGenericTakeStatic("a")
        
        XCTAssertEqual(spy, ["a"])
        XCTAssertEqual(returned, 0)
    }
    
    func testReturningAndTakingGenerics() throws {
        let spy = spyCalls(of: &testMock.takeAndReturnGenericsIntStringString)
        
        _ = try testMock.takeAndReturnGenerics(1, "s") as String
        
        XCTAssertEqual(spy.count, 1)
    }
    
    func testGenericFunction() throws {
        let spy = spyCalls(of: &testMock.takeGenericEscapingFunctionStringReturnBool)
        
        let returned: Bool = try testMock.takeGenericEscapingFunction { (_:String) in return 1}
        
        XCTAssertEqual(spy.count, 1)
        XCTAssertEqual(returned, false)
    }
    
    func testGenerics1Args() {
        func sampleGeneric<A,R>(_ :A) throws -> R? {
            return nil
        }
        let _ = stubGeneric(of: sampleGeneric).with(first:Int.self).with(return:Int?.self)

    }
    func testGenerics2Args() {
        func sampleGeneric<A,B,R>(_ :A, _ :B) throws -> R? {
            return nil
        }
        _ = stubGeneric(of: sampleGeneric).with(first:Int.self).with(second: Int?.self).with(return:Int?.self)
    }
    func testGenerics3Args() {
        func sampleGeneric<A,B,C,R>(_ :A, _ :B, _ :C) throws -> R? {
            return nil
        }
        _ = stubGeneric(of: sampleGeneric).with(first:Int.self).with(second: Int?.self).with(third: Int.self).with(return:Int?.self)
    }
    func testGenerics4Args() {
        func sampleGeneric<A,B,C,D,R>(_ :A, _ :B, _ :C, _ :D) throws -> R? {
            return nil
        }
        _ = stubGeneric(of: sampleGeneric).with(first:Int.self).with(second: Int?.self).with(third: Int.self).with(forth: Int.self).with(return:Int?.self)
    }
    func testGenerics5Args() {
        func sampleGeneric<A,B,C,D,E,R>(_ :A, _ :B, _ :C, _ :D, _ :E) throws -> R? {
            return nil
        }
        _ = stubGeneric(of: sampleGeneric).with(first:Int.self).with(second: Int?.self).with(third: Int.self).with(forth: Int.self).with(fifth: Void?.self).with(return:Int?.self)
    }
    func testGenericsStub() {
        func sampleGeneric<A,R>(_ :A) throws -> R? {
            return nil
        }
        _ = stubGeneric(of: sampleGeneric).with(first:Int.self).with(return:Int?.self).stub
        _ = stubGeneric(of: sampleGeneric).with(first:Int.self).with(return:Int?.self).strictStub
    }
    
}

private protocol TestProtocol {
    func takeGeneric<T>(_ obj:T) throws
    func returnGeneric<T>() throws -> T
    func takeGenericReturnStatic<T>(_ obj:T) throws -> String
    func returnGenericTakeStatic<T>(_ obj:String) throws -> T
    func takeAndReturnGenerics<T1,T2,R>(_ obj1:T1, _ obj2: T2) throws -> R
    func takeGenericEscapingFunction<T1,R>(_ obj1:@escaping (T1) -> Int) throws -> R
}

private class TestMock: TestProtocol {
    lazy var takeGenericInt = stubGeneric(of: takeGeneric).with(first: Int.self).stub
    lazy var takeGenericString = stubGeneric(of: takeGeneric).with(first: String.self).stub
    lazy var takeGenericBase = stubGeneric(of: takeGeneric).with(first: BaseClass.self).stub
    lazy var takeGenericDerived = stubGeneric(of: takeGeneric).with(first: DerivedClass.self).stub
    func takeGeneric<T>(_ obj: T) throws {
        return try callThrowsGeneric((obj), potentials: [takeGenericInt, takeGenericString, takeGenericBase, takeGenericDerived])
    }
    
    lazy var returnGenericInt = stubGeneric(of: returnGeneric).with(return: Int.self).stub
    func returnGeneric<T>() throws -> T {
        return try callThrowsGeneric((), potentials: [returnGenericInt])
    }
    
    lazy var takeGenericReturnStaticInt = stubGeneric(of: takeGenericReturnStatic).with(first: Int.self).stub
    func takeGenericReturnStatic<T>(_ obj: T) throws -> String {
        return try callThrowsGeneric(obj, potentials: [takeGenericReturnStaticInt])
    }
    
    lazy var returnGenericTakeStaticInt = stubGeneric(of: returnGenericTakeStatic).with(return: Int.self).stub
    func returnGenericTakeStatic<T>(_ obj: String) throws -> T {
        return try callThrowsGeneric(obj, potentials: [returnGenericTakeStaticInt])
    }
    
    lazy var takeAndReturnGenericsIntStringString = stubGeneric(of: takeAndReturnGenerics).with(first: Int.self).with(second: String.self).with(return: String.self).stub
    func takeAndReturnGenerics<T1, T2, R>(_ obj1: T1, _ obj2: T2) throws -> R {
        return try callThrowsGeneric((obj1,obj2), potentials: [takeAndReturnGenericsIntStringString])
    }
    
    lazy var takeGenericEscapingFunctionStringReturnBool = stubGeneric(of: takeGenericEscapingFunction).with(first: ((String) -> Int).self).with(return: Bool.self).stub
    func takeGenericEscapingFunction<T1, R>(_ obj1: @escaping (T1) -> Int) throws -> R {
        return try callThrowsGeneric((obj1), potentials: [takeGenericEscapingFunctionStringReturnBool])
    }
    
    // Non defaultable requires strict stub
    lazy var returnGenericTakeStaticCustom = stubGeneric(of: returnGenericTakeStatic).with(return: BaseClass.self).strictStub
}

fileprivate class BaseClass {}
fileprivate class DerivedClass: BaseClass {}
