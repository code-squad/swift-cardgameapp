//
//  ExtraPileViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class ExtraPileViewModel {
  var delegate: GameViewControllerDelegate?
  private(set) var extraPile: CardStack
  
  init(_ extraPile: CardStack) {
    self.extraPile = extraPile
  }
  
  func updateCardViewModels() {
    guard extraPile.isAvailable else {
      delegate?.updateEmptyViewInExtraPile()
      return
    }
    
    extraPile.forEach {
      updateCardViewModel($0)
    }
  }
  
  func updateCardViewModel(_ card: Card, isTurnedOver: Bool = false) {
    delegate?.updateCardViewModelInExtraPile(CardViewModel(card: card, isTurnedOver: isTurnedOver))
  }
  
  func refresh() {
    delegate?.updateRefreshViewInExtraPile()
  }
  
  func choiceOneCard() -> Card? {
    return extraPile.choice()
  }
  
  func store(with data: CardStack) {
    self.extraPile = data
  }
  
  var isAvailable: Bool {
    return extraPile.isAvailable
  }
}
