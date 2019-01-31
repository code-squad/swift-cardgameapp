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

    func add(_ card: Card) {
        cards.append(card)
    }

    func reset() {
        cards.removeAll()
    }

    func flipLast() {
        guard let lastCard = cards.last else { return }
        lastCard.flip()
    }

    var count: Int {
        return cards.count
    }

    var imageNames: [String?] {
        return cards.map { $0.imageName }
    }

    var description: String {
        let allCards = cards
            .map { "\($0)" }
            .joined(separator: ", ")
        return "[\(allCards)]"
    }

    var bestHand: Hand? {
        return ScoreCalculator.getBestHand(from: cards)
    }

    /* MARK: Sequence, IteratorProtocol */
    private var iterator = 0

}

extension CardStack: Sequence, IteratorProtocol {

    typealias Element = Card

    func next() -> CardStack.Element? {
        if iterator < cards.count {
            defer { iterator += 1 }
            return cards[iterator]
        }
        iterator = 0
        return nil
    }

}
