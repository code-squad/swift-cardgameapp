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
        cardStackViewModels.removeAll()
        makeCardStackViewModels()
        NotificationCenter.default.post(name: .cardStacksReset, object: self)
    }

}

extension CardStacksViewModel {

    func iterateCardStackViewModels(_ deliver: (CardStackViewModel) -> Void) {
        for cardStackViewModel in cardStackViewModels {
            deliver(cardStackViewModel)
        }
    }

    func accessCardStackViewModel(at index: Int, deliver: (CardStackViewModel) -> Void) {
        guard index < cardStackViewModels.count else { return }
        deliver(cardStackViewModels[index])
    }

}

extension NSNotification.Name {
    static let cardStacksReset = Notification.Name("cardStacksReset")
}
