//
//  WasteViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class WasteViewModel: CardStackPresentable {

    private(set) var cardViewModels: [CardViewModel]

    init(_ waste: CardStack) {
        let cardViewModels = waste.cards.collection.map { CardViewModel(card: $0, status: .up, location: .waste) }
        self.cardViewModels = cardViewModels
    }

    init() {
        self.cardViewModels = []
    }

    func append(_ card: Card?) {
        guard let card = card else { return }
        cardViewModels.append(CardViewModel(card: card, status: .up, location: .waste))
    }

    func remove() {
        cardViewModels.removeLast()
    }

}
