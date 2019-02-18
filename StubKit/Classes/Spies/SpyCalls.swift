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

public func spyCalls<I,O,R: Recorder>(of stub: inout (I) -> (O), recorder: R.Type)  -> R where R.Element == I{
    let records = R()
    let originalStub = stub
    stub = { [weak weakRecords = records] arg in
        weakRecords?.record(arg)
        return originalStub(arg)
    }
    return records
}

public func spyCalls<I,O>(of stub: inout (I) -> (O)) -> ArgRecords<I> {
    return spyCalls(of: &stub, recorder: ArgRecords<I>.self)
}
public func spyWeaklyCalls<I: AnyObject,O>(of stub: inout (I) -> (O)) -> ArgWeakRecords<I>{
    return spyCalls(of: &stub, recorder: ArgWeakRecords<I>.self)
}

public func spyCalls<I,O,R: Recorder>(of stub: inout (I) throws -> (O), recorder: R.Type)  -> R where R.Element == I{
    let records = R()
    let originalStub = stub
    stub = { [weak weakRecords = records] arg in
        weakRecords?.record(arg)
        return try originalStub(arg)
    }
    return records
}

public func spyCalls<I,O>(of stub: inout (I) throws -> (O)) -> ArgRecords<I> {
    return spyCalls(of: &stub, recorder: ArgRecords<I>.self)
}
public func spyWeaklyCalls<I: AnyObject,O>(of stub: inout (I) throws -> (O)) -> ArgWeakRecords<I> {
    return spyCalls(of: &stub, recorder: ArgWeakRecords<I>.self)
}

