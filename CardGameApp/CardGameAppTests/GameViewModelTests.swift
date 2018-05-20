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
    XCTAssert(gameViewModel.extraPile.count == 24)
    XCTAssert(gameViewModel.foundationPiles.count == 0)
    XCTAssert(gameViewModel.tableauPiles.count == 7)
    XCTAssert(gameViewModel.tableauPiles[0].count == 1)
    XCTAssert(gameViewModel.tableauPiles[1].count == 2)
    XCTAssert(gameViewModel.tableauPiles[2].count == 3)
    XCTAssert(gameViewModel.tableauPiles[3].count == 4)
    XCTAssert(gameViewModel.tableauPiles[4].count == 5)
    XCTAssert(gameViewModel.tableauPiles[5].count == 6)
    XCTAssert(gameViewModel.tableauPiles[6].count == 7)
  }
}
