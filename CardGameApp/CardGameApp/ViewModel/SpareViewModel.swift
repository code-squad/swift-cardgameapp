//
//  SpareViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class SpareViewModel: CardStackPresentable {

    private(set) var cardViewModels: [CardViewModel]

    init(_ spare: CardStack) {
        let cardViewModels = spare.cards.collection.map { CardViewModel(card: $0, status: .down, location: .spare) }
        self.cardViewModels = cardViewModels
    }

    init() {
        self.cardViewModels = []
    }

    func append(_ card: Card?) {
        guard let card = card else { return }
        cardViewModels.append(CardViewModel(card: card, status: .down, location: .spare))
    }

    func remove() {
        cardViewModels.removeLast()
    }

}
