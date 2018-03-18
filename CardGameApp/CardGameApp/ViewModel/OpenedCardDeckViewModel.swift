//
//  OpenedCardDeckViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class OpenedCardDeckViewModel {
    private static var instance: OpenedCardDeckViewModel?

    static func sharedInstance() -> OpenedCardDeckViewModel {
        if instance == nil {
            instance = OpenedCardDeckViewModel()
        }
        return instance!
    }

    private init() {
        cardStack = CardStack(cardPack: [])
    }

    private var cardStack: CardStack {
        didSet {
            let cardImages: CardImages = cardStack.getImagesAll()
            NotificationCenter.default.post(name: .openedCardDeck,
                                            object: self,
                                            userInfo: [Keyword.openedCardImages.value: cardImages])
        }
    }

    func push(card: Card) -> Bool {
        cardStack.push(cards: [card])
        return true
    }

    func reLoad() -> CardPack {
        return cardStack.reLoad()
    }

}

// MARK: CardStacksProtocol
extension OpenedCardDeckViewModel: CardStacksProtocol {
    func reset() {
        cardStack.reset()
    }
}

// MARK: Sendable
extension OpenedCardDeckViewModel: Sendable {
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

    func pop(indexes: CardIndexes) -> [Card] {
        guard indexes.xIndex == 0 else { return [] }
        guard let card = cardStack.pop() else { return [] }
        return [card]
    }
}
