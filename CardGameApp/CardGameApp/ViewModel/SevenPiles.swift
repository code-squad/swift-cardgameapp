//
//  SevenPiles.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 8..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

typealias CardImages = [[String]]

struct SevenPiles {
    private var sevenPiles: [CardPack]

    init() {
        self.sevenPiles = []
        setSevenPiles()
    }

    mutating func setSevenPiles(with sevenPiles: [CardPack]) {
        self.sevenPiles = sevenPiles
    }

    mutating private func setSevenPiles() {
        for _ in 0..<Figure.Count.cardPiles.value {
            sevenPiles.append(CardPack())
        }
    }

    mutating func reset() {
        sevenPiles = []
        setSevenPiles()
    }

    func getImages() -> CardImages {
        var cardImages: CardImages = []
        sevenPiles.forEach { cardPack in
            if cardPack.last?.isUpSide() == false {
                cardPack.last?.turnUpSideDown()
            }
            cardImages.append(cardPack.map { $0.image })
        }
        return cardImages
    }

    private func validatePush(card: Card, xIndex: Int) -> Bool {
        guard sevenPiles[xIndex].count == 0, card.rank == Card.Rank.king else {
            return false
        }
        guard sevenPiles[xIndex].last?.suit.isRed != card.suit.isRed,
            sevenPiles[xIndex].last?.rank.rawValue == card.rank.rawValue + 1 else {
                return false
        }
        return true
    }

    func getTargetPosition(name: String) -> TargetPosition {
        var targetPosition: TargetPosition = (xIndex: nil, yIndex: nil)
        for xIndex in sevenPiles.indices {
            if let image = sevenPiles[xIndex].last?.image, image == name {
                guard let cardWillBeMoved = sevenPiles[xIndex].last else { break }
                targetPosition = getNewPosition(of: cardWillBeMoved)
            }
        }
        return targetPosition
    }

    func getNewPosition(of card: Card) -> TargetPosition {
        var targetPosition: TargetPosition
        for index in sevenPiles.indices {
            if sevenPiles[index].count == 0 {
                if card.isKing() {
                    targetPosition.xIndex = index
                    targetPosition.yIndex = 0
                    return targetPosition
                }
            } else {
                if card.isAttachable(with: sevenPiles[index].last!) {
                    targetPosition.xIndex = index
                    targetPosition.yIndex = sevenPiles[index].count
                    return targetPosition
                }
            }
        }
        return targetPosition
    }

    mutating func pop(name: String) -> CardInformation {
        var cardInformation: CardInformation
        for xIndex in sevenPiles.indices {
            if let image = sevenPiles[xIndex].last?.image, image == name {
                cardInformation.xIndex = xIndex
                cardInformation.yIndex = sevenPiles[xIndex].count-1
                cardInformation.card = sevenPiles[xIndex].removeLast()
            }
        }
        return cardInformation
    }

    func getLastCardInformation(name: String) -> CardInformation {
        var cardInformation: CardInformation
        for xIndex in sevenPiles.indices {
            if let image = sevenPiles[xIndex].last?.image, image == name {
                cardInformation.xIndex = xIndex
                cardInformation.yIndex = sevenPiles[xIndex].count-1
                cardInformation.card = sevenPiles[xIndex].last
            }
        }
        return cardInformation
    }

    mutating func pushBack(cardInformation: CardInformation) {
        if let card = cardInformation.card, let xIndex = cardInformation.xIndex {
            sevenPiles[xIndex].append(card)
        }
    }

    mutating func setNewPlace(of card: Card) -> Bool {
        for index in sevenPiles.indices {
            if sevenPiles[index].count == 0 {
                if card.isKing() {
                    sevenPiles[index].append(card)
                    return true
                }
            } else {
                if card.isAttachable(with: sevenPiles[index].last!) {
                    sevenPiles[index].append(card)
                    return true
                }
            }
        }
        return false
    }

}
