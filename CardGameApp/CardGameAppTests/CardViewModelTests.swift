//
//  CardViewModelTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class CardViewModelTests: XCTestCase {
  func test_인스턴스_생성() {
    let cardViewModel = CardViewModel(card: Card(.heart, .ace))
    XCTAssertNotNil(cardViewModel)
  }
  
  func test_카드_뒷면_이미지_반환() {
    let cardViewModel = CardViewModel(card: Card(.heart, .ace))
    XCTAssertTrue(cardViewModel.getCardImage() == Image.cardBack)
  }
  
  func test_카드_앞면_이미지이름_반환() {
    let cardViewModel = CardViewModel(card: Card(.heart, .ace), status: .front)
    XCTAssertTrue(cardViewModel.getCardImage() == UIImage(imageLiteralResourceName: "hA"))
  }
}
