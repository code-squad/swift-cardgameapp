//
//  CardDummyViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 14..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardDummyViewModel {
    private var cardDummy = [CardStack]()

    init() {
        cardDummy = makeCardDummy()
    }

    private func makeCardDummy() -> [CardStack] {
        let cardStacks = [CardStack?](repeating: nil, count: 4)
        return cardStacks.map { _ in return CardStack() }
    }

    func reset() {
        cardDummy.removeAll()
        cardDummy = makeCardDummy()
    }
}
