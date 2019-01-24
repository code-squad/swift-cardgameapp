//
//  Player.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Player: GamePlayer {
    private var cards: CardStack

    init() {
        self.cards = CardStack(cards: [])
    }

    func take(card: Card) {
        cards.add(card)
    }

    func showCards() -> String {
        return "\(cards)"
    }

    func resetCards() {
        cards.reset()
    }

    var name: String {
        return "참가자"
    }

    var bestHand: Hand? {
        return cards.bestHand
    }
}
