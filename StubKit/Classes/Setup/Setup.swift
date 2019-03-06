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

public func setupStub<I,O>(of stub: inout (I) -> (O), return returnValue: O) {
    setupStubSequence(of: &stub).andReturn(returnValue)
}
public func setupStub<I,O>(of stub: inout (I) throws -> (O), return returnValue: O) {
    setupStubSequence(of: &stub).andReturn(returnValue)
}
public func setupStub<I,O>(of stub: inout (I) throws -> (O), throw error: Error) {
    setupStubSequence(of: &stub).andThrow(error)
}


public func setupStubSequence<I,O>(of stub: inout (I) -> (O)) -> SetupSequence<I,O> {
    return setupStubSequence(of: &stub, for: {_ in true})
}

public func setupStubSequence<I,O>(of stub: inout (I) throws -> (O)) -> SetupThrowableSequence<I,O> {
    return setupStubSequence(of: &stub, for: {_ in true})
}

public func setupStubSequence<I:Equatable,O>(of stub: inout (I) -> (O), for expectedValue: I) -> SetupSequence<I,O> {
    return setupStubSequence(of: &stub, for: {$0 == expectedValue})
}
public func setupStubSequence<I:Equatable,O>(of stub: inout (I) throws -> (O), for expectedValue: I) -> SetupThrowableSequence<I,O> {
    return setupStubSequence(of: &stub, for: {$0 == expectedValue})
}

public func setupStubSequence<I1:Equatable, I2,O>(of stub: inout ((I1,I2)) -> (O), forFirstArgument expectedValue: I1) -> SetupSequence<(I1,I2),O> {
    return setupStubSequence(of: &stub, for: {$0.0 == expectedValue})
}
public func setupStubSequence<I1:Equatable, I2,O>(of stub: inout ((I1,I2)) throws -> (O), forFirstArgument expectedValue: I1) -> SetupThrowableSequence<(I1,I2),O> {
    return setupStubSequence(of: &stub, for: {$0.0 == expectedValue})
}

public func setupStubSequence<I1, I2:Equatable,O>(of stub: inout ((I1,I2)) -> (O), forSecondArgument expectedValue: I2) -> SetupSequence<(I1,I2),O> {
    return setupStubSequence(of: &stub, for: {$0.1 == expectedValue})
}
public func setupStubSequence<I1, I2:Equatable,O>(of stub: inout ((I1,I2)) throws -> (O), forSecondArgument expectedValue: I2) -> SetupThrowableSequence<(I1,I2),O> {
    return setupStubSequence(of: &stub, for: {$0.1 == expectedValue})
}

public func setupStubSequence<I1:Equatable, I2, I3,O>(of stub: inout ((I1,I2,I3)) -> (O), forFirstArgument expectedValue: I1) -> SetupSequence<(I1,I2,I3),O> {
    return setupStubSequence(of: &stub, for: {$0.0 == expectedValue})
}
public func setupStubSequence<I1:Equatable, I2, I3,O>(of stub: inout ((I1,I2,I3)) throws -> (O), forFirstArgument expectedValue: I1) -> SetupThrowableSequence<(I1,I2,I3),O> {
    return setupStubSequence(of: &stub, for: {$0.0 == expectedValue})
}

public func setupStubSequence<I1, I2:Equatable, I3,O>(of stub: inout ((I1,I2,I3)) -> (O), forFirstArgument expectedValue: I2) -> SetupSequence<(I1,I2,I3),O> {
    return setupStubSequence(of: &stub, for: {$0.1 == expectedValue})
}
public func setupStubSequence<I1, I2:Equatable, I3,O>(of stub: inout ((I1,I2,I3)) throws -> (O), forFirstArgument expectedValue: I2) -> SetupThrowableSequence<(I1,I2,I3),O> {
    return setupStubSequence(of: &stub, for: {$0.1 == expectedValue})
}

public func setupStubSequence<I1, I2, I3:Equatable,O>(of stub: inout ((I1,I2,I3)) -> (O), forFirstArgument expectedValue: I3) -> SetupSequence<(I1,I2,I3),O> {
    return setupStubSequence(of: &stub, for: {$0.2 == expectedValue})
}
public func setupStubSequence<I1, I2, I3:Equatable,O>(of stub: inout ((I1,I2,I3)) throws -> (O), forFirstArgument expectedValue: I3) -> SetupThrowableSequence<(I1,I2,I3),O> {
    return setupStubSequence(of: &stub, for: {$0.2 == expectedValue})
}

public func setupStubSequence<I,O>(of stub: inout (I) -> (O), for predicate: @escaping (I) -> Bool ) -> SetupSequence<I,O> {
    let sequence = SetupSequence<I,O>()
    let fallback = stub
    stub = { arg in
        if predicate(arg) {
            return sequence.nextValue(fallback: fallback, fallbackArg: arg)
        }
        return fallback(arg)
    }
    return sequence
}

public func setupStubSequence<I,O>(of stub: inout (I) throws -> (O), for predicate: @escaping (I) -> Bool ) -> SetupThrowableSequence<I,O> {
    let sequence = SetupThrowableSequence<I,O>()
    let fallback = stub
    stub = { arg in
        if predicate(arg) {
            return try sequence.nextValue(fallback: fallback, fallbackArg: arg)
        }
        return try fallback(arg)
    }
    return sequence
}
