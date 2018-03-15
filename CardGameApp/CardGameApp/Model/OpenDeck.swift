//
//  OpenedDeck.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 12..
//  Copyright © 2018년 Napster. All rights reserved.
//

import Foundation

class OpenDeck {
    private var openDeck: Deck
    
    init() {
        self.openDeck = Deck(cards: [Card]())
    }
    
    func pushCard(_ card: Card) {
        self.openDeck.pushCard(card)
    }
    
    func popCard() {
        guard openDeck.popCard() != nil else { return }
        NotificationCenter.default.post(name: .popOpenCard, object: self)
    }
    
    func lastCard() -> Card? {
        return openDeck.lastCard()
    }
}
