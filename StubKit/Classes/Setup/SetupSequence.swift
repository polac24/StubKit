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


enum MatchRepresentaion<I,O> {
    case all(O)
    case value(I, O)
    func matches(_ v:I) -> Bool {
        return true
    }
    func returnValue() -> O {
        switch self {
        case .all(let v), .value(_, let v):
            return v
        }
    }
}

public class SetupSequence<I,O> {
    
    var values: [MatchRepresentaion<I,O>] = []
    private var count = 0
    private var endless:Int?
    func nextValue(fallback: (I) ->(O), fallbackArg: I) -> O {
        let valuesIndex = returnIndex(count: count)
        guard values.count > valuesIndex && values[valuesIndex].matches(fallbackArg) else {
            return fallback(fallbackArg)
        }
        _ = fallback(fallbackArg)
        defer {
            count += 1
        }
        return values[valuesIndex].returnValue()
    }
    
    private func returnIndex(count: Int) -> Int {
        guard let endless = endless else {
            return count
        }
        return min(endless, count)
    }
    
    @discardableResult
    public func andReturnOnce(_ o:O) -> Self {
        values.append(.all(o))
        return self
    }
    @discardableResult
    public func andReturn(_ o:O) -> Self {
        endless = values.count
        return andReturnOnce(o)
    }
}
extension MatchRepresentaion where I: Equatable  {
    func matches(_ v:I) -> Bool {
        switch self{
        case .all:
            return true
        case .value(let i, _):
            return i == v
        }
    }
}

public class SetupThrowableSequence<I,O> {
    enum ValueType<O> {
        case value(O)
        case error(Error)
    }
    private var values: [MatchRepresentaion<I,ValueType<O>>] = []
    private var count = 0
    private var endless:Int?
    
    func nextValue(fallback: (I) throws ->(O), fallbackArg: I) throws -> O {
        let valuesIndex = returnIndex(count: count)
        guard values.count > valuesIndex && values[valuesIndex].matches(fallbackArg) else {
            return try fallback(fallbackArg)
        }
        defer {
            count += 1
            _ = try? fallback(fallbackArg)
        }
        switch values[valuesIndex].returnValue() {
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
    public func andReturnOnce(_ o:O) -> Self {
        values.append(.all(.value(o)))
        return self
    }
    
    @discardableResult
    public func andReturn(_ o:O) -> Self {
        endless = values.count
        return andReturnOnce(o)
    }
    
    @discardableResult
    public func andThrowOnce(_ e:Error) -> Self {
        values.append(.all(.error(e)))
        return self
    }
    
    @discardableResult
    public func andThrow(_ e:Error) -> Self {
        guard endless == nil else {
            return self
        }
        endless = values.count
        return andThrowOnce(e)
    }
}
