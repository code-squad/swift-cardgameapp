//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class SevenPilesViewModel: CardStacksProtocol {
    private var cardStacks: [CardStack] = [CardStack]() {
        didSet {
            var cardImagesPack: [CardImages] = []
            cardStacks.forEach { cardImagesPack.append($0.getImagesAll()) }
            NotificationCenter.default.post(name: .sevenPiles,
                                            object: self,
                                            userInfo: [Keyword.sevenPilesImages.value: cardImagesPack])
        }
    }

    init() {
        cardStacks = []
    }

    func spreadCardPiles(sevenPiles: [CardPack]) {
        for index in sevenPiles.indices {
            cardStacks.append(CardStack(cardPack: sevenPiles[index]))
        }
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

    func availablePosition(of card: Card) -> CardIndexes {
        var availablePosition: CardIndexes = (xIndex: nil, yIndex: nil)
        for xIndex in cardStacks.indices {
            if cardStacks[xIndex].isAttachable(card: card) {
                availablePosition.xIndex = xIndex
                availablePosition.yIndex = cardStacks[xIndex].index(of: card)
            }
        }
        return availablePosition
    }

    func getSelectedCardPosition(of card: Card) -> CardIndexes {
        var selectedCardPosition: CardIndexes = (xIndex: nil, yIndex: nil)
        for xIndex in cardStacks.indices {
            let yIndex = cardStacks[xIndex].index(of: card)
            selectedCardPosition.xIndex = xIndex
            selectedCardPosition.yIndex = yIndex
        }
        return selectedCardPosition
    }

    func reset() {
        cardStacks = []
    }

}
