//
//  Klondike.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 7..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Klondike {
    
    //MARK: - Properties
    //MARK: Private
    
    private var goals = Goals()
    private var preview = CardStack(type: .preview)
    private var pile = CardStack(type: .pile)
    private var columns = Columns()
    
    //MARK: - Methods
    
    func setUp() {
        
        var deck = Deck()
        deck.shuffle()
        
        for few in 1...7 {
            let stack = deck.draw(few: few)
            let position = few - 1
            self.columns.add(stack: stack, to: position)
        }
        
        let stack = deck.remainingCards()
        self.pile.put(stack: stack)
    }
}
