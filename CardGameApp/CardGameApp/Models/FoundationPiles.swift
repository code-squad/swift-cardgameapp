//
//  FoundationPiles.swift
//  CardGameApp
//
//  Created by yuaming on 18/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class FoundationPiles {
  private var cardPiles: [CardStack]
  
  convenience init() {
    self.init([])
  }
  
  init(_ cardPiles: [CardStack]) {
    self.cardPiles = cardPiles
  }
}

extension FoundationPiles {
  func reset() {
    self.cardPiles = []
  }
  
  subscript(_ pileIndex: Int) -> CardStack {
    return cardPiles[pileIndex]
  }
  
  var count: Int {
    return cardPiles.count
  }
  
  var isAvailable: Bool {
    return count > 0
  }
}

private extension FoundationPiles {
  func pushCard(pile: CardStack, card pCard: Card) {
    guard let card = pile.last() else { return }
    
    let nextNumber = card.number.rawValue + 1
    guard card.suit == pCard.suit && nextNumber == pCard.number.rawValue else {
      return
    }
    
    pushCard(pile: pile, card: pCard)
  }
}

extension FoundationPiles: Sequence {
  func makeIterator() -> GenericIterator<CardStack> {
    return GenericIterator<CardStack>(self.cardPiles)
  }
}
