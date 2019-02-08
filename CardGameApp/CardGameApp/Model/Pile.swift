//
//  Pile.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 8..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Pile {
    
    //MARK: - Properties
    //MARK: Private
    
    private var pile: Deck
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(deck: Deck) {
        self.pile = deck
    }
}
