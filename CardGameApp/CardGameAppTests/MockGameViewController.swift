//
//  MockGameViewController.swift
//  CardGameAppTests
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation
import XCTest
@testable import CardGameApp

class MockGameViewController: GameViewControllerDelegate {
  var expectationForSetCardViewModelInExtraPile: XCTestExpectation?
  var expectationForSetCardViewModelInWastePile: XCTestExpectation?
  var expectationForSetEmptyViewInExtraPile: XCTestExpectation?
  var expectationForSetEmptyViewInWastePile: XCTestExpectation?
  var expectationForSetRefreshViewInExtraPile: XCTestExpectation?
  
  func setCardViewModelInExtraPile(_ cardViewModel: CardViewModel) {
    expectationForSetCardViewModelInExtraPile?.fulfill()
  }
  
  func setCardViewModelInWastePile(_ cardViewModel: CardViewModel) {
    expectationForSetCardViewModelInWastePile?.fulfill()
  }
  
  func setEmptyViewInExtraPile() {
    expectationForSetEmptyViewInExtraPile?.fulfill()
  }
  
  func setEmptyViewInWastePile() {
    expectationForSetEmptyViewInWastePile?.fulfill()
  }
  
  func setRefreshViewInExtraPile() {
    expectationForSetRefreshViewInExtraPile?.fulfill()
  }
}
