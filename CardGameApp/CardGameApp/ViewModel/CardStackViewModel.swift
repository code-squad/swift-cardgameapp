//
//  CardStackViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 29/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardStackViewModel {
    private var cardStack: CardStack
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

    func replace(cardStack: CardStack) {
        self.cardStack = cardStack
        replaceCardViewModels()
    }

    private func replaceCardViewModels() {
        for index in cardViewModels.indices {
            cardStack.accessCard(at: index) { [unowned self] card in
                self.cardViewModels[index].replace(card: card)
            }
        }
    }

}

extension CardStackViewModel {

    func iterateCardViewModels(_ deliver: (CardViewModel) -> Void) {
        for cardViewModel in cardViewModels {
            deliver(cardViewModel)
        }
    }

}
