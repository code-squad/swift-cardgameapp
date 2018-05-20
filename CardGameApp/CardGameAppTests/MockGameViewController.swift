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
  var expectationForUpdateCardViewModelInExtraPile: XCTestExpectation?
  var expectationForUpdateCardViewModelInWastePile: XCTestExpectation?
  var expectationForUpdateEmptyViewInExtraPile: XCTestExpectation?
  var expectationForUpdateEmptyViewInWastePile: XCTestExpectation?
  var expectationForUpdateRefreshViewInExtraPile: XCTestExpectation?
  
  func updateCardViewModelInExtraPile(_ cardViewModel: CardViewModel) {
    expectationForUpdateCardViewModelInExtraPile?.fulfill()
  }
  
  func updateCardViewModelInWastePile(_ cardViewModel: CardViewModel) {
    expectationForUpdateCardViewModelInWastePile?.fulfill()
  }
  
  func updateEmptyViewInExtraPile() {
    expectationForUpdateEmptyViewInExtraPile?.fulfill()
  }
  
  func updateEmptyViewInWastePile() {
    expectationForUpdateEmptyViewInWastePile?.fulfill()
  }
  
  func updateRefreshViewInExtraPile() {
    expectationForUpdateRefreshViewInExtraPile?.fulfill()
  }
}
