//
//  CardDeckViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 04/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardDeckViewModel {
    private let cardDeck: CardDeck
    private var cardViewModels: [CardViewModel]

    init(cardDeck: CardDeck) {
        self.cardDeck = cardDeck
        self.cardViewModels = []
    }

    private func makeCardViewModels() {
        while !cardDeck.isEmpty {
            guard let card = cardDeck.removeOne() else { return }
            let cardViewModel = CardViewModel(card: card)
            cardViewModels.append(cardViewModel)
        }
    }

}
