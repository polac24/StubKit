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

public class ArgWeakRecords<T:AnyObject>: Recorder{
    
    private var weakHistory:[WeakBox<T>] = []
    
    required public init(){}
    public required convenience init(arrayLiteral elements: T...) {
        self.init(elements)
    }
    public required init(_ elements: [T]) {
        weakHistory = elements.map(WeakBox.init)
    }

    public func record(_ t:T){
        weakHistory.append(WeakBox(t))
    }
    
    public subscript(_ i: Int) -> T? {
        guard i < weakHistory.count else { return nil }
        return weakHistory[i].value
    }
    public var count: Int {
        return weakHistory.count
    }
}

private class WeakBox<T:AnyObject> {
    weak var value: T?
    init(_ value: T?) {
        self.value = value
    }
}
