//
//  Goals.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goals {
    
    //MARK: - Properties
    //MARK: Private
    
    private var goals: [Suit: Goal]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init() {
        var goals: [Suit: Goal] = [:]
        
        for suit in Suit.allCases {
            goals[suit] = Goal(suit: suit)
        }
        
        self.goals = goals
    }
    
    func emptyAll() {
        for stack in goals.values {
            stack.empty()
        }
    }
}
