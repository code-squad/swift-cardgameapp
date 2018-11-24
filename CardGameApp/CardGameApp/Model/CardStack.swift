//
//  CardStack.swift
//  CardGameApp
//
//  Created by oingbong on 17/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct CardStack {
    private var cards = [Card]()
    
    var count: Int {
        return cards.count
    }
    var lastCard: Card? {
        return cards[count - 1]
    }
    
    mutating func push(_ card: Card) {
        cards.append(card)
    }
    
    mutating func pop() -> Card? {
        return cards.popLast()
    }
    
    mutating func specifiedPop(at index: Int) -> Card? {
        return cards.remove(at: index)
    }
    
    func list() -> [Card] {
        return cards
    }
    
    mutating func removeAll() {
        return cards = [Card]()
    }
    
    func info() -> Card? {
        return cards.last
    }
    
    func hasCard() -> Bool {
        return cards.count > 0 ? true : false
    }
}

extension CardStack {
    subscript(index: Int) -> Card {
        return cards[index]
    }
}
