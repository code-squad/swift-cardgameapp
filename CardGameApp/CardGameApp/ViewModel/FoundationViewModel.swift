//
//  FoundationViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class FoundationViewModel: CardStackPresentable {

    let stackNumber: Int
    private(set) var cardViewModels: [CardViewModel]

    init(_ foundation: CardStack, stackNumber: Int) {
        self.stackNumber = stackNumber
        let cardViewModels = foundation.cards.collection.map {
            CardViewModel(card: $0, status: .up, location: .foundation(stackNumber))
        }
        self.cardViewModels = cardViewModels
    }

    func append(_ card: Card?) {
        guard let card = card else { return }
        cardViewModels.append(CardViewModel(card: card, status: .up, location: .foundation(stackNumber)))
    }

    func remove() {
        cardViewModels.isEmpty ? nil : cardViewModels.removeLast()
    }

}
