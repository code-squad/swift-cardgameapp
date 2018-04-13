//
//  Player.swift
//  CardGame
//
//  Created by YOUTH on 2018. 1. 16..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Player: CustomStringConvertible {
    private(set) var stack: CardStack
    private(set) var position: Int?
    private(set) var score: Int

    var description: String {
        return "참가자#\(position!) " + stack.description
    }

    var name: String {
        return "참가자#\(position!)"
    }

    init(stack: CardStack, position: Int?, scoreChecker: ScoreChecker) {
        self.stack = stack
        self.position = position
        self.score = scoreChecker.totalScore(cardStack: stack)
    }

}
