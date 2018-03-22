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
    private(set) var cards: ObservableCollection<[Card]>
    let start: Int = 0
    private var prevCount: Int = 0
    init() {
        self.cards = ObservableCollection([])
    }

    init(_ cards: [Card]) {
        self.cards = ObservableCollection(cards)
    }

    // 내부 카드들에 접근 가능.
    func makeIterator() -> ClassIteratorOf<Card> {
        return ClassIteratorOf(self.cards.collection)
    }
}

extension CardStack: CardGameStack {
    var isAdded: Bool {
        return (cards.prevCount < count) ? true : false
    }

    var count: Int {
        return self.cards.collection.count
    }

    var isEmpty: Bool {
        return self.cards.collection.isEmpty
    }

    func push(card: Card) {
        self.cards.collection.append(card)
    }

    func pop() -> Card? {
        return self.cards.collection.popLast()
    }

    func peek() -> Card? {
        return self.cards.collection.last
    }

    func shuffle() {
        guard let shuffledCards = self.cards.collection.shuffle() else { return }
        self.cards = ObservableCollection(shuffledCards)
    }

    func reset() {
        self.cards = ObservableCollection([])
    }

    var endIndex: Int {
        return self.cards.collection.endIndex
    }
}
