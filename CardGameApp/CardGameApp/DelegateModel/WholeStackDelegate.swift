//
//  WholeStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 7..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class WholeStackDelegate: Stackable {
    var stackManagers: [StackDelegate]!

    init(stacks: [CardStack]) {
        var stackManagers = [StackDelegate]()
        for i in 0..<stacks.count {
            stackManagers.append(StackDelegate(oneStack: stacks[i], column: i))
        }
        self.stackManagers = stackManagers
    }

    func getStackDelegate(of column: Int) -> StackDelegate {
        return self.stackManagers[column]
    }

    func isStackable(nextCard card: Card) -> [Bool] {
        return stackManagers.map{ $0.isStackable(nextCard: card) }
    }

    func stackUp(newCard: Card) {
        for stack in stackManagers where stack.isStackable(nextCard: newCard) {
            stack.stackUp(newCard: newCard)
            break
        }
    }

    func removePoppedCard(of column: Int) {
        stackManagers[column].removePoppedCard()
    }

    func lastCard(of column: Int) -> Card {
        return stackManagers[column].currentLastCard()
    }

}
