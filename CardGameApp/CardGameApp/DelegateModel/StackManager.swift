//
//  StackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 3..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class StackManager: StackDelegate {
    private static var stackDelegates = [StackManager]()
    private var column: Int!
    private var stack: CardStack!
    private var lastCard: Card? {
        return self.stack.last()
    }

    init(oneStack: CardStack, column: Int) {
        self.stack = oneStack
        self.column = column
    }

    func currentLastCard() -> Card {
        return self.lastCard!
    }

    // 다음에 오는 카드가 숫자가 연속되고 색깔이 다른지 판단
    // 만약 스택이 비었다면, 첫번째 오는 카드가 K인지 판단
    func isStackable(nextCard: Card) -> Bool {
        if let last = self.lastCard {
            return last.isHigher(than: nextCard)
        } else {
            return nextCard.isDenominationK()
        }
    }

    func stackOne(card: Card) {
        if card.side == .back {
            card.turnOver()
        }
        self.stack.push(newCard: card)
    }

    func stackUp(newCards: [Card]) {
        newCards.forEach{
            self.stack.push(newCard: $0)
        }
    }

    func countOfCard() -> Int {
        return self.stack.count()
    }

    func cardInTurn(at index: Int) -> Card {
        return self.stack.getCard(at: index)
    }

    func removePoppedCard() {
        self.stack.pop()
    }

    func movableCards(from: Int) -> [Card] {
        var temp = [Card]()
        for i in from..<countOfCard() {
            temp.append(self.cardInTurn(at: i))
        }
        return temp
    }

    func removeCards(from index: Int) {
        for _ in index..<countOfCard() {
            removePoppedCard()
        }
    }
}

