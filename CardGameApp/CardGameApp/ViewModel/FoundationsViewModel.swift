//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class FoundationsViewModel: CardStacksProtocol, Receivable {
    private static var instance: FoundationsViewModel?

    static func sharedInstance() -> FoundationsViewModel {
        if instance == nil {
            instance = FoundationsViewModel()
        }
        return instance!
    }

    private init() {
        setNewFoundations()
    }

    private var cardStacks: [CardStack] = [CardStack]() {
        didSet {
            var cardImagesPack: [CardImages] = []
            cardStacks.forEach { cardImagesPack.append($0.getImagesAll()) }
            NotificationCenter.default.post(name: .foundation,
                                            object: self,
                                            userInfo: [Keyword.foundationImages.value: cardImagesPack])
        }
    }

    func push(cards: [Card]) -> Bool {
        guard cards.count == 1 else { return false }
        guard let targetPosition = availablePosition(of: cards[0]) else { return false }
        cardStacks[targetPosition.xIndex].push(cards: cards)
        return true
    }

    func push(cards: [Card], indexes: CardIndexes) -> Bool {
        guard cards.count == 1 else { return false }
        guard indexes.xIndex < cardStacks.count else { return false }
        cardStacks[indexes.xIndex].push(cards: cards)
        return true
    }

    func availablePosition(of card: Card) -> CardIndexes? {
        for xIndex in cardStacks.indices {
            if cardStacks[xIndex].isStackable(card: card) {
                return (xIndex: xIndex, yIndex: cardStacks[xIndex].count)
            }
        }
        return nil
    }

    func reset() {
        cardStacks = []
        setNewFoundations()
    }

    private func setNewFoundations() {
        for _ in 0..<Figure.Count.foundations.value {
            cardStacks.append(CardStack(cardPack: []))
        }
    }

    func availablePositionsForDragging(of card: Card) -> [CardIndexes] {
        var availablePositions: [CardIndexes] = []
        for xIndex in cardStacks.indices {
            if cardStacks[xIndex].isStackable(card: card) {
                let cardIndexes: CardIndexes = (xIndex: xIndex, yIndex: cardStacks[xIndex].count)
                availablePositions.append(cardIndexes)
            }
        }
        return availablePositions
    }
}
