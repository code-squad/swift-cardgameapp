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

    func push(card: Card) {
        cardStack.push(card: card)
    }

    func getSelectedCard(image: String) -> Card? {
        var selectedCard: Card? = nil
        if let card = cardStack.selectedCard(image: image) {
            selectedCard = card
        }
        return selectedCard
    }

    func getSelectedCardPosition(of card: Card) -> CardIndexes {
        var selectedCardPosition: CardIndexes = (xIndex: nil, yIndex: nil)
        selectedCardPosition.xIndex = 0
        selectedCardPosition.yIndex = cardStack.index(of: card)
        return selectedCardPosition
    }

    func availablePosition(of card: Card) -> CardIndexes {
        var availablePosition: CardIndexes = (xIndex: nil, yIndex: nil)
        availablePosition.xIndex = 0
        availablePosition.yIndex = cardStack.count
        return availablePosition
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
