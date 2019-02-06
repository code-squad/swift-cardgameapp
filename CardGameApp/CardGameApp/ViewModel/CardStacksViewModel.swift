//
//  CardStacksViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 31/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardStacksViewModel {
    private var cardStacks: CardStacks
    private var cardStackViewModels: [CardStackViewModel]

    required init(cardStacks: CardStacks) {
        self.cardStacks = cardStacks
        self.cardStackViewModels = []
        makeCardStackViewModels()
    }

    private func makeCardStackViewModels() {
        cardStacks.iterateCardStack { [unowned self] cardStack in
            let cardStackViewModel = CardStackViewModel(cardStack: cardStack)
            self.cardStackViewModels.append(cardStackViewModel)
        }
    }

    func replace(cardStacks: CardStacks) {
        self.cardStacks = cardStacks
        replaceCardStackViewModels()
    }

    private func replaceCardStackViewModels() {
        for index in cardStackViewModels.indices {
            cardStacks.accessCardStack(at: index) { [unowned self] cardStack in
                self.cardStackViewModels[index].replace(cardStack: cardStack)
            }
        }
    }

}

extension CardStacksViewModel {

    func iterateCardStackViewModels(_ deliver: (CardStackViewModel) -> Void) {
        for cardStackViewModel in cardStackViewModels {
            deliver(cardStackViewModel)
        }
    }
 
}
