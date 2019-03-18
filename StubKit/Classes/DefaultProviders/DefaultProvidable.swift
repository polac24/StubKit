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

import Foundation

public protocol DefaultProvidable {
    static var defaultValue:Self {get}
}


extension Bool: DefaultProvidable {
    public static let defaultValue = false
}


extension String: DefaultProvidable {
    public static let defaultValue = ""
}

//Numerics

extension Int: DefaultProvidable {
    public static let defaultValue = 0
}
extension UInt: DefaultProvidable {
    public static var defaultValue:UInt = 0
}
extension Double: DefaultProvidable {
    public static let defaultValue:Double = 0
}
extension Decimal: DefaultProvidable {
    public static let defaultValue:Decimal = 0
}
extension CGFloat: DefaultProvidable {
    public static let defaultValue:CGFloat = 0
}


// Containers
extension Data: DefaultProvidable {
    public static let defaultValue = Data(capacity: 0)
}
extension Array: DefaultProvidable {
    public static var defaultValue:Array<Element> {return []}
}

extension Dictionary: DefaultProvidable {
    public static var defaultValue:Dictionary<Key, Value> {return [:]}
}
extension Set: DefaultProvidable {
    public static var defaultValue:Set<Element> {return []}
}

extension Optional: DefaultProvidable {
    public static var defaultValue:Optional<Wrapped> {return nil}
}
extension Date: DefaultProvidable {
    public static let defaultValue:Date = Date(timeIntervalSince1970: 0)
}
extension Calendar: DefaultProvidable {
    public static let defaultValue = Calendar(identifier: Calendar.Identifier.iso8601)
}
extension TimeZone: DefaultProvidable {
    public static let defaultValue = TimeZone.current
}

extension Locale: DefaultProvidable {
    public static let defaultValue = Locale(identifier: "")
}
extension URL : DefaultProvidable {
    public static var defaultValue: URL = URL(fileURLWithPath: "/")
}
extension URLComponents : DefaultProvidable {
    public static var defaultValue:URLComponents = URLComponents()
}
extension URLQueryItem : DefaultProvidable {
    public static var defaultValue = URLQueryItem(name: "", value: nil)
}
