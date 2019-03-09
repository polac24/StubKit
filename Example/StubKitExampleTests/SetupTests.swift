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

class RegisterSequenceTests: XCTestCase {
    
    
    private var testMock: TestStubMock!
    private var testThrowingMock: TestStubThrowingMock!

    
    override func setUp() {
        testMock = TestStubMock()
        testThrowingMock = TestStubThrowingMock()
    }
    
    override func tearDown() {
        testMock = nil
        testThrowingMock = nil
    }
    
    func testRegisterSequenceRecordsReturnOrder() {
        setupStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .returnsOnce(0)
            .returnsOnce(1)
            .returnsOnce(2)
        
        let returns = Array(0..<3).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [0,1,2])
    }
    
    func testRegisterSequenceCallsSpies() {
        let args = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        setupStubSequence(of: &testMock.takeDefaultableValueTypeAction)
            .returnsOnce(Void())
            .returnsOnce(Void())
            .returnsOnce(Void())
        
        _ = Array(0..<3).map({testMock.takeDefaultableValueType($0)})
        // Assert
        XCTAssertEqual(args, [0,1,2])
    }
    
    func testRegisterSequenceCanPreceedSpy() {
        setupStubSequence(of: &testMock.takeDefaultableValueTypeAction)
            .returnsOnce(Void())
            .returnsOnce(Void())
            .returnsOnce(Void())
        let args = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        
        _ = Array(0..<3).map({testMock.takeDefaultableValueType($0)})
        // Assert
        XCTAssertEqual(args, [0,1,2])
    }
    
    func testRegisterSequenceWithEndlessReturn() {
        setupStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .returnsOnce(0)
            .returnsOnce(1)
            .returnsOnce(2)
            .returns(3)
        
        let returns = Array(0..<5).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    func testRegisterSequenceWithEndlessReturnAppended() {
        setupStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .returnsOnce(0)
            .returnsOnce(1)
            .returnsOnce(2)
            .returns(3)
            .returnsOnce(4)
        
        let returns = Array(0..<5).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    
    func testRegisterSequenceCallsStandardWhenRunOut() {
        testMock.returnDefautableValueTypeAction = registerStub(alwaysReturn: 10)
        setupStubSequence(of: &testMock.returnDefautableValueTypeAction)
            .returnsOnce(-1)
            .returnsOnce(-2)
        
        let returns = Array(0..<3).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [-1,-2,10])
    }
    
    func testRegisterThrowingSequenceKeepsRecordedOrder() throws {
        setupStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .returnsOnce(0)
            .returnsOnce(1)
            .returnsOnce(2)
        
        let returns = try Array(0..<3).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,1,2])
    }
    
    func testRegisterThrowingSequenceCallsSpies() throws {
        let args = spyCalls(of: &testThrowingMock.takeDefaultableValueTypeThrowingAction)
        setupStubSequence(of: &testThrowingMock.takeDefaultableValueTypeThrowingAction)
            .returnsOnce(Void())
            .returnsOnce(Void())
            .returnsOnce(Void())
        
        _ = try Array(0..<3).map({try testThrowingMock.takeDefaultableValueTypeThrowing($0)})
        // Assert
        XCTAssertEqual(args, [0,1,2])
    }
    
    func testRegisterThrowingSequenceThrows() {
        setupStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .returnsOnce(1)
            .throws("Throw")
            .throws("Throw2")
        
        let returns = Array(0..<3).map({_ in try? testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [1,nil,nil])
    }
    
    func testRegisterThrowingSequenceWithEndlessReturn() throws {
        setupStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .returnsOnce(0)
            .returnsOnce(1)
            .returnsOnce(2)
            .returns(3)
        
        let returns = try Array(0..<5).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    func testRegisterThrowingSequenceWithEndlessReturnAppended() throws {
        setupStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .returnsOnce(0)
            .returnsOnce(1)
            .returnsOnce(2)
            .returns(3)
            .returnsOnce(4)
        
        let returns = try Array(0..<5).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,1,2,3,3])
    }
    
    func testRegisterThrowingSequenceWithEndlessThrowAppended() {
        setupStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .returnsOnce(0)
            .throws("Throw")
        
        let returns = Array(0..<3).map({_ in try? testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [0,nil,nil])
    }
    
    func testRegisterThrowingSequenceCallsStandardWhenRunOut() {
        testThrowingMock.returnDefautableValueTypeThrowingAction = registerStub(alwaysReturn: 10)
        setupStubSequence(of: &testThrowingMock.returnDefautableValueTypeThrowingAction)
            .returnsOnce(-1)
            .throwsOnce("Throw")
        
        let returns = Array(0..<3).map({_ in try? testThrowingMock.returnDefautableValueTypeThrowing()})
        // Assert
        XCTAssertEqual(returns, [-1,nil,10])
    }
    
    func testSetupReturnsCustomizedValue() {
        setupStub(of: &testMock.returnDefautableValueTypeAction, return: 1)
        
        let returns = Array(0..<3).map({_ in testMock.returnDefautableValueType()})
        // Assert
        XCTAssertEqual(returns, [1,1,1])
    }
    
    func testSetupReturnsOverridesPreviousSetups() {
        setupStub(of: &testMock.returnDefautableValueTypeAction, return: 1)
        setupStub(of: &testMock.returnDefautableValueTypeAction, return: 2)
        
        let returns1 = Array(0..<3).map({_ in testMock.returnDefautableValueType()})
        setupStub(of: &testMock.returnDefautableValueTypeAction, return: 3)
        let returns2 = Array(0..<3).map({_ in testMock.returnDefautableValueType()})

        // Assert
        XCTAssertEqual(returns1, [2,2,2])
        XCTAssertEqual(returns2, [3,3,3])
    }
    
    func testSetupCallsCallsSpies() {
        let args = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        setupStub(of: &testMock.takeDefaultableValueTypeAction, return: Void())
        
        _ = Array(0..<3).map({testMock.takeDefaultableValueType($0)})
        // Assert
        XCTAssertEqual(args, [0,1,2])
    }
    func testSetupThrowableCallsCallsSpies() throws {
        let args = spyCalls(of: &testThrowingMock.takeDefaultableValueTypeThrowingAction)
        setupStub(of: &testThrowingMock.takeDefaultableValueTypeThrowingAction, return: Void())
        
        _ = try Array(0..<3).map({try testThrowingMock.takeDefaultableValueTypeThrowing($0)})
        // Assert
        XCTAssertEqual(args, [0,1,2])
    }
    func testSetupThrowedCallsCallsSpies() {
        let args = spyCalls(of: &testThrowingMock.takeDefaultableValueTypeThrowingAction)
        setupStub(of: &testThrowingMock.takeDefaultableValueTypeThrowingAction, throw: "A")
        
        _ = Array(0..<3).map({try? testThrowingMock.takeDefaultableValueTypeThrowing($0)})
        // Assert
        XCTAssertEqual(args, [0,1,2])
    }
    
    func testSetupThrowableCallsOverridePreviousSetups() throws {
        setupStub(of: &testThrowingMock.returnDefautableValueTypeThrowingAction, return: 1)
        setupStub(of: &testThrowingMock.returnDefautableValueTypeThrowingAction, return: 2)
        
        let returns1 = try Array(0..<3).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        setupStub(of: &testThrowingMock.returnDefautableValueTypeThrowingAction, return: 3)
        let returns2 = try Array(0..<3).map({_ in try testThrowingMock.returnDefautableValueTypeThrowing()})
        
        // Assert
        XCTAssertEqual(returns1, [2,2,2])
        XCTAssertEqual(returns2, [3,3,3])
    }
    
    func testSelectiveRegisterSequence() {
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction)
            .when(0)
            .returnsOnce(1)
            .returnsOnce(2)
            .returns(3)
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction)
            .when(1)
            .returns(4)
        
        let inputArgs =  [0,0,1,1,1,0,0,-1,-1,-1]
        let results = inputArgs.map({testMock.takeAndReturnDefautableValueType($0)})
        
        // Assert
        XCTAssertEqual(results, [1,2,4,4,4,3,3,0,0,0])
    }
    
    func testSelectiveRegisterPassesArgDownForSpys() {
        let spies = spyCalls(of: &testMock.takeAndReturnDefautableValueTypeAction)
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction)
            .when(0)
            .returnsOnce(1)
            .returnsOnce(2)
            .returns(3)
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction)
            .when(1)
            .returns(4)
        
        let inputArgs =  [0,0,1,1,1,0,0,-1,-1,-1]
        _ = inputArgs.forEach({ _ = testMock.takeAndReturnDefautableValueType($0)})

        // Assert
        XCTAssertEqual(spies, [0,0,1,1,1,0,0,-1,-1,-1])
    }
    
    func testSelectiveRegisterSequenceForMultipleArguments() {
        let testMock = MultipleInputMock()
        
        setupStubSequence(of: &testMock.takeTwoEquatableValueTypeAction)
            .whenFirst(0)
            .returnsOnce(1)
            .returns(3)
        setupStubSequence(of: &testMock.takeTwoEquatableValueTypeAction)
            .whenSecond("A")
            .returns(4)
        
        let inputArgs =  [(0,"B"), (0, "b"), (-1, "A"), (-1, "c")]
        let results = inputArgs.map({testMock.takeTwoEquatableValueType($0.0, $0.1)})
        
        // Assert
        XCTAssertEqual(results, [1,3,4,0])
    }
    
    func testLastSelectiveRegisterSequenceForMultipleArgumentsHasPriority() {
        let testMock = MultipleInputMock()
        
        setupStubSequence(of: &testMock.takeTwoEquatableValueTypeAction)
            .whenFirst(0)
            .returns(1)
        setupStubSequence(of: &testMock.takeTwoEquatableValueTypeAction)
            .whenSecond("A")
            .returns(4)
        
        let inputArgs =  [(0,"A"), (0, "b")]
        let results = inputArgs.map({testMock.takeTwoEquatableValueType($0.0, $0.1)})
        
        // Assert
        XCTAssertEqual(results, [4,1])
    }
    
    func testSelectiveRegisterSequenceForOneEquatableArguments() {
        let testMock = MultipleInputMock()
        let globalClass = MyClassGlobal()
        
        setupStubSequence(of: &testMock.takeOneEquatableAndOneNonEquatableTypeAction)
            .whenFirst(0)
            .returnsOnce(1)
            .returns(3)
        
        let inputArgs =  [(0,globalClass), (0, globalClass), (-1, globalClass), (-1, globalClass), (0, globalClass)]
        let results = inputArgs.map({testMock.takeOneEquatableAndOneNonEquatableType($0.0, $0.1)})
        
        // Assert
        XCTAssertEqual(results, [1,3,0,0,3])
    }
    
    func testPredicateSelectiveRegisterPassesArgDownForSpys() throws {
        let spies = spyCalls(of: &testMock.takeAndReturnDefautableValueTypeAction)
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction, for: { return $0 == 0})
            .returnsOnce(1)
            .returnsOnce(2)
            .returns(3)
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction,for: { return $0 == 1})
            .returns(4)
        
        setupStubSequence(of: &testMock.takeAndReturnDefautableValueTypeAction).when(0)
            .returns(0)


        let inputArgs =  [0,0,1,1,1,0,0,-1,-1,-1]
        _ = inputArgs.forEach({ _ = testMock.takeAndReturnDefautableValueType($0)})
        
        // Assert
        XCTAssertEqual(spies, [0,0,1,1,1,0,0,-1,-1,-1])
    }
}

fileprivate protocol MultipleInputProtocol{
    func takeTwoEquatableValueType(_ number:Int, _ name: String) -> Int
    func takeOneEquatableAndOneNonEquatableType(_ number:Int, _ nonEquatable: MyClassGlobal) -> Int
}

fileprivate class MultipleInputMock: MultipleInputProtocol {
    lazy var takeTwoEquatableValueTypeAction = stub(of: takeTwoEquatableValueType)
    func takeTwoEquatableValueType(_ number: Int, _ name: String) -> Int {
        return takeTwoEquatableValueTypeAction((number, name))
    }
    
    lazy var takeOneEquatableAndOneNonEquatableTypeAction = stub(of: takeOneEquatableAndOneNonEquatableType)
    func takeOneEquatableAndOneNonEquatableType(_ number: Int, _ nonEquatable: MyClassGlobal) -> Int {
        return takeOneEquatableAndOneNonEquatableTypeAction((number, nonEquatable))
    }
    
    
}
