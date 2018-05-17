//
//  GameViewModelTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class GameViewModelTests: XCTestCase {
  func test_인스턴스_생성() {
    let gameViewModel = GameViewModel()
    XCTAssertNotNil(gameViewModel)
  }
  
  func test_초기화() {
    let gameViewModel = GameViewModel()
    gameViewModel.initialize()
    XCTAssert(gameViewModel.wastePile.count == 0)
    XCTAssert(gameViewModel.extraPile.count == 52)
  }
}
