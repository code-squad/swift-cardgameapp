//
//  WholeStackDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 7..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class WholeStackDelegate {
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


}
