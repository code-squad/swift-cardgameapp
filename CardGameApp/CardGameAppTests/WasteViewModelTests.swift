//
//  WasteViewModelTests.swift
//  CardGameAppTests
//
//  Created by yuaming on 20/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import XCTest
@testable import CardGameApp

class WasteViewModelTests: XCTestCase {
  let mockGameViewController = MockGameViewController()
  
  func test_인스턴스_생성() {
    let wasteViewModel = WasteViewModel(CardStack())
    XCTAssertNotNil(wasteViewModel)
  }
  
  func test_여러개_CardViewModel_추가() {
    let cardStack = CardStack()
    cardStack.push(.init(.club, .ace))
    cardStack.push(.init(.club, .two))
    
    let wasteViewModel = WasteViewModel(cardStack)
    wasteViewModel.delegate = mockGameViewController
    wasteViewModel.updateCardViewModels()
    
    XCTAssert(wasteViewModel.isAvailable == true)
  }
  
  func test_한개_CardViewModel_추가() {
    let cardStack = CardStack()
    cardStack.push(.init(.club, .ace))
    cardStack.push(.init(.club, .two))
    
    let wasteViewModel = WasteViewModel(cardStack)
    wasteViewModel.delegate = mockGameViewController
    wasteViewModel.updateCardViewModel(cardStack.choice()!, isTurnedOver: true)
    
    XCTAssert(wasteViewModel.isAvailable == true)
  }
}
