//
//  FoundationDeck.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 9..
//  Copyright © 2018년 Napster. All rights reserved.
//

import Foundation

class FoundationDeck {
    private var foundationDeck = Array.init(repeating: Deck(cards: [Card]()), count: 4)

    deinit {
        print("delete foundation deck...")
    }
    
    func appendDecks(_ card: Card) -> Int {
        if let emptyIndex = foundationDeck.index(where: { $0.isEmptyDeck() }) {
            foundationDeck[emptyIndex].pushCard(card)
            return emptyIndex
        }
        return 0
    }
    
}
