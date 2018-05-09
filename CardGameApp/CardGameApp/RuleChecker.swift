//
//  RuleChecker.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 8..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class RuleChecker {
    var foundationManager: Stackable!
    var stackManagers: Stackable!

    var availableFoundations = [Bool]()
    var availableStacks = [Bool]()

    init(foundationManager: Stackable,
         stackManagers: Stackable)
    {
        self.foundationManager = foundationManager
        self.stackManagers = stackManagers
    }

    func isValidToMove(newCard: Card) -> Bool {
        self.availableFoundations = self.foundationManager.isStackable(nextCard: newCard)
        self.availableStacks = self.stackManagers.isStackable(nextCard: newCard)

        if availableFoundations.count == 0 && availableStacks.count == 0 {
            return false
        } else {
            return true
        }
    }

    func sendCardToStackUp(newCard: Card) {
        for foundation in availableFoundations where foundation == true {
            foundationManager.stackUp(newCard: newCard)
            break
        }
        for stack in availableStacks where stack == true {
            stackManagers.stackUp(newCard: newCard)
            break
        }
    }

}
