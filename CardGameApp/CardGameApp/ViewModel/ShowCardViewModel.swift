//
//  ShowCardViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 22..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class ShowCardViewModel {
    private var remainShowCards: CardStack

    init() {
        remainShowCards = CardStack()
    }

    func allCards() -> [Card] {
        var cards = [Card]()
        while true {
            guard let pop = remainShowCards.pop() else { break }
            cards.append(pop)
        }
        return cards
    }

    func removeAll() {
        remainShowCards = CardStack()
        NotificationCenter.default.post(
            name: .removeAllShowCardNotification,
            object: self
        )
    }
}

extension ShowCardViewModel: MovableViewModel {
    func lastShowCards(index: Int = 0, count: Int) -> [Card]? {
        return remainShowCards.lastCards(count: count)
    }

    func targetIndex(card: Card) -> Int? {
        return 0
    }
    func pop(index: Int = 0, count: Int = 1) -> [Card] {
        guard let pop = remainShowCards.pop() else {return []}
        return [pop]
    }

    func push(index: Int = 0, cards: [Card]) {
        cards.forEach { remainShowCards.push(card: $0)}
        NotificationCenter.default.post(
            name: .didPushShowCardNotification,
            object: self,
            userInfo: ["card": cards[0]]
        )
    }

    func top(index: Int = 0) -> Card? {
        return remainShowCards.top
    }

}

extension Notification.Name {
    static let didPushShowCardNotification = Notification.Name(rawValue: "didPushShowCard")
    static let removeAllShowCardNotification = Notification.Name(rawValue: "removeAllShowCard")
}
