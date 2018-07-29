//
//  CardDeck.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

class CardDeck {
    
    private var cards = [Card]()
    private var pickCards = [Card]()
    
    init() {
        for suit in Card.Suit.suits {
            for rank in Card.Rank.ranks {
                self.cards.append(Card.init(suit, rank))
            }
        }
    }
    
    func count() -> Int {
        return self.cards.count
    }
    
    func shuffle() -> [Card] {
        for i in 0..<cards.count {
            let randomCard: UInt32 = arc4random_uniform(UInt32(cards.count-1))
            let j = Int(randomCard)
            guard i != j else { continue }
            self.cards.swapAt(i, j)
        }
        return self.cards
    }
    
    func removeOne() -> (basic: [Card], pick: Card) {
        let removeCard = self.cards.removeLast()
        pickCards.append(removeCard)
        return (self.cards, removeCard)
    }
    
    func reset() -> [Card] {
        self.cards = CardDeck().cards
        return self.cards
    }
    
    func getCards() -> [Card] {
        return self.cards
    }
    
}

