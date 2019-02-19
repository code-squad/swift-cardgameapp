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
    
    private var goals: [Suit: CardStack] = [:]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init() {
        
        for suit in Suit.allCases {
            self.goals[suit] = CardStack()
            let stackType = CardStackType.goals(type: suit)
            self.goals[suit]?.setType(stackType)
        }
    }
    
    func emptyAll() {
        
        for stack in goals.values {
            stack.empty()
        }
    }
}
