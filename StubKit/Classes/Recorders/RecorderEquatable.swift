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


extension ArgRecords: Equatable where Element: Equatable {
    public static func == (lhs: ArgRecords<Element>, rhs: ArgRecords<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        for i in 0..<rhs.count {
            if rhs[i] != lhs[i] {
                return false
            }
        }
        return true
    }
}
extension ArgWeakRecords: Equatable where Element: Equatable {
    public static func == (lhs: ArgWeakRecords<Element>, rhs: ArgWeakRecords<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        for i in 0..<rhs.count {
            if rhs[i] != lhs[i] {
                return false
            }
        }
        return true
    }
}
public func ==<T:Recorder> (lhs: Array<T.Element>, rhs: T) -> Bool where T.Element: Equatable, T: Equatable{
    return T(lhs) == rhs
}
public func ==<T:Recorder> (lhs: T, rhs: Array<T.Element>) -> Bool where T.Element: Equatable, T: Equatable{
    return rhs == lhs
}

