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
    
    deinit {
        print("delete openDeck...")
    }
    
    func appendCard(_ card: Card) {
        self.openDeck.pushCard(card)
    }
    
    func popCard() -> Card? {
        return openDeck.popCard()
    }
}
