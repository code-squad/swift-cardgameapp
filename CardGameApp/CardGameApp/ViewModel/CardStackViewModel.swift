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

    init(cardStack: CardStack) {
        self.cardStack = cardStack
        self.cardViewModels = []
        makeCardViewModels()
        flipLastCard()
    }

    private func makeCardViewModels() {
        cardStack.iterateCards { [unowned self] card in
            let cardViewModel = CardViewModel(card: card)
            self.cardViewModels.append(cardViewModel)
        }
    }

    private func flipLastCard() {
        if let lastCardViewModel = cardViewModels.last {
            lastCardViewModel.flip()
        }
    }

}

extension CardStackViewModel {

    func iterateCardViewModels(_ deliver: (CardViewModel) -> Void) {
        for cardViewModel in cardViewModels {
            deliver(cardViewModel)
        }
    }

    func accessCardViewModel(at index: Int, deliver: (CardViewModel) -> Void) {
        guard index < cardViewModels.count else { return }
        deliver(cardViewModels[index])
    }

}
