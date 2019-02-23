//
//  Goal.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goal: CardStack {
    
    private let position: Suit
    
    init(suit: Suit) {
        self.position = suit
    }
}
