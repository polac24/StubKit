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

public protocol Recorder: class {
    associatedtype Element

    init()
    func record(_ t:Element)
    subscript(_ i:Int)->Element? {get}
    var count: Int {get}
    func clean()
}

protocol RecorderInternal: Recorder {
    associatedtype ElementInternal

    var history:[ElementInternal] {get set}
    var observers: [RecordObserver<ElementInternal>] {get set}
    var historyOffset: Int {get set}
    func map(_: Element) -> (ElementInternal)
    func inverseMap(_: ElementInternal) -> (Element)
    func add(observer: RecordObserver<Element>) 
}

extension RecorderInternal {
    public func record(_ t:Element){
        history.append(map(t))
        let index = count
        observers.removeAll(where: {$0.onRecord(v: map(t), index: index)})
    }
    
    public subscript(_ i:Int) -> Element?{
        if i < historyOffset {
            return nil
        }
        guard i < (historyOffset + history.count) else {return nil}
        return inverseMap(history[i])
    }
    
    public var count: Int {
        return history.count + historyOffset
    }
    
    public func clean() {
        historyOffset += history.count
        history = []
    }
    
    public func add(observer: RecordObserver<Element>) {
        observers.append(RecordObserver({ (e, i) -> (Bool) in
            #warning("cycle break needed")
            return observer.onRecord(v:self.inverseMap(e), index: i)
        }))
    }
}

public class ArgRecords<T>: RecorderInternal {
    func map(_ v: T) -> (T) {
        return v
    }
    
    func inverseMap(_ v: T) -> (T) {
        return v
    }
    
    public typealias  Element = T
    typealias  ElementInternal = T

    var history:[T] = []
    var historyOffset = 0
    var observers = [RecordObserver<T>]()
    
    public required init(){}
}
