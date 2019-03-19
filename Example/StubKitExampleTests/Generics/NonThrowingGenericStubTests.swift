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

class NonThrowingGenericStubTests: XCTestCase {
    
    private var testMock: TestMock!
    
    override func setUp() {
        testMock = TestMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testTakingGeneric() {
        let spy = spyCalls(of: &testMock.takeGenericInt)
        
        testMock.takeGeneric(1)
        
        XCTAssertEqual(spy, [1])
    }
    
    func testReturningGeneric() {
        let spy = spyCalls(of: &testMock.returnGenericInt)
        setupStubSequence(of: &testMock.returnGenericInt).returns(3)
        
        let returned:Int = testMock.returnGeneric()
        
        XCTAssertEqual(spy.count, 1)
        XCTAssertEqual(returned, 3)
    }
    
}

private protocol TestProtocol {
    func takeGeneric<T>(_ obj:T)
    func returnGeneric<T>() -> T
    func takeGenericReturnStatic<T>(_ obj:T) -> String
    func returnGenericTakeStatic<T>(_ obj:String) -> T
    func takeAndReturnGenerics<T1,T2,R>(_ obj1:T1, _ obj2: T2) -> R
}

private class TestMock: TestProtocol {
    lazy var takeGenericInt = stubGeneric(of: takeGeneric).with(first: Int.self).stub
    func takeGeneric<T>(_ obj: T) {
        return callGeneric((obj), potentials: [takeGenericInt])
    }
    
    lazy var returnGenericInt = stubGeneric(of: returnGeneric).with(return: Int.self).stub
    func returnGeneric<T>() -> T {
        return callGeneric((), potentials: [returnGenericInt])
    }
    
    lazy var takeGenericReturnStaticInt = stubGeneric(of: takeGenericReturnStatic).with(first: Int.self).stub
    func takeGenericReturnStatic<T>(_ obj: T) -> String {
        return callGeneric(obj, potentials: [takeGenericReturnStaticInt])
    }
    
    lazy var returnGenericTakeStaticInt = stubGeneric(of: returnGenericTakeStatic).with(return: Int.self).stub
    func returnGenericTakeStatic<T>(_ obj: String) -> T {
        return callGeneric(obj, potentials: [returnGenericTakeStaticInt])
    }
    
    lazy var takeAndReturnGenericsIntStringString = stubGeneric(of: takeAndReturnGenerics).with(first: Int.self).with(second: String.self).with(return: String.self).stub
    func takeAndReturnGenerics<T1, T2, R>(_ obj1: T1, _ obj2: T2) -> R {
        return callGeneric((obj1,obj2), potentials: [takeAndReturnGenericsIntStringString])
    }
}
