//
//  CardStack.swift
//  CardGame
//
//  Created by 윤지영 on 15/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardStack: CustomStringConvertible {
    private var cards: [Card]

    init(cards: [Card]) {
        self.cards = cards
    }

    func push(_ card: Card) {
        cards.append(card)
    }

    func reset() {
        cards.removeAll()
    }

    var count: Int {
        return cards.count
    }

    var description: String {
        let allCards = cards
            .map { "\($0)" }
            .joined(separator: ", ")
        return "[\(allCards)]"
    }

}

extension CardStack {

    func iterateCards(_ deliver: (Card) -> Void) {
        for card in cards {
            deliver(card)
        }
    }

    func accessCard(at index: Int, deliver: (Card) -> Void) {
        guard index < cards.count else { return }
        deliver(cards[index])
    }

}
