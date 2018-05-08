//
//  CardDeck.swift
//  CardGameApp
//
//  Created by yuaming on 08/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class CardDeck {
  private static var sharedInstance = CardDeck()
  private var cards: [Card] = [] {
    didSet {
      NotificationCenter.default.post(name: Notification.Name.cardDeck, object: self)
    }
  }
  
  init() {
    reset()
  }
  
  func reset() {
    resetCards()
  }
  
  var count: Int {
    return cards.count
  }
  
  var isAvailable: Bool {
    return self.count > 0
  }
  
  func remove() throws -> Card {
    guard self.count > 0 else {
      throw CardErrors.notEnoughCards
    }
    
    return removeCard()
  }
  
  func shuffle() {
    shuffleCards()
  }
  
  static func share() -> CardDeck {
    return sharedInstance
  }
}

private extension CardDeck {
  func resetCards() {
    self.cards = []
    
    for suit in Suit.allValues {
      for number in Number.allValues {
        self.cards.append(generateCard(suit, number))
      }
    }
  }
  
  func generateCard(_ suit: Suit, _ number: Number) -> Card {
    return Card(suit, number)
  }
  
  func generateRandomInt() -> Int {
    return Int(arc4random_uniform(UInt32(cards.count)))
  }
  
  func removeCard() -> Card {
    return self.cards.remove(at: generateRandomInt())
  }
  
  func shuffleCards() {
    self.cards = self.cards.shuffle()
  }
}

extension CardDeck: Equatable {
  static func ==(lhs: CardDeck, rhs: CardDeck) -> Bool {
    guard lhs.cards == rhs.cards else { return false }
    
    return true
  }
}
