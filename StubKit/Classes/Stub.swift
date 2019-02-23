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


public func stub<I,O>(of: (I)->(O), file: StaticString = #file, line: UInt = #line) -> (I)->(O) {
    fatalError("Unexpected stub call", file:file, line: line)
}

public func stub<I,O>(of: (I) throws ->(O), file: StaticString = #file, line: UInt = #line) -> (I) throws ->(O) {
    fatalError("Unexpected stub call", file:file, line: line)
}

// Temporary workaround for autoclosure support
public func stub<I,O>(of: @escaping (@autoclosure () -> (I)) -> (O), file: StaticString = #file, line: UInt = #line) -> (@autoclosure () -> (I)) -> (O) {
    fatalError("Unexpected stub call", file:file, line: line)
}

public func stub<I,O>(of: @escaping (@autoclosure () -> (I)) throws -> (O), file: StaticString = #file, line: UInt = #line) -> (@autoclosure () -> (I)) throws -> (O) {
    fatalError("Unexpected stub call", file:file, line: line)
}
