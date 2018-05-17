//
//  CardDeckTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 09/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class CardDeckTests: XCTestCase {
  func test_인스턴스_생성() {
    let cardDeck = CardDeck()
    XCTAssertTrue(cardDeck.count == 52)
  }
  
  func test_초기화() {
    let cardDeck = CardDeck()
    cardDeck.reset()
    XCTAssertTrue(cardDeck.count == 52)
  }
  
  func test_카드섞음_초기생성된_카드순서와_다른순서를_반환() {
    let cardDeck = CardDeck()
    cardDeck.shuffle()
    let comparedCardDeck = CardDeck()
    XCTAssertFalse(cardDeck == comparedCardDeck)
  }
  
  func test_카드삽입_길이53_반환() {
    let cardDeck = CardDeck()
    cardDeck.push(.init(.club, .ace))
    XCTAssertTrue(cardDeck.count == 53)
  }
  
  func test_카드하나_선택_길이51_반환() {
    let cardDeck = CardDeck()
    _ = cardDeck.choice()
    XCTAssertTrue(cardDeck.count == 51)
  }
  
  func test_꼭대기_카드선택_스페이드킹_반환() {
    let cardDeck = CardDeck()
    let card = cardDeck.last()
    let comparedCard = Card(.spade, .king)
    XCTAssertTrue(card == comparedCard)
  }
}
