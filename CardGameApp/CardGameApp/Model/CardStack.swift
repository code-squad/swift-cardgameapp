//
//  CardStack.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 15..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct CardStack {

    private var cards = [Card]()

    init() { } //empty stack

    init(_ cards: [Card]) {
        self.cards = cards
        
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
        arrangeStack()
    }

    func arrangeStack() {
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

    func isEmpty() -> Bool {
        return (self.cards.count == 0)
    }

}



