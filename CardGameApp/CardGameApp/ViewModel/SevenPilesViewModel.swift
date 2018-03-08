//
//  CardPileViewModel.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 1. 31..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

typealias CardPosition = (xIndex: Int?, yIndex: Int?)
typealias CardInformation = (card: Card?, position: CardPosition)

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

    func pop(position: CardPosition) -> Card? {
        return sevenPiles.pop(position: position)
    }

    func getDoubleTappedCardInformation(name: String) -> CardInformation {
        return sevenPiles.getDoubleTappedCardInformation(name: name)
    }

    func getTargetPosition(name: String) -> CardPosition {
        return sevenPiles.getTargetPosition(name: name)
    }

    func getTargetPosition(of card: Card) -> CardPosition {
        return sevenPiles.getTargetPosition(of: card)
    }

    func pushBack(cardInformation: CardInformation) {
        sevenPiles.pushBack(cardInformation: cardInformation)
    }

    func setNewPlace(of card: Card) -> Bool {
        return sevenPiles.setNewPlace(of: card)
    }

}
