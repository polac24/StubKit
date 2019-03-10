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

public enum StubExpectation {
    case never
    case once
    case atLeastOnce
    case times(Int)
    case atLeastTimes(Int)
    case noMoreThan(Int)
}

extension StubExpectation {
    public func meets(count: Int) -> Bool {
        return notMetDescription(count: count) == nil
    }
    
    public func notMetDescription(count: Int) -> String? {
        switch (self, count) {
        case (.never, 0): return nil
        case (.once, 1): return nil
        case (.atLeastOnce, let i) where i>0: return nil
        case (.times(let timesExpected), let times) where timesExpected == times: return nil
        case (.atLeastTimes(let timesExpected), let times) where times >= timesExpected: return nil
        case (.noMoreThan(let timesExpected), let times) where times <= timesExpected: return nil
        default:
            return "Called \(timesDescription(count)) while expected \(expectationDescription)"
        }
    }
    
    private var expectationDescription: String {
        switch self {
        case .never: return "never"
        case .once: return "once"
        case .atLeastOnce: return "at least once"
        case .times(let times): return "exactly \(times)"
        case .atLeastTimes(let times): return "at least \(times) (or more)"
        case .noMoreThan(let times): return "at maximum \(times) (or less)"
        }
    }
    
    private func timesDescription(_ count:Int) -> String {
        if [1].contains(count) {
            return "\(count) time"
        }
        return "\(count) times"
    }
}

