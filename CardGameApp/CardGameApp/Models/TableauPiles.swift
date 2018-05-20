//
//  TableauPiles.swift
//  CardGameApp
//
//  Created by yuaming on 17/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class TableauPiles {
  private var cardPiles: [CardStack]
  
  convenience init() {
    self.init([])
  }
  
  init(_ cardPiles: [CardStack]) {
    self.cardPiles = cardPiles
  }
}

extension TableauPiles {
  func reset(with cardDeck: CardDeck) {
    (0...ViewSettings.cardCount-1).forEach { pileIndex in
      cardPiles.append(CardStack())
      
      (0...pileIndex).forEach { _ in
        push(pileIndex: pileIndex, card: cardDeck.choice()!)
      }
    }
  }
  
  func push(pileIndex: Int, card: Card) {
    let cardPile = cardPiles[pileIndex]
    pushCard(pile: cardPile, card: card)
  }
  
  subscript(_ pileIndex: Int) -> CardStack {
    return cardPiles[pileIndex]
  }
  
  var count: Int {
    return cardPiles.count
  }
}

private extension TableauPiles {
  func pushCard(pile: CardStack, card pCard: Card) {
    pile.push(pCard)
  }
}

extension TableauPiles: Sequence {
  func makeIterator() -> GenericIterator<CardStack> {
    return GenericIterator<CardStack>(self.cardPiles)
  }
}
