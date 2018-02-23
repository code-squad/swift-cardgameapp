//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

class SevenPilesViewModel: PilesVMProtocol {
    private var sevenPiles: [CardPack] = [CardPack]()

    init() {
        for _ in 0..<Figure.Count.cardPiles.value {
            sevenPiles.append([])
        }
    }

    func setCardPiles(card: Card, xIndex: Int) {
        sevenPiles[xIndex].append(card)
    }

    func push(card: Card, xIndex: Int) -> Bool {
        guard validatePush(card: card, xIndex: xIndex) else {
            return false
        }
        sevenPiles[xIndex].append(card)
        return true
    }

    func pop(xIndex: Int) -> Card? {
        return sevenPiles[xIndex].removeLast()
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
    
}
