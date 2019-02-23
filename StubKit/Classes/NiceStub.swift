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

public func niceStub<I,O>(of: (I)->(O), alwaysReturn defaultValue: O) -> (I)->(O) {
    return { _ in defaultValue }
}

public func niceStub<I,O:DefaultProvidable>(of: (I)->(O), alwaysReturn defaultValue: O = O.defaultValue) -> (I)->(O) {
    return { _ in defaultValue }
}

public func niceStub<I>(of: (I)->()) -> (I)->() {
    return niceStub(of: of, alwaysReturn: ())
}



public func niceStub<I,O>(of: (I) throws ->(O), alwaysReturn defaultValue: O) -> (I) throws ->(O) {
    return { _ in defaultValue }
}

public func niceStub<I,O:DefaultProvidable>(of: (I) throws ->(O), alwaysReturn defaultValue: O = O.defaultValue) -> (I) throws ->(O) {
    return { _ in defaultValue }
}

public func niceStub<I>(of: (I) throws ->()) -> (I) throws ->() {
    return niceStub(of: of, alwaysReturn: ())
}

public func niceStub<I,O>(of: (I) throws ->(O), alwaysThrow defaultThrow: Error) -> (I) throws ->(O) {
    return { _ in
        throw defaultThrow
    }
}

// Autoclosure workarounds
public func niceStub<I,O>(of: (@autoclosure () -> (I))->(O), alwaysReturn defaultValue: O) -> (I)->(O) {
    return { _ in defaultValue }
}

public func niceStub<I,O:DefaultProvidable>(of: (@autoclosure () -> (I))->(O), alwaysReturn defaultValue: O = O.defaultValue) -> (I)->(O) {
    return { _ in defaultValue }
}

public func niceStub<I>(of: (@autoclosure () -> (I))->()) -> (I)->() {
    return niceStub(of: of, alwaysReturn: ())
}

public func niceStub<I,O>(of: (@autoclosure () -> (I)) throws ->(O), alwaysReturn defaultValue: O) -> (I) throws ->(O) {
    return { _ in defaultValue }
}

public func niceStub<I,O:DefaultProvidable>(of: (@autoclosure () -> (I)) throws ->(O), alwaysReturn defaultValue: O = O.defaultValue) -> (I) throws ->(O) {
    return { _ in defaultValue }
}

public func niceStub<I>(of: (@autoclosure () -> (I)) throws ->()) -> (I) throws ->() {
    return niceStub(of: of, alwaysReturn: ())
}

public func niceStub<I,O>(of: (@autoclosure () -> (I)) throws ->(O), alwaysThrow defaultThrow: Error) -> (I) throws ->(O) {
    return { _ in
        throw defaultThrow
    }
}
