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

    var bestHand: Hand? {
        return ScoreCalculator.getBestHand(from: cards)
    }

}

/* MARK: Make [CardViewModel] by CardStack in CardStackViewModel */
extension CardStack {

    func makeCardViewModels(_ make: (CardViewModel) -> Void) {
        for card in cards {
            let cardViewModel = CardViewModel(card: card)
            make(cardViewModel)
        }
    }

}
