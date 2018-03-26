//
//  Tableau.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 3. 22..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

class Tableau: CardStack {
    func reset(with cards: [Card]) {
        self.reset()
        self.push(cards: cards)
    }

    func canPush(_ cards: [Card]) -> Bool {
        guard let firstCard = cards.first else { return false }
        return canPush(below: firstCard)
    }

    func canPush(below card: Card) -> Bool {
        // 빈 경우, K만 받음.
        if isEmpty {
            return card.number == .king
        }
        // 마지막 카드가 A인 경우, 더 이상 카드를 받지 않음
        if let lastCard = cards.element, lastCard.number == .ace {
            return false
        }
        // 현재 스택의 마지막 카드보다 숫자가 1 작고, 색상은 반대인 경우 true
        return (card.number.rawValue == peek()!.number.rawValue-1) && (card.color != peek()!.color)
    }

    func push(cards: [Card]) {
        cards.forEach {
            push(card: $0)
        }
    }

    func popCards(below selectedCard: Card) -> [Card] {
        var cardsToMove: [Card] = []
        for candidateCard in self.reversed() {
            cardsToMove.insert(pop()!, at: 0)
            if candidateCard == selectedCard {
                break
            }
        }
        return cardsToMove
    }

    func index(of card: Card) -> Int? {
        for (index, currCard) in cards.collection.enumerated() where currCard == card {
            return index
        }
        return nil
    }

    func isBottom(_ card: Card) -> Bool {
        return peek() == card
    }

}
