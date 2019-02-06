//
//  CardGame.swift
//  CardGame
//
//  Created by 윤지영 on 16/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

class CardGame {
    let cardDeck: CardDeck

    init() {
        self.cardDeck = CardDeck()
    }

    var cardStacks: CardStacks {
        return CardStacks(from: cardDeck)
    }

    func reset() {
        cardDeck.reset()
    }

}
