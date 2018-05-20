//
//  FoundationPilesTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 21/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class FoundationPilesTests: XCTestCase {
  func test_인스턴스_생성() {
    let foundationPiles = FoundationPiles()
    XCTAssertNotNil(foundationPiles)
  }
  
  func test_초기화_빈배열_반환() {
    let foundationPiles = FoundationPiles()
    foundationPiles.reset()
    XCTAssert(foundationPiles.count == 0)
  }
}
