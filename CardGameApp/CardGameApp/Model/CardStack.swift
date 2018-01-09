//
//  CardStack.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import Foundation

struct CardStack {
    private var cards = [Card]()

    init() {}
    init(cards: [Card]) {
        self.cards = cards
    }

    var isEmpty: Bool {
        return cards.isEmpty
    }

    var count: Int {
        return cards.count
    }

    var top: Card? {
        return cards.last
    }

    mutating func push(card: Card) {
        cards.append(card)
//        NotificationCenter.default.post(
//            name: .didPushCardStackNotifiacation,
//            object: self,
//            userInfo: ["card": card]
//        )
    }

    @discardableResult mutating func pop() -> Card? {
        guard let card = cards.popLast() else {
            return nil
        }
//        NotificationCenter.default.post(
//            name: .didPopCardStackNotifiacation,
//            object: self,
//            userInfo: ["card": card]
//        )
        return card
    }
}

extension Notification.Name {
    static let didPopCardStackNotifiacation = Notification.Name(rawValue: "didPopCardStack")
    static let didPushCardStackNotifiacation = Notification.Name(rawValue: "didPushCardStack")
}
