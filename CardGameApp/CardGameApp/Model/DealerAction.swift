//
//  DealerAction.swift
//  CardGame
//
//  Created by TaeHyeonLee on 2017. 11. 30..
//  Copyright © 2017 ChocOZerO. All rights reserved.
//

import Foundation

struct DealerAction {
    fileprivate var cardDeck: CardDeck

    init() {
        cardDeck = CardDeck()
    }

    enum CardAction: Int {
        case none, reset, shuffle, removeOne, cardPacks, pokerGame
    }

    func isRemain() -> Bool {
        return cardDeck.count() > 0
    }

    func count() -> Int {
        return cardDeck.count()
    }

    mutating func reset() {
        cardDeck.reset()
    }

    mutating func shuffle() {
        cardDeck.shuffle()
    }

    mutating func removeOne() -> Card? {
        return cardDeck.removeOne()
    }

    mutating func getCardPacks(packCount: Int) -> Array<CardPack> {
        return cardDeck.getCardPacks(packCount: packCount)
    }

    mutating func open() -> Card? {
        guard let card = cardDeck.removeOne() else {
            return nil
        }
        card.turnUpSideDown()
        return card
    }

    mutating func reLoad(cardPack: CardPack) {
        if cardPack.count != 0 {
            cardDeck.load(cardPack: cardPack)
        }
    }

}

extension DealerAction: Equatable {

    static func ==(lhs: DealerAction, rhs: DealerAction) -> Bool {
        guard lhs.count() == rhs.count() else { return false }
        guard lhs.cardDeck == rhs.cardDeck else { return false }
        return true
    }

}
