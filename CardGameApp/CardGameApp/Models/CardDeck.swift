//
//  CardDeck.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class CardDeck {
  private var cards: [Card] = []
  
  init() {
    reset()
  }
}

extension CardDeck {
  func reset() {
    self.cards = []
    
    for suit in Suit.allValues {
      for number in Number.allValues {
        self.cards.append(generateCard(suit, number))
      }
    }
  }
  
  func shuffle() {
    self.cards = cards.shuffle()
  }
  
  func push(_ card: Card) {
    cards.append(card)
  }
  
  func choice() -> Card? {    
    return choiceCard()
  }
  
  func last() -> Card? {
    return cards.last
  }
  
  var count: Int {
    return cards.count
  }
}

private extension CardDeck {
  func generateCard(_ suit: Suit, _ number: Number) -> Card {
    return Card(suit, number)
  }
  
  func generateRandomInt() -> Int {
    return Int(arc4random_uniform(UInt32(cards.count)))
  }
  
  func choiceCard() -> Card {
    return cards.remove(at: generateRandomInt())
  }
}

extension CardDeck: Equatable {
  static func ==(lhs: CardDeck, rhs: CardDeck) -> Bool {
    guard lhs.cards == rhs.cards else { return false }
    
    return true
  }
}
