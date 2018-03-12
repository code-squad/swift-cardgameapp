//
//  OpenedCardDeckViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class OpenedCardDeckViewModel: CardStacksProtocol {

    private var cardStack: CardStack = CardStack(cardPack: []) {
        didSet {
            let cardImages: CardImages = cardStack.getImagesAll()
            NotificationCenter.default.post(name: .openedCardDeck,
                                            object: self,
                                            userInfo: [Keyword.openedCardImages.value: cardImages])
        }
    }

    func pop(index: Int) -> Card? {
        return cardStack.pop()
    }

    func push(card: Card) -> Bool {
        cardStack.push(card: card)
        return true
    }

    func getSelectedCardInformation(image: String) -> CardInformation? {
        guard let selectedCard = getSelectedCard(image: image) else { return nil }
        guard let selectedCardIndexes = getSelectedCardPosition(of: selectedCard) else { return nil }
        return (card: selectedCard, indexes: selectedCardIndexes)
    }

    private func getSelectedCard(image: String) -> Card? {
        var selectedCard: Card? = nil
        if let card = cardStack.selectedCard(image: image) {
            selectedCard = card
        }
        return selectedCard
    }

    private func getSelectedCardPosition(of card: Card) -> CardIndexes? {
        if let yIndex = cardStack.index(of: card) {
            return (xIndex: 0, yIndex: yIndex)
        }
        return nil
    }

    func availablePosition(of card: Card) -> CardIndexes? {
        return (xIndex: 0, yIndex: cardStack.count)
    }

    func reset() {
        cardStack.reset()
    }

    func reLoad() -> CardPack {
        return cardStack.reLoad()
    }

    func pop() -> Card? {
        return cardStack.pop()
    }

    func count() -> Int {
        return cardStack.count
    }

    func getLastCardInformation() -> Card? {
        return cardStack.last
    }

}
