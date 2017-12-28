//
//  CardStack.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import Foundation

struct CardStack {
    var cards = [Card]()

    var isEmpty: Bool {
        return cards.isEmpty
    }

    var count: Int {
        return cards.count
    }

    var top: Card? {
        return cards.last
    }


    mutating func push(card: Card) {
        cards.append(card)
    }

    mutating func pop() -> Card? {
        return cards.popLast()
    }



}
