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

public class ArgWeakRecords<T:AnyObject>: RecorderInternal{
    public typealias Element = T
    typealias ElementInternal = WeakBox<T>
    
    var history: [WeakBox<T>]  = []
    var observers: [RecordObserver<WeakBox<T>>] = []
    var historyOffset: Int = 0
    
    func map(_ v: T) -> (WeakBox<T>) {
        return WeakBox(v)
    }
    
    func inverseMap(_ box: WeakBox<T>) -> (T) {
        #warning("Force unwrapp gracefull handle needed")
        return box.value!
    }
    
    required public init(){}
}

class WeakBox<T:AnyObject> {
    weak var value: T?
    init(_ value: T?) {
        self.value = value
    }
}
