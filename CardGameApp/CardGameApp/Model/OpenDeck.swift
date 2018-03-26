//
//  OpenedDeck.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 12..
//  Copyright © 2018년 Napster. All rights reserved.
//

import Foundation

class OpenDeck: CardGameMoveAble {

    private var openDeck: Deck
    
    init() {
        self.openDeck = Deck(cards: [Card]())
    }
    
    func pickCard(xIndex: Int, yIndex: Int) -> Card {
        return openDeck.cards[openDeck.cards.endIndex - 1]
    }
    
    func pushCard(card: Card, index: Int) {
        self.openDeck.pushCard(card)
        NotificationCenter.default.post(name: .pushOpenCard, object: self, userInfo: [Notification.Name.cardName: card])
    }
    
    func popCard(xPoint: Int) {
        guard openDeck.popCard() != nil else { return }
    }
    
    func lastCard(xIndex: Int) -> Card? {
        return openDeck.lastCard()
    }
}
