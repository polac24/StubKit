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

public func stubGeneric<In1,Out>(of: (In1)->Out) -> GenericInferer1<In1,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,Out>(of: (In1,In2)->Out) -> GenericInferer2<In1,In2,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,In3,Out>(of: (In1,In2,In3)->Out) -> GenericInferer3<In1,In2,In3,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,In3,In4,Out>(of: (In1,In2,In3,In4)->Out) -> GenericInferer4<In1,In2,In3,In4,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,In3,In4,In5,Out>(of: (In1,In2,In3,In4,In5)->Out) -> GenericInferer5<In1,In2,In3,In4,In5,Out> {
    return .init(of: of)
}


public func stubGeneric<In1,Out>(of: (In1) throws ->Out) -> GenericThrowingInferer1<In1,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,Out>(of: (In1,In2) throws ->Out) -> GenericThrowingInferer2<In1,In2,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,In3,Out>(of: (In1,In2,In3) throws ->Out) -> GenericThrowingInferer3<In1,In2,In3,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,In3,In4,Out>(of: (In1,In2,In3,In4) throws ->Out) -> GenericThrowingInferer4<In1,In2,In3,In4,Out> {
    return .init(of: of)
}
public func stubGeneric<In1,In2,In3,In4,In5,Out>(of: (In1,In2,In3,In4,In5) throws ->Out) -> GenericThrowingInferer5<In1,In2,In3,In4,In5,Out> {
    return .init(of: of)
}
