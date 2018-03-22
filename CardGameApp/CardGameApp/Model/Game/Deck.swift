//
//  Deck.swift
//  CardGame
//
//  Created by 심 승민 on 2017. 11. 28..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class Deck: Sequence {
    // 덱에 있는 카드들. (52장)
    private var cardStack: CardStack!
    let start: Int = 0

    init() {
        self.reset()
    }

    func makeIterator() -> ClassIteratorOf<Card> {
        return ClassIteratorOf(self.cardStack.sorted())
    }

    // 여러 장의 카드를 스택으로 반환.
    func fetch(_ count: Int) -> [Card]? {
        guard self.cardStack.count - count > 0 else { return nil }
        let removedCards = CardStack()
        for _ in 0..<count {
            guard let popedCard = self.cardStack.pop() else { break }
            removedCards.push(card: popedCard)
        }
        return removedCards.cards.collection
    }

    func remnants() -> [Card]? {
        return self.cardStack.cards.collection
    }

}

// 덱도 카드스택의 일종.
extension Deck: CardGameStack {
    var count: Int {
        return self.cardStack.count
    }
    var isEmpty: Bool {
        return self.cardStack.isEmpty
    }

    func pop() -> Card? {
        return self.cardStack.pop()
    }

    func push(card: Card) {
        // 52장보다 적은 경우에만 넣을 수 있음.
        guard self.cardStack.count < 52 else { return }
        self.cardStack.push(card: card)
    }

    func peek() -> Card? {
        return self.cardStack.peek()
    }

    func shuffle() {
        self.cardStack.shuffle()
    }

    // 정렬된 카드 52장 새로 생성.
    func reset() {
        let aStackOfCards = CardStack()
        let shapes = Shape.allValues
        let numbers = Number.allValues
        // 모든 모양, 숫자의 조합으로 카드 52장 생성.
        for shape in shapes {
            for number in numbers {
                aStackOfCards.push(card: Card(shape, number))
            }
        }
        self.cardStack = aStackOfCards
    }

}
