//
//  WholeStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 7..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class WholeStackManager: CardStackDelegate, Stackable, Draggable {

    private var stackManagers: [StackDelegate]!

    init(stacks: [CardStack]) {
        var stackManagers = [StackDelegate]()
        for i in 0..<stacks.count {
            stackManagers.append(StackManager(oneStack: stacks[i], column: i))
        }
        self.stackManagers = stackManagers
    }

    func getStackDelegate(of column: Int) -> StackDelegate {
        return self.stackManagers[column]
    }

    func stackable(nextCard card: Card) -> Int? {
        for i in 0..<stackManagers.count {
            guard stackManagers[i].isStackable(nextCard: card) else { continue }
            return i
        }
        return nil
    } // 가능한 스택의 column리턴

    func stackOne(card: Card, column: Int) {
        stackManagers[column].stackOne(card: card)
    }

    func removePoppedCard(of column: Int) {
        stackManagers[column].removePoppedCard()
    }

    func lastCard(of column: Int) -> Card {
        return stackManagers[column].currentLastCard()
    }

    func stackUp(cards: [Card], column: Int) {
        stackManagers[column].stackUp(newCards: cards)
    }

}
