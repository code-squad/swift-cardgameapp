//
//  Deck.swift
//  CardGame
//
//  Created by Mrlee on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Deck {
    private var cards: [Card]
    
    init() {
        self.cards = [Card]()
        for kindOfSuit in 0..<Card.Suit.allValues.count {
            for kindOfRank in 0..<Card.Rank.allValues.count {
                cards.append(Card(suit: kindOfSuit, rank: kindOfRank))
            }
        }
    }
    
    func count() -> Int {
        return cards.count
    }
    
    mutating func reset() -> Deck {
        let newDeck = Deck()
        return newDeck
    }
    
    mutating func removeOne() -> Card? {
        return self.cards.popLast()
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
    
    mutating func makeStack(numberOfCards: Int) throws -> [Card] {
        return try cards.pop(range: numberOfCards)
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
