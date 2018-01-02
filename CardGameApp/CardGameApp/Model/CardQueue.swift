//
//  CardQueue.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 2..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import Foundation

struct CardQueue {
    private var cards: [Card] = []

    var isEmpty: Bool {
        return cards.isEmpty
    }

    var count: Int {
        return cards.count
    }

    mutating func enqueue(_ card: Card) {
        cards.append(card)
    }

    mutating func dequeue() -> Card? {
        if isEmpty {
            return nil
        }
        return cards.removeFirst()
    }

    var front: Card? {
        return cards.first
    }

}
