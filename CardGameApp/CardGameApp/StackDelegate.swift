//
//  StackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 3..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class StackDelegate {
    private static var stackDelegates = [StackDelegate]()

    private var lastCard: Card {
        return self.stack.last()!
    }
    private var column: Int!
    private var stack: CardStack!

    init(oneStack: CardStack, column: Int) {
        self.stack = oneStack
        self.column = column
    }

    func currentLastCard() -> Card {
        return self.lastCard
    }

    func isStackable(nextCard: Card) -> Bool {
        // 다음에 오는 카드(더블탭된 카드)가 숫자가 연속되고 색깔이 다른지 판단
        if nextCard < self.lastCard && nextCard != self.lastCard {
            return true
        } else {
            return false
        }
    }

    func stackUp(newCard: Card) {
        if self.isStackable(nextCard: newCard) {
            self.stack.stackUp(newCard: newCard)
        } else if self.stack.isEmpty() {
            self.stack.stackUp(newCard: newCard)
        }
    }

    func countOfCard() -> Int {
        return self.stack.count()
    }

    func cardInTurn(at index: Int) -> Card {
        return self.stack.getCard(at: index)
    }

}

