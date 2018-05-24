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
  
  init(_ wastePile: CardStack) {
    self.wastePile = wastePile
  }
  
  func push(_ card: Card) {
    wastePile.push(card)
  }
  
  func removeAllCards() {
    let cardStack = CardStack()
    
    wastePile.forEach { _ in
      guard let card = wastePile.choice() else { return }
      cardStack.push(card)
    }
    
    NotificationCenter.default.post(name: .allCardsDidRemove, object: nil, userInfo: ["pile": cardStack])
  }
}

extension Notification.Name {
  static let allCardsDidRemove = Notification.Name(rawValue: "AllCardDidRemove")
}
