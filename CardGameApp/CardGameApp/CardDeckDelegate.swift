//
//  CardDeckDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 24..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

protocol DeckManageable {
    func hasRemainCard() -> Bool
}

class CardDeckDelegate: DeckManageable {

    var cardDeck: CardDeck

    init(cardDeck: CardDeck) {
        self.cardDeck = cardDeck
    }

    func hasRemainCard() -> Bool {
        if cardDeck.count() > 0 {
            return true
        } else {
            return false
        }
    }


}
