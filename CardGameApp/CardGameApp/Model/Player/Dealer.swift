//
//  Dealer.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class Dealer{
    private var deck: CardDeck
    private var cards: CardStack

    init(with deck: CardDeck) {
        self.deck = deck
        self.cards = CardStack(cards: [])
    }

    func dealOut() -> Card? {
        guard let card = deck.removeOne() else { return nil }
        return card
    }

    func hasEnoughCards(for numberOfPlayers: Int, in gameMode: GameMode) -> Bool {
        return deck.count() >= numberOfPlayers * gameMode.numberOfCards
    }

}

extension Dealer: GamePlayer {

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
        return "딜러"
    }

    var bestHand: Hand? {
        return cards.bestHand
    }

}
