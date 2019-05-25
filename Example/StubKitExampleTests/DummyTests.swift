//
//  DummyTests.swift
//  StubKitExampleTests
//
//  Created by Bartosz Polaczyk on 25/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import StubKit
@testable import StubKitExample

class DummyTests: XCTestCase {
    
    func testA() {
        print("testing A")
        XCTAssertEqual(Dummy().a(), 1)
    }

}
