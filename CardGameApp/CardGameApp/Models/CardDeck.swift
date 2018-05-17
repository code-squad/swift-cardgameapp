//
//  CardDeck.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class CardDeck {
  private var cardStack: CardStack = CardStack()
  
  init() {
    reset()
  }
}

extension CardDeck {
  func reset() {
    self.cardStack = CardStack()
    
    for suit in Suit.allValues {
      for number in Number.allValues {
        self.cardStack.push(generateCard(suit, number))
      }
    }
  }
  
  func shuffle() {
    cardStack.shuffle()
  }
  
  func push(_ card: Card) {
    cardStack.push(card)
  }
  
  func choice() -> Card? {    
    return choiceCard()
  }
  
  func last() -> Card? {
    return cardStack.last()
  }
  
  var count: Int {
    return cardStack.count
  }
}

private extension CardDeck {
  func generateCard(_ suit: Suit, _ number: Number) -> Card {
    return Card(suit, number)
  }
  
  func generateRandomInt() -> Int {
    return Int(arc4random_uniform(UInt32(cardStack.count)))
  }
  
  func choiceCard() -> Card {
    return cardStack.choice(at: generateRandomInt())
  }
}

extension CardDeck: Equatable {
  static func ==(lhs: CardDeck, rhs: CardDeck) -> Bool {
    guard lhs.cardStack == rhs.cardStack else { return false }
    
    return true
  }
}
