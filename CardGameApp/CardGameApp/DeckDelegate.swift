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
        if deck.count() > 0 {
            return true
        } else {
            return false
        }
    }

    func currentDeck() -> CardDeck {
        return self.deck
    }

    func countOfDeck() -> Int {
        return deck.count()
    }

    func hasOpenedCard() -> Bool {
        guard self.openedDeck.count == 0 else {
            return false
        }
        return true
    }

    func pickACard() -> Card {
        self.openedDeck.append(deck.removeOne())
        print(self.countOfDeck())
        return self.openedDeck.last!
    }


}
