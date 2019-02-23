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

 protocol TestProtocolGlobalThrowing {
    func takeObjectThrowing(_ obj:AnyObject) throws
    func returnObjectThrowing() throws -> AnyObject
    func takeValueTypeThrowing(_ struct: MyStructGlobal) throws
    func returnValueTypeThrowing() throws -> MyStructGlobal
    func takeDefaultableValueTypeThrowing(_ number: Int) throws
    func returnDefautableValueTypeThrowing() throws -> Int
    func takeCustomDefaultableValueTypeThrowing(_ number: DefautableStructGlobal) throws
    func returnCustomDefautableValueTypeThrowing() throws -> DefautableStructGlobal
    func takeTwoArgsThrowing(v1: Int, v2: String) throws
    func returnTupleThrowing() throws -> (Int, String)
    func takeTupleNamedThrowing(_ tuple: (v1: Int, v2: String)) throws
    func returnTupleNamedThrowing() throws -> (v1: Int, v2: String)
    func takeEscapingThrowing(_: @escaping (Int) -> (String)) throws
    func takeNonscapingThrowing(_: (Int) -> (String)) throws
    func returnFunctionThrowing() throws -> ((Int) -> (String))
    func takeAutoclosureStringThrowing(_: @autoclosure () -> (String)) throws
    func takeAutoclosureStringWithOtherThrowing(_: @autoclosure () -> (String), other: String) throws
}
