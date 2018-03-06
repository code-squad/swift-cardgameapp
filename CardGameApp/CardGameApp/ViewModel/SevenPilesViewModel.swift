//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class SevenPilesViewModel: PilesVMProtocol {
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

    func pop(name: String) -> (card: Card?, xIndex: Int?) {
        var cardInformation: (card: Card?, xIndex: Int?) = (card: nil, xIndex: nil)
        for xIndex in sevenPiles.indices {
            if let image = sevenPiles[xIndex].last?.image, image == name {
                cardInformation.card = sevenPiles[xIndex].removeLast()
                cardInformation.xIndex = xIndex
            }
        }
        return cardInformation
    }

    func getLastCard(name: String) -> (card: Card?, xIndex: Int?) {
        var cardInformation: (card: Card?, xIndex: Int?) = (card: nil, xIndex: nil)
        for xIndex in sevenPiles.indices {
            if let image = sevenPiles[xIndex].last?.image, image == name {
                cardInformation.card = sevenPiles[xIndex].last
                cardInformation.xIndex = xIndex
            }
        }
        return cardInformation
    }

    func getTargetPosition(name: String) -> (xIndex: Int?, yIndex: Int?) {
        let targetPosition: (xIndex: Int?, yIndex: Int?) = (xIndex: nil, yIndex: nil)
        for xIndex in sevenPiles.indices {
            if let image = sevenPiles[xIndex].last?.image, image == name {
                guard let cardWillBeMoved = sevenPiles[xIndex].last else { break }
                return getNewPosition(of: cardWillBeMoved)
            }
        }
        return targetPosition
    }

    func getNewPosition(of card: Card) -> (xIndex: Int?, yIndex: Int?) {
        var targetPosition: (xIndex: Int?, yIndex: Int?) = (xIndex: nil, yIndex: nil)
        for i in sevenPiles.indices {
            if sevenPiles[i].count == 0 {
                if card.isKing() {
                    targetPosition.xIndex = i
                    targetPosition.yIndex = 0
                    return targetPosition
                }
            } else {
                if card.isAttachable(with: sevenPiles[i].last!) {
                    targetPosition.xIndex = i
                    targetPosition.yIndex = sevenPiles[i].count
                    return targetPosition
                }
            }
        }
        return targetPosition
    }

    func pushBack(card: Card, xIndex: Int) {
        sevenPiles[xIndex].append(card)
    }

    func newPlace(of card: Card) -> Bool {
        for i in sevenPiles.indices {
            if sevenPiles[i].count == 0 {
                if card.isKing() {
                    sevenPiles[i].append(card)
                    return true
                }
            } else {
                if card.isAttachable(with: sevenPiles[i].last!) {
                    sevenPiles[i].append(card)
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
