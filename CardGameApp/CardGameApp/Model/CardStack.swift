//
//  CardStack.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 특정 개수의 카드 뭉치 클래스.
class CardStack: Sequence {
    private(set) var cards: [Card]
    let start: Int = 0
    init() {
        self.cards = []
    }

    init(_ cards: [Card]) {
        self.cards = cards
    }

    // 내부 카드들에 접근 가능.
    func makeIterator() -> ClassIteratorOf<Card> {
        return ClassIteratorOf(self.cards)
    }
}

extension CardStack: CardGameStack {
    var count: Int {
        return self.cards.count
    }
    var isEmpty: Bool {
        return self.cards.isEmpty
    }

    func push(card: Card) {
        self.cards.append(card)
    }

    func pop() -> Card? {
        return self.cards.popLast()
    }

    func peek() -> Card? {
        return self.cards.last
    }

    func shuffle() {
        guard let shuffledCards = self.cards.shuffle() else { return }
        self.cards = shuffledCards
    }

    func reset() {
        self.cards = []
    }

    var endIndex: Int {
        return self.cards.endIndex
    }
}
