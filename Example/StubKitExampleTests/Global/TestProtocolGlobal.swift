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

protocol TestProtocolGlobal {
    func takeObject(_ obj:AnyObject)
    func takeObjectEquatable(_ obj:MyClassGlobal)
    func returnObject() -> AnyObject
    func takeValueType(_ struct: MyStructGlobal)
    func returnValueType() -> MyStructGlobal
    func takeDefaultableValueType(_ number: Int)
    func returnDefautableValueType() -> Int
    func takeCustomDefaultableValueType(_ number: DefautableStructGlobal)
    func returnCustomDefautableValueType() -> DefautableStructGlobal
    func takeTwoArgs(v1: Int, v2: String)
    func returnTuple() -> (Int, String)
    func takeTupleNamed(_ tuple: (v1: Int, v2: String))
    func returnTupleNamed() -> (v1: Int, v2: String)
    func takeEscaping(_: @escaping (Int) -> (String))
    func takeTwoEscaping(_: @escaping (Int) -> (String), _: @escaping (String) -> (Int))
    func takeNonscaping(_: (Int) -> (String))
    func returnFunction() -> ((Int) -> (String))
    func takeAutoclosureString(_: @autoclosure () -> (String))
    func takeAutoclosureStringWithOther(_: @autoclosure () -> (String), other: String)
// Not supported
//    func takeVarArgs(_: Int...)
//    func takeVarArgsAndOther(_: Int..., other: String)
}
