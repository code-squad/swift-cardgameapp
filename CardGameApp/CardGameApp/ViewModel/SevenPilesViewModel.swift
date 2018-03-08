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
    private var sevenPiles: SevenPiles = SevenPiles() {
        didSet {
            let cardImages = sevenPiles.getImages()
            NotificationCenter.default.post(name: .sevenPiles,
                                            object: self, userInfo: [Keyword.sevenPilesImages.value: cardImages])
        }
    }

    func setCardPiles(sevenPiles: [CardPack]) {
        self.sevenPiles.setSevenPiles(with: sevenPiles)
    }

    func reset() {
        sevenPiles.reset()
    }

    func pop(name: String) -> CardInformation {
        return sevenPiles.pop(name: name)
    }

    func getLastCardInformation(name: String) -> CardInformation {
        return sevenPiles.getLastCardInformation(name: name)
    }

    func getTargetPosition(name: String) -> TargetPosition {
        return sevenPiles.getTargetPosition(name: name)
    }

    func getNewPosition(of card: Card) -> TargetPosition {
        return sevenPiles.getNewPosition(of: card)
    }


    func pushBack(cardInformation: CardInformation) {
        sevenPiles.pushBack(cardInformation: cardInformation)
    }

    func setNewPlace(of card: Card) -> Bool {
        return sevenPiles.setNewPlace(of: card)
    }
    
}
