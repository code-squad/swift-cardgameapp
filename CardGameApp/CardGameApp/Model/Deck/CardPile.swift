//
//  CardPile.swift
//  CardGameApp
//
//  Created by 윤지영 on 04/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardPile {
    private var cards: [Card] = []

    func pileUp(card: Card) {
        cards.append(card)
    }

    func removeAll() -> [Card] {
        defer {
            cards.removeAll()
        }
        return cards
    }

}
