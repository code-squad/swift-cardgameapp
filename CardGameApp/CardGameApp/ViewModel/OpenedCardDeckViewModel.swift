//
//  OpenedCardDeckViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class OpenedCardDeckViewModel: PilesVMProtocol {
    private var openedCardDeck: CardPack = [] {
        didSet {
            NotificationCenter.default.post(name: .openedCardDeck, object: self, userInfo: nil)
        }
    }

    var lastCardImage: String? {
        return openedCardDeck.last?.image
    }

    var willMoveImage: String? {
        return openedCardDeck.count > 1 ? openedCardDeck[openedCardDeck.count-2].image : nil
    }

    func push(card: Card) {
        openedCardDeck.append(card)
    }

    func pop() -> Card? {
        return openedCardDeck.removeLast()
    }

    func reLoad() -> CardPack {
        var reLoadCardDeck: CardPack = []
        while let card = openedCardDeck.popLast() {
            reLoadCardDeck.append(card)
        }
        return reLoadCardDeck
    }

    func count() -> Int {
        return openedCardDeck.count
    }

    func reset() {
        openedCardDeck = []
    }

    func getLastCard() -> Card? {
        return openedCardDeck.last
    }

}
