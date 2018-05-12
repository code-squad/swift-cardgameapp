//
//  StackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 3..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class StackDelegate: StackManageable {

    private static var stackDelegates = [StackDelegate]()

    private var lastCard: Card? {
        return self.stack.last()
    }
    private var column: Int!
    private var stack: CardStack!

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

    func stackUp(newCard: Card) {
        if newCard.side == .back {
            newCard.turnOver()
        }
        self.stack.push(newCard: newCard)
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
}

