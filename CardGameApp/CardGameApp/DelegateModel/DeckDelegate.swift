//
//  DeckDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 7..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class DeckDelegate {
    var deck: CardDeck!
    var openedDeck = [Card]()

    init(deck: CardDeck) {
        self.deck = deck
    }

    func hasEnoughCard() -> Bool {
        return deck.count() > 0
    }

    func lastOpenedCard() -> Card? {
        return self.openedDeck.last
    }

    func countOfDeck() -> Int {
        return deck.count()
    }

    func hasOpenedCard() -> Bool {
        return self.openedDeck.count > 0
    }

    func pop() {
        let selectedCard = deck.removeOne()
        selectedCard.turnOver()
        self.openedDeck.append(selectedCard)
    }

    func removePoppedCard() {
        self.openedDeck.removeLast()
    }

    func shuffleDeck() {
        deck.shuffleDeck(with: openedDeck)
        openedDeck = [Card]()
//        NotificationCenter.default.post(name: .deckUpdated, object: nil)
    }

}
