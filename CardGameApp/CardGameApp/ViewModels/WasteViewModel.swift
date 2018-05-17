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
  var delegate: GameViewControllerProtocol?
  
  init(_ wastePile: CardStack) {
    self.wastePile = wastePile
  }
  
  func addCardViewModels() {
    guard isAvailable else {
      delegate?.setEmptyViewInWastePile()
      return
    }
    
    wastePile.forEach {
      addCardViewModel($0, status: .front)
    }
  }
  
  func addCardViewModel(_ card: Card, status: CardViewModel.Status) {
    delegate?.setCardViewModelInWastePile(CardViewModel(card: card, status: status))
  }
  
  func push(_ card: Card) {
    wastePile.push(card)
  }
  
  func removeAllCards() -> CardStack? {
    let cardStack: CardStack = CardStack()
    
    (0..<wastePile.count).forEach { _ in
      guard let card = wastePile.choice() else { return }
      cardStack.push(card)
    }
    
    return cardStack
  }
  
  var isAvailable: Bool {
    return wastePile.count > 0
  }
}
