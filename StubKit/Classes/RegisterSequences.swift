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

public func registerStubSequence<I,O>(of stub: inout (I) -> (O)) -> RegisterSequence<O> {
    let sequence = RegisterSequence<O>()
    let fallback = stub
    stub = { arg in
        return sequence.nextValue(fallback: fallback, fallbackArg: arg)
    }
    return sequence
}

public func registerStubSequence<I,O>(of stub: inout (I) throws -> (O)) -> RegisterThrowableSequence<O> {
    let sequence = RegisterThrowableSequence<O>()
    let fallback = stub
    stub = { arg in
        return try sequence.nextValue(fallback: fallback, fallbackArg: arg)
    }
    return sequence
}

public class RegisterSequence<O> {
    private var values: [O] = []
    private var index = 0
    private var endless:Int?
    func nextValue<I>(fallback: (I) ->(O), fallbackArg: I) -> O {
        guard index != endless else {
            return values[index]
        }
        guard values.count > index else {
            return fallback(fallbackArg)
        }
        defer {
            index += 1
        }
        return values[index]
    }
    @discardableResult
    public func andReturn(_ o:O) -> Self {
        values.append(o)
        return self
    }
    @discardableResult
    public func andReturnLater(_ o:O) -> Self {
        endless = values.count
        return andReturn(o)
    }
}

public class RegisterThrowableSequence<O> {
    enum ValueType<O> {
        case value(O)
        case error(Error)
    }
    private var values: [ValueType<O>] = []
    private var count = 0
    private var endless:Int?
    
    func nextValue<I>(fallback: (I) throws ->(O), fallbackArg: I) throws -> O {
        let valuesIndex = returnIndex(count: count)
        guard values.count > valuesIndex else {
            return try fallback(fallbackArg)
        }
        defer {
            count += 1
        }
        switch values[valuesIndex] {
        case .error(let error):
            throw error
        case .value(let value):
            return value
        }
    }
    
    private func returnIndex(count: Int) -> Int {
        guard let endless = endless else {
            return count
        }
        return min(endless, count)
    }
    
    @discardableResult
    public func andReturn(_ o:O) -> Self {
        values.append(.value(o))
        return self
    }
    @discardableResult
    public func andReturnLater(_ o:O) -> Self {
        endless = values.count
        return andReturn(o)
    }
    
    @discardableResult
    public func andThrow(_ e:Error) -> Self {
        values.append(.error(e))
        return self
    }
    @discardableResult
    public func andThrowLater(_ e:Error) -> Self {
        guard endless == nil else {
            return self
        }
        endless = values.count
        return andThrow(e)
    }
}
