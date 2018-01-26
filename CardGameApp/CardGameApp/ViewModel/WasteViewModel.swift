//
//  WasteViewModel.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 22..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class WasteViewModel {
    private var wasteCards: CardStack

    init() {
        wasteCards = CardStack()
    }

    func allCards() -> [Card] {
        var cards = [Card]()
        while true {
            guard let pop = wasteCards.pop() else { break }
            cards.append(pop)
        }
        return cards
    }

    func removeAll() {
        wasteCards = CardStack()
        NotificationCenter.default.post(
            name: .removeAllWasteCardNotification,
            object: self
        )
    }
}

extension WasteViewModel: MovableViewModel {
    func faceUpCards(index: Int = 0, count: Int) -> [Card]? {
        return wasteCards.lastCards(count: count)
    }

    func targetIndex(card: Card) -> Int? {
        return 0
    }
    func pop(index: Int = 0, count: Int = 1) -> [Card] {
        guard let pop = wasteCards.pop() else {return []}
        return [pop]
    }

    func push(index: Int, cards: [Card]) {
        cards.forEach { wasteCards.push(card: $0)}
        NotificationCenter.default.post(
            name: .didPushWasteCardNotification,
            object: self,
            userInfo: ["card": cards[index]]
        )
    }

    func top(index: Int = 0) -> Card? {
        return wasteCards.top
    }

}

extension Notification.Name {
    static let didPushWasteCardNotification = Notification.Name(rawValue: "didPushShowCard")
    static let removeAllWasteCardNotification = Notification.Name(rawValue: "removeAllShowCard")
}
