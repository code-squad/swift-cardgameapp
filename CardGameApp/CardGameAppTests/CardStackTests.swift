//
//  CardStackTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 15/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class CardStackTests: XCTestCase {
  func test_인스턴스_생성() {
    let cardStack = CardStack()
    XCTAssertNotNil(cardStack)
  }
  
  func test_초기화() {
    let cardStack = CardStack()
    cardStack.reset()
    XCTAssertTrue(cardStack.count == 0)
  }
  
  func test_카드덱을_이용하여_초기화() {
    let cardStack = CardStack()
    cardStack.reset(with: CardDeck())
    XCTAssertTrue(cardStack.count == 52)
  }
  
  func test_카드섞으면_비교하는_카드순서와_다른순서를_반환() {
    let cardStack = CardStack()
    cardStack.push(.init(.heart, .ace))
    cardStack.push(.init(.heart, .two))
    cardStack.push(.init(.heart, .four))
    cardStack.shuffle()
    let comparedCardStack = CardStack()
    comparedCardStack.push(.init(.heart, .ace))
    comparedCardStack.push(.init(.heart, .two))
    comparedCardStack.push(.init(.heart, .four))
    XCTAssertFalse(cardStack == comparedCardStack)
  }
  
  func test_카드삽입_길이2_반환() {
    let cardStack = CardStack()
    cardStack.push(.init(.heart, .ace))
    cardStack.push(.init(.heart, .two))
    XCTAssertTrue(cardStack.count == 2)
  }
  
  func test_카드하나_선택_길이1_반환() {
    let cardStack = CardStack()
    cardStack.push(.init(.heart, .ace))
    cardStack.push(.init(.heart, .two))
    _ = cardStack.choice()
    XCTAssertTrue(cardStack.count == 1)
  }
  
  func test_꼭대기_카드선택_하트4_반환() {
    let cardStack = CardStack()
    cardStack.push(.init(.heart, .ace))
    cardStack.push(.init(.heart, .two))
    cardStack.push(.init(.heart, .three))
    cardStack.push(.init(.heart, .four))
    let card = cardStack.last()
    let comparedCard = Card(.heart, .four)
    XCTAssertTrue(card == comparedCard)
  }
}
