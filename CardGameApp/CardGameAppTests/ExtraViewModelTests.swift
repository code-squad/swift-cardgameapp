//
//  ExtraViewModelTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class ExtraViewModelTests: XCTestCase {
  let mockGameViewController = MockGameViewController()
  
  func test_인스턴스_생성() {
    let extraViewModel = ExtraPileViewModel(CardStack())
    XCTAssertNotNil(extraViewModel)
  }
  
  func test_여러개_CardViewModel_추가() {
    let cardStack = CardStack()
    cardStack.push(.init(.club, .ace))
    cardStack.push(.init(.club, .two))
    
    let extraViewModel = ExtraPileViewModel(cardStack)
    extraViewModel.delegate = mockGameViewController
    extraViewModel.updateCardViewModels()
    
    XCTAssert(extraViewModel.isAvailable == true)
  }
  
  func test_한개_CardViewModel_추가() {
    let cardStack = CardStack()
    cardStack.push(.init(.club, .ace))
    cardStack.push(.init(.club, .two))
    
    let extraViewModel = ExtraPileViewModel(cardStack)
    extraViewModel.delegate = mockGameViewController
    extraViewModel.updateCardViewModel(cardStack.choice()!, isTurnedOver: true)
    
    XCTAssert(extraViewModel.isAvailable == true)
  }
}
