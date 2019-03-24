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

class VerifyFailingTests: XCTestCase {
    
    
    private lazy var recordFailureAction = stub(of: recordFailure)
    override func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: Int, expected: Bool) {
        return recordFailureAction((description, filePath, lineNumber, expected))
    }
    
    func testAssertionFailsFotNotMetExpectation() {
        var function: ((()) -> Void) = {_ in }
        let tokenOnce = setupStubSequence(of: &function).expect(.once)
        let args = spyCalls(of: &recordFailureAction)
        let assertFilename: StaticString = "MyFile.swift"
        let assertLine: UInt = 999
        
        SKTVerify(tokenOnce, file: assertFilename, line: assertLine)
        
        // Assert
        recordFailureAction = {
            return super.recordFailure(withDescription: $0.0, inFile: $0.1, atLine: $0.2, expected: $0.3)
        }
        XCTAssertEqual(args.count, 1)
        XCTAssertEqual(args[0]?.0, "failed - Sequence expectation not met: Called 0 times while expected once")
        XCTAssertEqual(args[0]?.1, "MyFile.swift")
        XCTAssertEqual(args[0]?.2, 999)
        XCTAssertEqual(args[0]?.3, true)
    }
    
}
