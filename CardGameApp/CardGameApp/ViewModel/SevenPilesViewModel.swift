//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class SevenPilesViewModel: PilesVMProtocol {
    var isDoneSetting = false
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
        for _ in 0..<Figure.Count.cardPiles.value {
            sevenPiles.append([])
        }
    }

    func setCardPiles(card: Card, xIndex: Int) {
        sevenPiles[xIndex].append(card)
    }

    func reset() {
        
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

    func pushBack(card: Card, xIndex: Int) {
        sevenPiles[xIndex].append(card)
    }

    func newPlace(of card: Card) -> Bool {
        for i in sevenPiles.indices {
            if sevenPiles[i].count == 0, card.isKing() {
                sevenPiles[i].append(card)
                return true
            } else if card.isAttachable(with: sevenPiles[i].last!) {
                sevenPiles[i].append(card)
                return true
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
