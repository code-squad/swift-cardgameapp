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

    func isEmpty() -> Bool {
        return cardStack.isEmpty
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

    mutating func push(card: Card) {
        cardStack.append(card)
        turnLastCardOn()
    }

    mutating func pop() -> Card? {
        return cardStack.removeLast()
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
