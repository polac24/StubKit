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
@discardableResult
public func setupStub<I,O>(of stub: inout (I) -> (O), return returnValue: O) -> SetupSequence<I,O> {
    return setupStubSequence(of: &stub).returns(returnValue)
}
@discardableResult
public func setupStub<I,O>(of stub: inout (I) throws -> (O), return returnValue: O) -> SetupThrowableSequence<I,O>  {
    return setupStubSequence(of: &stub).returns(returnValue)
}
@discardableResult
public func setupStub<I,O>(of stub: inout (I) throws -> (O), throw error: Error) -> SetupThrowableSequence<I,O>  {
    return setupStubSequence(of: &stub).throws(error)
}


public func setupStubSequence<I,O>(of stub: inout (I) -> (O)) -> SetupSequence<I,O> {
    return setupStubSequence(of: &stub, type: SetupSequence.self)
}

public func setupStubSequence<I,O>(of stub: inout (I) throws -> (O)) -> SetupThrowableSequence<I,O> {
    return setupStubSequence(of: &stub, type: SetupThrowableSequence.self)
}

public func setupStubSequence<I1,I2,O>(of stub: inout ((I1,I2)) -> (O)) -> SetupSequence2<I1,I2,O> {
    return setupStubSequence(of: &stub, type: SetupSequence2.self)
}

public func setupStubSequence<I1,I2,I3,O>(of stub: inout ((I1,I2,I3)) -> (O)) -> SetupSequence3<I1,I2,I3,O> {
    return setupStubSequence(of: &stub, type: SetupSequence3.self)
}

public func setupStubSequence<I1,I2,I3,I4,O>(of stub: inout ((I1,I2,I3,I4)) -> (O)) -> SetupSequence4<I1,I2,I3,I4,O> {
    return setupStubSequence(of: &stub, type: SetupSequence4.self)
}

public func setupStubSequence<I1,I2,O>(of stub: inout ((I1,I2)) throws -> (O)) -> SetupThrowableSequence2<I1,I2,O> {
    return setupStubSequence(of: &stub, type: SetupThrowableSequence2.self)
}

public func setupStubSequence<I1,I2,I3,O>(of stub: inout ((I1,I2,I3)) throws -> (O)) -> SetupThrowableSequence3<I1,I2,I3,O> {
    return setupStubSequence(of: &stub, type: SetupThrowableSequence3.self)
}

public func setupStubSequence<I1,I2,I3,I4,O>(of stub: inout ((I1,I2,I3,I4)) throws -> (O)) -> SetupThrowableSequence4<I1,I2,I3,I4,O> {
    return setupStubSequence(of: &stub, type: SetupThrowableSequence4.self)
}

public func setupStubSequence<I,O>(of stub: inout (I) -> (O), for predicate: @escaping (I) -> Bool ) -> SetupSequence<I,O> {
    return setupStubSequence(of: &stub, type: SetupSequence.self).when(predicate)
}

public func setupStubSequence<I,O>(of stub: inout (I) throws -> (O), for predicate: @escaping (I) -> Bool ) -> SetupThrowableSequence<I,O> {
    return setupStubSequence(of: &stub, type: SetupThrowableSequence.self).when(predicate)
}

func setupStubSequence<I,O,T:SetupSequence<I,O>>(of stub: inout (I) -> (O), type: T.Type) -> T {
    let sequence = T()
    /// next element in a chain of responsibility
    let next = stub
    stub = { arg in
        return sequence.accept(next: next, argument: arg)
    }
    return sequence
}

func setupStubSequence<I,O,T:SetupThrowableSequence<I,O>>(of stub: inout (I) throws -> (O), type: T.Type ) -> T {
    let sequence = T()
    /// next element in a chain of responsibility
    let next = stub
    stub = { arg in
        return try sequence.nextValue(next: next, argument: arg)
    }
    return sequence
}
