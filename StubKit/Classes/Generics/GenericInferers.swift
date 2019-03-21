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


public class BaseInferer<I,O> {
    let file: StaticString
    let line: UInt
    let function: StaticString
    init(_ file: StaticString , _ line: UInt, _ function: StaticString){
        self.line = line
        self.file = file
        self.function = function
    }
}
public class BaseNonThrowingInferer<I,O> : BaseInferer<I,O> {
    public var strictStub: ((I)->(O)) {
        return {[file, line, function] _ in
            fatalError("Unexpected generic call in \(function)", file: file, line: line)
        }
    }
}

extension BaseNonThrowingInferer where O: DefaultProvidable {
    public var stub: (I)->(O) {
        return { _ in
            O.defaultValue
        }
    }
}
extension BaseNonThrowingInferer where O == Void {
    public var stub: (I)->(O) {
        return { _ in }
    }
}

public class GenericInferer1<In1,Out>: BaseNonThrowingInferer<(In1),Out> {
    public init(of: (In1)->(Out), file: StaticString = #file, line: UInt = #line, function: StaticString = #function){
        super.init(file, line, function)
    }
    public func with(first: In1.Type) -> Self { return self }
    public func with(return: Out.Type) -> Self { return self }

}
public class GenericInferer2<In1,In2,Out>: BaseNonThrowingInferer<(In1,In2),Out> {
    public init(of: (In1,In2)->(Out), file: StaticString = #file, line: UInt = #line, function: StaticString = #function){
        super.init(file, line, function)
    }
    public func with(first: In1.Type) -> Self { return self }
    public func with(second: In2.Type) -> Self { return self }
    public func with(return: Out.Type) -> Self { return self }
}
public class GenericInferer3<In1,In2,In3,Out>: BaseNonThrowingInferer<(In1,In2,In3),Out> {
    public init(of: (In1,In2,In3)->(Out), file: StaticString = #file, line: UInt = #line, function: StaticString = #function){
        super.init(file, line, function)
    }
    public func with(first: In1.Type) -> Self { return self }
    public func with(second: In2.Type) -> Self { return self }
    public func with(third: In3.Type) -> Self { return self }
    public func with(return: Out.Type) -> Self { return self }
}
public class GenericInferer4<In1,In2,In3,In4,Out>: BaseNonThrowingInferer<(In1,In2,In3,In4),Out> {
    public init(of: (In1,In2,In3,In4)->(Out), file: StaticString = #file, line: UInt = #line, function: StaticString = #function){
        super.init(file, line, function)
    }
    public func with(first: In1.Type) -> Self { return self }
    public func with(second: In2.Type) -> Self { return self }
    public func with(third: In3.Type) -> Self { return self }
    public func with(forth: In4.Type) -> Self { return self }
    public func with(return: Out.Type) -> Self { return self }
}
public class GenericInferer5<In1,In2,In3,In4,In5,Out>: BaseNonThrowingInferer<(In1,In2,In3,In4,In5),Out> {
    public init(of: (In1,In2,In3,In4,In5)->(Out), file: StaticString = #file, line: UInt = #line, function: StaticString = #function){
        super.init(file, line, function)
    }
    public func with(first: In1.Type) -> Self { return self }
    public func with(second: In2.Type) -> Self { return self }
    public func with(third: In3.Type) -> Self { return self }
    public func with(forth: In4.Type) -> Self { return self }
    public func with(fifth: In5.Type) -> Self { return self }
    public func with(return: Out.Type) -> Self { return self }
    
}
