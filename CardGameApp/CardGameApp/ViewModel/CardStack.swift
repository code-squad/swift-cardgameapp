//
//  CardStack.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 9..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

struct CardStack {
    private var cardStack: CardPack

    var last: Card? {
        return cardStack.last
    }

    var count: Int {
        return cardStack.count
    }

    init(cardPack: CardPack) {
        cardStack = cardPack
        turnLastCardOn()
    }

    func selectedCard(image: String) -> Card? {
        var selectedCard: Card?
        for card in cardStack where card.isUpSide() && card.image == image {
            selectedCard = card
            break
        }
        return selectedCard
    }

    func index(of card: Card) -> Int? {
        var cardIndex: Int?
        for index in cardStack.indices where cardStack[index].isUpSide() && cardStack[index].image == card.image {
            cardIndex = index
        }
        return cardIndex
    }

    func getImagesAll() -> CardImages {
        return cardStack.map { $0.image }
    }

    private func turnLastCardOn() {
        guard let card = cardStack.last else { return }
        if !card.isUpSide() {
            cardStack.last?.turnUpSideDown()
        }
    }

}

// MARK: Mutating
extension CardStack {
    mutating func reset() {
        cardStack = []
    }

    mutating func reLoad() -> CardPack {
        var cardsForReLoad: CardPack = []
        while !cardStack.isEmpty {
            guard let lastCard = cardStack.popLast() else { break }
            cardsForReLoad.append(lastCard)
        }
        defer { cardStack = [] }
        return cardsForReLoad
    }

    mutating func push(cards: [Card]) {
        cardStack.append(contentsOf: cards)
        turnLastCardOn()
    }

    mutating func pop() -> Card? {
        defer { turnLastCardOn() }
        return cardStack.removeLast()
    }

    mutating func pop(index: Int) -> [Card] {
        defer { turnLastCardOn() }
        var poppedCards: [Card] = []
        for _ in index..<cardStack.count {
            poppedCards.append(cardStack.removeLast())
        }
        return poppedCards.reversed()
    }
}

// MARK: New Card available
extension CardStack {
    func isAttachable(card: Card) -> Bool {
        if cardStack.isEmpty, card.isKing() {
            return true
        }
        if let lastCard = cardStack.last,
            card.isOneRankDown(from: lastCard),
            card.isDifferentColor(with: lastCard) {
            return true
        }
        return false
    }

    func isStackable(card: Card) -> Bool {
        if cardStack.isEmpty, card.isAce() {
            return true
        }
        if let lastCard = cardStack.last,
            card.isOneRankUp(from: lastCard),
            card.isSameSuit(with: lastCard) {
            return true
        }
        return false
    }
}
