//
//  CardStack.swift
//  CardGameApp
//
//  Created by yuaming on 11/05/2018.
//  Copyright © 2018 yuaming. All rights reserved.
//

import Foundation

class CardStack {
  private var cards: [Card] = []
  
  init() {
    reset()
  }
}

extension CardStack {
  func reset() {
    self.cards = []
  }
  
  func reset(with cardDeck: CardDeck) {
    (0..<cardDeck.count).forEach { _ in
      guard let card = cardDeck.choice() else { return }
      push(card)
    }
  }
  
  func shuffle() {
    self.cards = self.cards.shuffle()
  }
  
  func push(_ card: Card) {
    self.cards.append(card)
  }
   
  func choice() -> Card? {
    return cards.popLast()
  }
  
  func choice(at index: Int) -> Card {
    return cards.remove(at: index)
  }
  
  func last() -> Card? {
    return cards.last
  }
  
  var count: Int {
    return cards.count
  }
  
  var isAvailable: Bool {
    return count > 0
  }
  
  subscript(_ cardIndex: Int) -> Card {
    return cards[cardIndex]
  }
}

extension CardStack: Equatable {
  static func ==(lhs: CardStack, rhs: CardStack) -> Bool {
    guard lhs.cards == rhs.cards else { return false }
    
    return true
  }
}

extension CardStack: Sequence {
  func makeIterator() -> CardStackIterator {
    return CardStackIterator(self)
  }
}

class CardStackIterator: IteratorProtocol {
  private let cardStack: CardStack
  private var nextIndex = 0
  
  init(_ cardStack: CardStack) {
    self.cardStack = cardStack
  }
  
  func next() -> Card? {
    defer { nextIndex += 1 }
    guard nextIndex < cardStack.count else { return nil }
    return cardStack[nextIndex]
  }
}
