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

public func callGeneric<In,Out>(_ input: In, potentials: [Any], file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> Out{
    for potential in potentials {
        if let found = potential as? (In) -> Out {
            return found(input)
        }
    }
    fatalError("Unexpected generic specification at \(function)", file: file, line: line)
}

public func callThrowsGeneric<In,Out>(_ input: In, potentials: [Any], file: StaticString = #file, line: UInt = #line, function: StaticString = #function) throws -> Out{
    for potential in potentials {
        if let found = potential as? (In) throws -> Out {
            return try found(input)
        }
    }
    fatalError("Unexpected generic specification at \(function)", file: file, line: line)
}
