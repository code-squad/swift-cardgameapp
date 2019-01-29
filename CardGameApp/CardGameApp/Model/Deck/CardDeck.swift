//
//  CardDeck.swift
//  CardGame
//
//  Created by 윤지영 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardDeck: Playable {
    private var cards: [Card] = []

    init() {
        reset()
    }

    private func fill() {
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                self.cards.append(Card(suit: suit, rank: rank))
            }
        }
    }

    var isEmpty: Bool {
        return cards.isEmpty
    }

    func count() -> Int {
        return cards.count
    }

    func removeOne() -> Card? {
        if isEmpty {
            return nil
        }
        return cards.removeFirst()
    }

    func removeMultiple(by number: Int) -> CardStack? {
        guard number > 0 else { return nil }
        var cardsRemoved: [Card] = []
        for _ in 0..<number {
            guard let cardRemoved = removeOne() else { break }
            cardsRemoved.append(cardRemoved)
        }
        return CardStack.init(cards: cardsRemoved)
    }

    func shuffle() {
        cards.shuffle()
    }

    func reset() {
        cards.removeAll()
        fill()
        shuffle()
    }

}
