//
//  CardStack.swift
//  CardGameApp
//
//  Created by yangpc on 2017. 12. 28..
//  Copyright © 2017년 yang hee jung. All rights reserved.
//

import Foundation

class CardStack: NSObject, NSCopying {
    var cards = [Card]()

    override init() {
        super.init()
    }
    required init(_ cardStack: CardStack) {
        cards = cardStack.cards
    }
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

    func push(card: Card) {
        cards.append(card)
    }

    @discardableResult func pop() -> Card? {
        guard let card = cards.popLast() else {
            return nil
        }
        return card
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(self)
    }

}
