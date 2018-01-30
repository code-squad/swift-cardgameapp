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
    private var openedCardDeck: CardPack = []

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
            if openedCardDeck.count != 0 {
                cardDeck.load(cardPack: openedCardDeck)
                openedCardDeck = []
            }
            return nil
        }
        card.turnUpSideDown()
        openedCardDeck.append(card)
        return card
    }

}

extension DealerAction: Equatable {

    static func ==(lhs: DealerAction, rhs: DealerAction) -> Bool {
        guard lhs.count() == rhs.count() else { return false }
        for i in 0..<lhs.count() where lhs.cardDeck[i] != rhs.cardDeck[i]  {
            return false
        }
        return true
    }

}
