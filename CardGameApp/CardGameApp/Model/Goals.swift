//
//  Goals.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 8..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goals {
    
    //MARK: - Properties
    //MARK: Private
    
    private var goals: [Suit: CardStack] = [.clubs: CardStack(),
                                            .hearts: CardStack(),
                                            .diamonds: CardStack(),
                                            .spades: CardStack(),]
}
