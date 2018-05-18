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
  
  func push(pileIndex: Int, card: Card) {
    let cardPile = cardPiles[pileIndex]
    
    if cardPile.count > 0 {
      pushNonFirstCard(pile: cardPile, card: card)
    } else {
      pushCard(pile: cardPile, card: card)
    }
  }
  
  var count: Int {
    return cardPiles.count
  }
  
  subscript(_ pileIndex: Int) -> CardStack {
    return cardPiles[pileIndex]
  }
}

private extension FoundationPiles {
  func pushNonFirstCard(pile: CardStack, card pCard: Card) {
    guard let card = pile.last() else { return }
    
    let nextNumber = card.number.rawValue + 1
    guard card.suit == pCard.suit && nextNumber == pCard.number.rawValue else {
      return
    }
    
    pushCard(pile: pile, card: pCard)
  }
  
  func pushCard(pile: CardStack, card pCard: Card) {
    pile.push(pCard)
  }
}
