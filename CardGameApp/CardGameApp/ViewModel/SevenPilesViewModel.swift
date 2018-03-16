//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class SevenPilesViewModel: CardStacksProtocol, Receivable, Sendable {
    private static var instance: SevenPilesViewModel?

    static func sharedInstance() -> SevenPilesViewModel {
        if instance == nil {
            instance = SevenPilesViewModel()
        }
        return instance!
    }

    private init() {
        cardStacks = []
    }

    private var cardStacks: [CardStack] = [CardStack]() {
        didSet {
            var cardImagesPack: [CardImages] = []
            cardStacks.forEach { cardImagesPack.append($0.getImagesAll()) }
            NotificationCenter.default.post(name: .sevenPiles,
                                            object: self,
                                            userInfo: [Keyword.sevenPilesImages.value: cardImagesPack])
        }
    }

    func spreadCardPiles(sevenPiles: [CardPack]) {
        for index in sevenPiles.indices {
            cardStacks.append(CardStack(cardPack: sevenPiles[index]))
        }
    }

    func push(cards: [Card]) -> Bool {
        guard let targetPosition = availablePosition(of: cards[0]) else { return false }
        cardStacks[targetPosition.xIndex].push(cards: cards)
        return true
    }

    func push(cards: [Card], indexes: CardIndexes) -> Bool {
        cardStacks[indexes.xIndex].push(cards: cards)
        return true
    }

    func pop(indexes: CardIndexes) -> [Card] {
        return cardStacks[indexes.xIndex].pop(index: indexes.yIndex)
    }

    func getSelectedCardInformation(image: String) -> CardInformation? {
        guard let selectedCard = getSelectedCard(image: image) else { return nil }
        guard let selectedCardIndexes = getSelectedCardPosition(of: selectedCard) else { return nil }
        return (card: selectedCard, indexes: selectedCardIndexes)
    }

    private func getSelectedCard(image: String) -> Card? {
        var selectedCard: Card? = nil
        cardStacks.forEach {
            if let card = $0.selectedCard(image: image) {
                selectedCard = card
            }
        }
        return selectedCard
    }

    private func getSelectedCardPosition(of card: Card) -> CardIndexes? {
        for xIndex in cardStacks.indices {
            if let yIndex = cardStacks[xIndex].index(of: card) {
                return (xIndex: xIndex, yIndex: yIndex)
            }
        }
        return nil
    }

    func availablePosition(of card: Card) -> CardIndexes? {
        for xIndex in cardStacks.indices {
            if cardStacks[xIndex].isAttachable(card: card) {
                return (xIndex: xIndex, yIndex: cardStacks[xIndex].count)
            }
        }
        return nil
    }

    func reset() {
        cardStacks = []
    }

    func availablePositionsForDragging(of card: Card) -> [CardIndexes] {
        var availablePositions: [CardIndexes] = []
        for xIndex in cardStacks.indices {
            if cardStacks[xIndex].isAttachable(card: card) {
                let cardIndexes: CardIndexes = (xIndex: xIndex, yIndex: cardStacks[xIndex].count)
                availablePositions.append(cardIndexes)
            }
        }
        return availablePositions
    }

}
