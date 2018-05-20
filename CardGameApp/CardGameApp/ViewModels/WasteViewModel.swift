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
    guard isAvailable else {
      delegate?.updateEmptyViewInWastePile()
      return
    }
    
    wastePile.forEach {
      updateCardViewModel($0, status: .front)
    }
  }
  
  func updateCardViewModel(_ card: Card, status: CardViewModel.Status) {
    delegate?.updateCardViewModelInWastePile(CardViewModel(card: card, status: status))
  }
  
  func push(_ card: Card) {
    wastePile.push(card)
  }
  
  func removeAllCards() -> CardStack? {
    let cardStack: CardStack = CardStack()
    wastePile.forEach { cardStack.push($0) }
    return cardStack
  }
  
  var isAvailable: Bool {
    return wastePile.count > 0
  }
}
