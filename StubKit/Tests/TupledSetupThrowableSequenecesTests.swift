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

class TupledSetupThrowableSequenecesTests: XCTestCase {
    
    
    func testSequence2ConfiguresFirst() throws{
        var action: (((String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenFirst("a").returns(1)
        
        XCTAssertEqual(try action(("a","")), 1)
    }
    func testSequence2ConfiguresSecond() throws {
        var action: (((String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenSecond("a").returns(2)
        
        XCTAssertEqual(try action(("","a")), 2)
    }
    
    func testSequence3ConfiguresFirst() throws {
        var action: (((String,String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenFirst("a").returns(1)
        
        XCTAssertEqual(try action(("a","","")), 1)
    }
    func testSequence3ConfiguresSecond() throws {
        var action: (((String,String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenSecond("a").returns(2)
        
        XCTAssertEqual(try action(("","a","")), 2)
    }
    func testSequence3ConfiguresThird() throws {
        var action: (((String,String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenThird("a").returns(3)
        
        XCTAssertEqual(try action(("","","a")), 3)
    }
    
    func testSequence4ConfiguresFirst() throws {
        var action: (((String,String,String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenFirst("a").returns(1)
        
        XCTAssertEqual(try action(("a","","","")), 1)
    }
    func testSequence4ConfiguresSecond() throws {
        var action: (((String,String,String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenSecond("a").returns(2)
        
        XCTAssertEqual(try action(("","a","","")), 2)
    }
    func testSequence4ConfiguresThird() throws {
        var action: (((String,String,String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenThird("a").returns(3)
        
        XCTAssertEqual(try action(("","","a","")), 3)
    }
    func testSequence4ConfiguresForth() throws {
        var action: (((String,String,String,String)) throws ->(Int)) = {_ in return 0}
        setupStubSequence(of: &action).whenForth("a").returns(4)
        
        XCTAssertEqual(try action(("","","","a")), 4)
    }
}
