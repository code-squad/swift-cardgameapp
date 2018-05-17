//
//  ExtraPileViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class ExtraPileViewModel {
  var delegate: GameViewControllerProtocol?
  private(set) var extraPile: CardStack
  
  init(_ extraPile: CardStack) {
    self.extraPile = extraPile
  }
  
  func addCardViewModels() {
    guard isAvailable else {
      delegate?.setEmptyViewInExtraPile()
      return
    }
    
    extraPile.forEach {
      addCardViewModel($0)
    }
  }
  
  func addCardViewModel(_ card: Card, status: CardViewModel.Status = .back) {
    delegate?.setCardViewModelInExtraPile(CardViewModel(card: card, status: status))
  }
  
  func setRefresh() {
    delegate?.setRefreshViewInExtraPile()
  }
  
  func choiceOneCard() -> Card? {
    return extraPile.choice()
  }
  
  func store(with data: CardStack) {
    self.extraPile = data
  }
  
  var isAvailable: Bool {
    return extraPile.count > 0
  }
}
