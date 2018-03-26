//
//  Deck.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Deck {
    private (set) var cards: [Card]
    
    init() {
        self.cards = [Card]()
        for kindOfSuit in 0..<Card.Suit.allValues.count {
            for kindOfRank in 0..<Card.Rank.allValues.count {
                cards.append(Card(suit: kindOfSuit, rank: kindOfRank))
            }
        }
    }
    
    init(cards: [Card]) {
        self.cards = cards
    }
        
    func count() -> Int {
        return cards.count
    }
    
    mutating func reset() -> Deck {
        let newDeck = Deck()
        return newDeck
    }
    
    func lastCard() -> Card? {
        return self.cards.last
    }
    
    mutating func popCard() -> Card? {
        return self.cards.popLast()
    }
    
    mutating func pushCard(_ card: Card) {
        self.cards.append(card)
    }
    
    // Fisher-Yates Shuffle
    mutating func shuffle() {
        var suffledCards = [Card]()
        for _ in cards {
            let roll = arc4random_uniform(UInt32(self.cards.count))
            suffledCards.append(self.cards[Int(roll)])
            self.cards.remove(at: Int(roll))
        }
        self.cards = suffledCards
    }
    
    mutating func makeStack(numberOfCards: Int) throws -> Deck {
        return Deck(cards: try cards.pop(range: numberOfCards))
    }
    
    func getRestDeck() -> [Card] {
        return cards
    }
    
    func isEmptyDeck() -> Bool {
        return cards.isEmpty
    }
    
    func isSameGroup(_ card: Card) -> Bool {
        for cardSuit in cards {
            if cardSuit.getCalculatedSuit() == card.getCalculatedSuit() {
                return true
            }
        }
        return false
    }
}

extension Array {
    
    mutating func pop(range: Int) throws -> [Element] {
        let startIndexOfStack = self.index(self.endIndex, offsetBy: -(range + 1))
        let popRange = self.index(after: startIndexOfStack)..<self.endIndex
        if startIndexOfStack < -1 {
            throw ErrorCode.zeroCard
        }
        let popContents = Array(self[popRange])
        self.removeSubrange(popRange)
        return popContents
    }
    
}
