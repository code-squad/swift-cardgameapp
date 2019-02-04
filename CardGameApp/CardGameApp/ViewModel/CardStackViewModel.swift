//
//  CardStackViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardStackViewModel {
    private let cardStack: CardStack
    private var cardViewModels: [CardViewModel]

    required init(cardStack: CardStack) {
        self.cardStack = cardStack
        self.cardViewModels = []
        makeCardViewModels()
    }

    private func makeCardViewModels() {
        cardStack.iterateCards { [unowned self] card in
            let cardViewModel = CardViewModel(card: card)
            self.cardViewModels.append(cardViewModel)
        }
    }

}
