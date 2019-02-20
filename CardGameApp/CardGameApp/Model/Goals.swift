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
    
    private var goals: [Suit: CardStack]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init() {
        
        var goals: [Suit: CardStack] = [:]
        
        for suit in Suit.allCases {
            goals[suit] = CardStack()
            let stackType = CardStackType.goals(type: suit)
            goals[suit]?.setType(stackType)
        }
        
        self.goals = goals
    }
    
    func emptyAll() {
        
        for stack in goals.values {
            stack.empty()
        }
    }
}
