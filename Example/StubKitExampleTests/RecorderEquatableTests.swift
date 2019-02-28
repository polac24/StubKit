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

class RecorderEquatableTests: XCTestCase {
    
    private var testMock: TestNiceStubMock!
    
    override func setUp() {
        testMock = TestNiceStubMock()
    }
    
    override func tearDown() {
        testMock = nil
    }
    
    func testRecorderWithNoCallIsComparableToEmptyArry() {
        // Arrange
        let arg = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        // Act
        // Assert
        XCTAssert(arg == [])
        XCTAssert([] == arg)
        XCTAssertEqual(arg, [])
    }
    
    func testRecorderWithOneCallIsComparableToSingleElementsArray() {
        // Arrange
        testMock.takeDefaultableValueTypeAction = registerStub()
        let arg = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        // Act
        testMock.takeDefaultableValueType(10)
        // Assert
        XCTAssert(arg == [10])
        XCTAssert([10] == arg)
        XCTAssertEqual(arg, [10])
    }
    
    func testRecorderWithSeveralCallIsComparableToElementsArray() {
        // Arrange
        testMock.takeDefaultableValueTypeAction = registerStub()
        let arg = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        // Act
        testMock.takeDefaultableValueType(10)
        testMock.takeDefaultableValueType(0)
        // Assert
        XCTAssert(arg == [10,0])
        XCTAssert([10,0] == arg)
        XCTAssertEqual(arg, [10,0])
    }
    
    func testRecorderTakesArgsOrderInArrayComparison() {
        // Arrange
        testMock.takeDefaultableValueTypeAction = registerStub()
        let arg = spyCalls(of: &testMock.takeDefaultableValueTypeAction)
        // Act
        testMock.takeDefaultableValueType(10)
        testMock.takeDefaultableValueType(0)
        // Assert
        XCTAssertFalse(arg == [0, 10])
        XCTAssertFalse([0, 10] == arg)
        XCTAssertNotEqual(arg, [0,10])
    }
    
    func testWeakRecorderComparableToEmptyArry() {
        // Arrange
        let arg = spyWeaklyCalls(of: &testMock.takeObjectEquatableAction)
        // Act
        // Assert
        XCTAssert(arg == [])
        XCTAssert([] == arg)
        XCTAssertEqual(arg, [])
    }
    func testWeakRecorderWithSeveralCallIsComparableToElementsArray() {
        // Arrange
        let arg = spyWeaklyCalls(of: &testMock.takeObjectEquatableAction)
        let class1 = MyClassGlobal(10)
        let class2 = MyClassGlobal(0)
        // Act
        testMock.takeObjectEquatable(class1)
        testMock.takeObjectEquatable(class2)
        // Assert
        XCTAssert(arg == [class1, class2])
        XCTAssert([class1, class2] == arg)
        XCTAssertEqual(arg, [class1, class2])
    }
    
    func testWeakRecorderComparesOrder() {
        // Arrange
        let arg = spyWeaklyCalls(of: &testMock.takeObjectEquatableAction)
        let class1 = MyClassGlobal(10)
        let class2 = MyClassGlobal(0)
        // Act
        testMock.takeObjectEquatable(class2)
        testMock.takeObjectEquatable(class1)
        // Assert
        XCTAssertFalse(arg == [class1, class2])
        XCTAssertFalse([class1, class2] == arg)
        XCTAssertNotEqual(arg, [class1, class2])
    }
}
