//
//  WasteModel.swift
//  CardGameApp
//
//  Created by oingbong on 14/11/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

class WasteModel {
    private var cards = [Card]()
    
    var count: Int {
        return cards.count
    }
    var lastCard: Card? {
        return cards[count - 1]
    }
    
    func push(_ card: Card) {
        cards.append(card)
    }
    
    func pop() -> Card? {
        return cards.popLast()
    }
    
    func list() -> [Card] {
        return cards
    }
    
    func removeAll() {
        return cards = [Card]()
    }
    
    func info() -> Card? {
        return cards.last
    }
}
