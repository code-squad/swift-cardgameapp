//
//  CardDeckViewModel.swift
//  CardGameApp
//
//  Created by 윤지영 on 04/02/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import Foundation

class CardDeckViewModel {
    private var cardDeck: CardDeck
    private var cardViewModels: [CardViewModel]

    init(cardDeck: CardDeck) {
        self.cardDeck = cardDeck
        self.cardViewModels = []
        makeCardViewModels()
    }

    private func makeCardViewModels() {
        while !cardDeck.isEmpty {
            guard let card = cardDeck.removeOne() else { return }
            let cardViewModel = CardViewModel(card: card)
            cardViewModels.append(cardViewModel)
        }
    }

    func pop() -> CardViewModel? {
        if cardViewModels.isEmpty { return nil }
        if cardViewModels.oneLeft {
            NotificationCenter.default.post(name: .cardDeckWillBeEmpty, object: self)
        }
        return cardViewModels.removeLast()
    }

    func replace(cardDeck: CardDeck) {
        self.cardDeck = cardDeck
        cardViewModels.removeAll()
        makeCardViewModels()
        NotificationCenter.default.post(name: .cardDeckReset, object: self)
    }

}

extension CardDeckViewModel {

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

extension NSNotification.Name {
    static let cardDeckReset = Notification.Name("cardDeckReset")
    static let cardDeckWillBeEmpty = Notification.Name("cardDeckWillBeEmpty")
}

extension Array {

    var oneLeft: Bool {
        return self.count == 1
    }

}
