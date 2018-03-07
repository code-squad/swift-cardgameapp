//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

typealias CardInformation = (card: Card?, xIndex: Int?, yIndex: Int?)
typealias TargetPosition = (xIndex: Int?, yIndex: Int?)

class SevenPilesViewModel {
    private var isDoneSetting: Bool
    private var sevenPiles: [CardPack] = [CardPack]() {
        didSet {
            if isDoneSetting { checkUpsideForLastCard() }
            var cardImages: [[String]] = []
            for xIndex in sevenPiles.indices {
                cardImages.append([])
                for yIndex in sevenPiles[xIndex].indices {
                    cardImages[xIndex].append(sevenPiles[xIndex][yIndex].image)
                }
            }
            NotificationCenter.default.post(name: .sevenPiles,
                                            object: self, userInfo: [Keyword.sevenPilesImages.value: cardImages])
        }
    }

    init() {
        isDoneSetting = false
        setSevenPiles()
    }

    private func setSevenPiles() {
        for _ in 0..<Figure.Count.cardPiles.value {
            sevenPiles.append([])
        }
    }

    func setCardPiles(card: Card, xIndex: Int) {
        isDoneSetting = false
        sevenPiles[xIndex].append(card)
        isDoneSetting = true
    }

    func reset() {
        sevenPiles = []
        setSevenPiles()
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

    func pop(name: String) -> CardInformation {
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

    func pushBack(cardInformation: CardInformation) {
        if let card = cardInformation.card, let xIndex = cardInformation.xIndex {
            sevenPiles[xIndex].append(card)
        }
    }

    func newPlace(of card: Card) -> Bool {
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

    private func checkUpsideForLastCard() {
        sevenPiles.forEach { cardPile in
            if cardPile.last?.isUpSide() == false {
                cardPile.last?.turnUpSideDown()
            }
        }
    }
    
}
