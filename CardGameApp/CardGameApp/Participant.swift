//
//  Participant.swift
//  CardGame
//
//  Created by 조재흥 on 18. 12. 7..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Participant : GamePlayer {
    private let role : String
    private var cards : CardStack
    
    var description: String {
        return "\(self.role) \(self.cards)"
    }
    
    init(name:String, cards:CardStack) {
        self.role = name
        self.cards = cards
    }
    
    func score() -> Int {
        return ScoreCalculator.calculateScore(cardStack: self.cards)
    }
}
