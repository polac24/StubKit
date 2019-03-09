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


public class SetupSequence2<I1,I2,O>: SetupSequence<(I1,I2),O> {}

extension SetupSequence2 where I1: Equatable {
    public func whenFirst(_ i:I1) -> Self{
        filters.append { v -> Bool in
            v.0 == i
        }
        return self
    }
}
extension SetupSequence2 where I2: Equatable {
    public func whenSecond(_ i:I2) -> Self{
        filters.append { v -> Bool in
            v.1 == i
        }
        return self
    }
}


public class SetupSequence3<I1,I2,I3,O>: SetupSequence<(I1,I2,I3),O> {}

extension SetupSequence3 where I1: Equatable {
    public func whenFirst(_ i:I1) -> Self{
        filters.append { v -> Bool in
            v.0 == i
        }
        return self
    }
}
extension SetupSequence3 where I2: Equatable {
    public func whenSecond(_ i:I2) -> Self{
        filters.append { v -> Bool in
            v.1 == i
        }
        return self
    }
}

extension SetupSequence3 where I3: Equatable {
    public func whenThird(_ i:I3) -> Self{
        filters.append { v -> Bool in
            v.2 == i
        }
        return self
    }
}

public class SetupSequence4<I1,I2,I3,I4,O>: SetupSequence<(I1,I2,I3,I4),O> {}

extension SetupSequence4 where I1: Equatable {
    public func whenFirst(_ i:I1) -> Self{
        filters.append { v -> Bool in
            v.0 == i
        }
        return self
    }
}
extension SetupSequence4 where I2: Equatable {
    public func whenSecond(_ i:I2) -> Self{
        filters.append { v -> Bool in
            v.1 == i
        }
        return self
    }
}

extension SetupSequence4 where I3: Equatable {
    public func whenThird(_ i:I3) -> Self{
        filters.append { v -> Bool in
            v.2 == i
        }
        return self
    }
}

extension SetupSequence4 where I4: Equatable {
    public func whenThird(_ i:I4) -> Self{
        filters.append { v -> Bool in
            v.3 == i
        }
        return self
    }
}
