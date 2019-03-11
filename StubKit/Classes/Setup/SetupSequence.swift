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

public class AbstractSetupSequence<I> {
    /// Number of times return has been used
    fileprivate var count = 0
    /// Position after which returns the same value forever
    fileprivate var endless: Int?
    /// Checks required to analyse this setup
    var filters: [((I) -> Bool)] = []
    /// Number of times arguments matched
    fileprivate var filteredCount = 0
    /// Assigned expectations to verify
    fileprivate var expectations: [StubExpectation]  = []
    /// Set of expectation parameters required to be verified
    fileprivate var expectingVerification: (StaticString, UInt)?
    /// All callbacks to perform on match
    fileprivate var callbacks: [(I) -> Void] = []
    /// All callbacks to perform after the match
    var postCallbacks: [(I) -> Void] = []
    
    fileprivate init(){}
    
    deinit {
        if let parameters = expectingVerification {
            preconditionFailure("Not verfied expectation", file: parameters.0, line: parameters.1)
        }
    }
    
    fileprivate func returnIndex(count: Int) -> Int {
        guard let endless = endless else {
            return count
        }
        return min(endless, count)
    }
    
    public func expect(_ expectation: StubExpectation, file: StaticString = #file, line: UInt = #line) -> Self {
        expectingVerification = (file, line)
        expectations.append(expectation)
        return self
    }
    private func verificationFailuresLazy() -> LazyCollection<[String]> {
        expectingVerification = nil
        return expectations.compactMap({$0.notMetDescription(count: filteredCount)}).lazy
    }
    public func verify() -> Bool {
        return verificationFailuresLazy().isEmpty
    }
    public func verificationFailures() -> [String] {
        return Array(verificationFailuresLazy())
    }
    public func when(_ predicate: @escaping (I) -> Bool) -> Self {
        filters.append(predicate)
        return self
    }
    @discardableResult
    public func callback(_ callback: @escaping (I) -> Void) -> Self {
        callbacks.append(callback)
        return self
    }
}

public class SetupSequence<I,O>: AbstractSetupSequence<I> {
    
    /// Oredered sequence of values to return
    private var values: [O] = []
    
    required override init(){
        super.init()
    }
    
    func nextValue(fallback: (I) ->(O), fallbackArg: I) -> O {
        guard filters.allSatisfy({$0(fallbackArg)}) else {
            return fallback(fallbackArg)
        }
        callbacks.forEach({$0(fallbackArg)})
        filteredCount += 1
        defer {
            postCallbacks.forEach({$0(fallbackArg)})
        }
        let valuesIndex = returnIndex(count: count)
        guard values.count > valuesIndex else {
            return fallback(fallbackArg)
        }
        _ = fallback(fallbackArg)
        defer {
            count += 1
        }
        return values[valuesIndex]
    }
    
    @discardableResult
    public func returnsOnce(_ o:O) -> Self {
        values.append(o)
        return self
    }
    @discardableResult
    public func returns(_ o:O) -> Self {
        endless = values.count
        return returnsOnce(o)
    }
}

public class SetupThrowableSequence<I,O>: AbstractSetupSequence<I> {
    enum ValueType<O> {
        case value(O)
        case error(Error)
    }
    /// Oredered sequence of values to return
    private var values: [ValueType<O>] = []

    
    required override init(){
        super.init()
    }
    
    func nextValue(fallback: (I) throws ->(O), fallbackArg: I) throws -> O {
        guard filters.allSatisfy({$0(fallbackArg)}) else {
            return try fallback(fallbackArg)
        }
        callbacks.forEach({$0(fallbackArg)})
        filteredCount += 1
        defer {
            postCallbacks.forEach({$0(fallbackArg)})
        }
        let valuesIndex = returnIndex(count: count)
        guard values.count > valuesIndex else {
            return try fallback(fallbackArg)
        }
        defer {
            count += 1
            _ = try? fallback(fallbackArg)
        }
        switch values[valuesIndex] {
        case .error(let error):
            throw error
        case .value(let value):
            return value
        }
    }
    
    @discardableResult
    public func returnsOnce(_ o:O) -> Self {
        values.append(.value(o))
        return self
    }
    
    @discardableResult
    public func returns(_ o:O) -> Self {
        endless = values.count
        return returnsOnce(o)
    }
    
    @discardableResult
    public func throwsOnce(_ e:Error) -> Self {
        values.append(.error(e))
        return self
    }
    
    @discardableResult
    public func `throws`(_ e:Error) -> Self {
        guard endless == nil else {
            return self
        }
        endless = values.count
        return throwsOnce(e)
    }
}

extension SetupSequence where I:Equatable{
    public func when(_ i:I) -> SetupSequence<I,O> {
        filters.append { v -> Bool in
            v == i
        }
        return self
    }
}

extension SetupThrowableSequence where I:Equatable{
    public func when(_ i:I) -> SetupThrowableSequence<I,O> {
        filters.append { v -> Bool in
            v == i
        }
        return self
    }
}
