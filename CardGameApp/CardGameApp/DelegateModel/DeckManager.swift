//
//  DeckDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 7..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class DeckManager: CardDeckDelegate {
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
        openedDeck.forEach{ $0.turnOver() } // openedDeck안의 카드 상태를 전부 다시 closed로 만들어줌
        deck.shuffleDeck(with: openedDeck)
        openedDeck = [Card]()
    }

}
