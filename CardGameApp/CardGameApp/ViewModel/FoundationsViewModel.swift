//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class FoundationsViewModel: CardStacksProtocol, Receivable {
    private var cardStacks: [CardStack] = [CardStack]() {
        didSet {
            var cardImagesPack: [CardImages] = []
            cardStacks.forEach { cardImagesPack.append($0.getImagesAll()) }
            NotificationCenter.default.post(name: .foundation,
                                            object: self,
                                            userInfo: [Keyword.foundationImages.value: cardImagesPack])
        }
    }

    init() {
        setNewFoundations()
    }

    func push(card: Card) -> Bool {
        guard let targetPosition = availablePosition(of: card) else { return false }
        cardStacks[targetPosition.xIndex].push(card: card)
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
}
