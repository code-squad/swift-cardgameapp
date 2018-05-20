//
//  WasteViewModel.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class WasteViewModel {
  private var wastePile: CardStack
  var delegate: GameViewControllerDelegate?
  
  init(_ wastePile: CardStack) {
    self.wastePile = wastePile
  }
  
  func updateCardViewModels() {
    guard wastePile.isAvailable else {
      delegate?.updateEmptyViewInWastePile()
      return
    }
    
    wastePile.forEach {
      updateCardViewModel($0, isTurnedOver: true)
    }
  }
  
  func updateCardViewModel(_ card: Card, isTurnedOver: Bool = false) {
    delegate?.updateCardViewModelInWastePile(CardViewModel(card: card, isTurnedOver: isTurnedOver))
  }
  
  func push(_ card: Card) {
    wastePile.push(card)
  }
  
  func removeAllCards() -> CardStack? {
    let cardStack: CardStack = CardStack()
    wastePile.forEach { _ in
      guard let card = wastePile.choice() else { return }
      cardStack.push(card)
    }
    return cardStack
  }
  
  var isAvailable: Bool {
    return wastePile.isAvailable
  }
}
