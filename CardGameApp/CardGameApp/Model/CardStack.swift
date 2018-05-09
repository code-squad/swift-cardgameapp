//
//  CardStack.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 15..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct CardStack: CustomStringConvertible{

    private var cards = [Card]()
    var description: String {
        return cards.description
    }

    init() { } //empty stack

    init(_ cards: [Card]) {
        self.cards = cards
    }

    func getCards() -> [Card] {
        return self.cards
    }

    enum SortOrder {
        case Ascending
        case Descending
    }

    func sort(order: SortOrder) -> [Card] {
        switch order {
        case .Ascending:
            return cards.sorted()
        case .Descending:
            return cards.sorted(by: >)
        }
    }

    mutating func changeOpenLastCard() {
        guard let lastCard = self.cards.last else { return }
        lastCard.openLastCard()
        self.cards.removeLast()
        self.cards.append(lastCard)
    }

    // 초기 스택을 세팅할때 한번만 호출됨 > init으로 옮기는 것 고려
    func sortDefaultStack() {
        let lastIndex = self.cards.count - 1
        for i in 0..<self.cards.count {
            let cardInTurn = self.cards[i]
            if cardInTurn.side == .back {
                guard i == lastIndex else { continue }
                cardInTurn.openLastCard()
            } else {
                guard i == lastIndex else {
                    cardInTurn.turnOver()
                    continue
                }
                cardInTurn.openLastCard()
            }
        }
    }

    func getCard(at index: Int) -> Card {
        return self.cards[index]
    }

    func count() -> Int {
        return self.cards.count
    }

    func last() -> Card? {
        return self.cards.last
    }

    mutating func push(newCard: Card) {
        self.cards.append(newCard)
    }

    mutating func pop() {
        self.cards.removeLast()
    }

    func isEmpty() -> Bool {
        return (self.cards.count == 0)
    }

}



