//
//  CardDeck.swift
//  CardGame
//
//  Created by jack on 2018. 1. 8..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol DeckControl {
    mutating func shuffle()
    mutating func openTopCard()
    mutating func reset()
    func isEmpty() -> Bool
    mutating func generateOneStack(numberOfStack : Int) -> [Card]
    mutating func addOpenedCardDeck(_ oneCard : Card)
    mutating func loadOpenedCardDeck()
    mutating func getCardFromOpenedCardDeck() -> Card?
}

struct CardDeck : DeckControl {
    private var deck : [Card] = []
    private var openedCardDeck : [Card] = []
    private static var instance : CardDeck = CardDeck()
    
    static func shared() -> CardDeck {
        return instance
    }
    
    private init() {
        for oneSuit in Card.Suits.allCases {
            for oneRank in Card.Ranks.allCases {
                self.deck.append(Card(oneSuit, oneRank))
            }
        }
    }
    
    func isEmpty() -> Bool {
        return self.deck.count == 0
    }
    
    mutating func addOpenedCardDeck(_ oneCard : Card) {
        self.openedCardDeck.append(oneCard)
    }
    
    mutating func shuffle() {
        for _ in self.deck.indices {
            do {
                self.deck.sort { (_,_) in arc4random() < arc4random() }
            }
        }
    }
    
    mutating func openTopCard() {
        let topCard = self.deck.removeLast()
        self.openedCardDeck.append(topCard)
        NotificationCenter.default.post(name: .didTapCardDeck, object: self, userInfo: [Key.Observer.openedCard.name: topCard])
    }
    
    mutating func loadOpenedCardDeck() {
        self.deck = self.openedCardDeck
        self.openedCardDeck = []
    }
    
    mutating func getCardFromOpenedCardDeck() -> Card? {
        guard openedCardDeck.count != 0 else { return nil }
        openedCardDeck.removeLast()
        return openedCardDeck.last
    }
    
    mutating func reset() {
        self.deck = CardDeck().deck
    }
    
    mutating func generateOneStack(numberOfStack : Int) -> [Card] {
        var oneStack : [Card] = []
        for _ in 0...numberOfStack {
            oneStack.append(self.deck.removeLast())
        }
        return oneStack
    }
    
}

