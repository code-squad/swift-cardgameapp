//
//  TableauPilesViewModel.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class TableauViewModel: CardStackPresentable {

    let stackNumber: Int
    private(set) var cardViewModels: [CardViewModel]

    init(_ tableau: CardStack, stackNumber: Int) {
        self.stackNumber = stackNumber
        let cardViewModels = tableau.cards.collection.map {
            CardViewModel(card: $0, status: .down, location: .tableau(stackNumber))
        }
        self.cardViewModels = cardViewModels
        self.cardViewModels.last?.turnOver(to: .up)
    }

    func append(_ card: Card?) {
        guard let card = card else { return }
        cardViewModels.append(CardViewModel(card: card, status: .up, location: .tableau(stackNumber)))
    }

    func remove() {
        cardViewModels.isEmpty ? nil : cardViewModels.removeLast()
        cardViewModels.last?.turnOver(to: .up)
    }

}
