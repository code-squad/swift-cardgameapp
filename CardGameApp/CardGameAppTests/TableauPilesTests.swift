//
//  TableauPilesTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 21/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class TableauPilesTests: XCTestCase {
  func test_인스턴스_생성() {
    let tableauPiles = TableauPiles()
    XCTAssertNotNil(tableauPiles)
  }
  
  func test_초기화_7개_배열_반환() {
    let cardDeck = CardDeck()
    let tableauPiles = TableauPiles()
    tableauPiles.reset(with: cardDeck)
    XCTAssert(tableauPiles[0].count == 1)
    XCTAssert(tableauPiles[1].count == 2)
    XCTAssert(tableauPiles[2].count == 3)
    XCTAssert(tableauPiles[3].count == 4)
    XCTAssert(tableauPiles[4].count == 5)
    XCTAssert(tableauPiles[5].count == 6)
    XCTAssert(tableauPiles[6].count == 7)
  }
  
  func test_두번째_배열_카드삽입_길이가_5개_반환() {
    let cardDeck = CardDeck()
    let tableauPiles = TableauPiles()
    tableauPiles.reset(with: cardDeck)
    tableauPiles.push(pileIndex: 3, card: cardDeck.choice()!)
    XCTAssert(tableauPiles[3].count == 5)
  }
}
