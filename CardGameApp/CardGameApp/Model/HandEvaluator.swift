//
//  File.swift
//  CardGame
//
//  Created by jack on 2018. 1. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct HandEvaluator {
    
    private var handsOfPlayers : [Hand] = []
    private var stacksOfPlayers : [[Card]] = []
    
    init(_ userStacks : [[Card]]) {
        self.stacksOfPlayers = userStacks
        for indexOfStack in 0..<userStacks.count {
            handsOfPlayers.append(Hand.init(userStacks[indexOfStack]))
        }
    }
    
    func generateHandOfWinner() -> WinnerInfo {
        var evaluatedHands = self.handsOfPlayers.sorted { $0 > $1 }
        let handOfWinner = evaluatedHands[0].hand
        let numberOfWinner = self.handsOfPlayers.index(where: {$0.isSameHand(evaluatedHands[0])}) ?? 0
        return WinnerInfo.init(handOfWinner, numberOfWinner)
    }
    
}

