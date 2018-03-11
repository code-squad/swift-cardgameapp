//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 30..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class FoundationsViewModel: CardStacksProtocol {
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

    func push(card: Card) {
        let targetPosition = availablePosition(of: card)
        if let xIndex = targetPosition.xIndex {
            cardStacks[xIndex].push(card: card)
        }
    }

    func pop(index: Int) -> Card? {
        return cardStacks[index].pop()
    }

    func getSelectedCardPosition(of card: Card) -> CardIndexes {
        var selectedCardPosition: CardIndexes = (xIndex: nil, yIndex: nil)
        for xIndex in cardStacks.indices {
            if let yIndex = cardStacks[xIndex].index(of: card) {
                selectedCardPosition.xIndex = xIndex
                selectedCardPosition.yIndex = yIndex
                break
            }
        }
        return selectedCardPosition
    }

    func availablePosition(of card: Card) -> CardIndexes {
        var availablePosition: CardIndexes = (xIndex: nil, yIndex: nil)
        for xIndex in cardStacks.indices {
            if cardStacks[xIndex].isStackable(card: card) {
                availablePosition.xIndex = xIndex
                availablePosition.yIndex = 0
                break
            }
        }
        return availablePosition
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
