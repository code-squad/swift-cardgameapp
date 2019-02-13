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
    
    private var goals: [Suit: CardStack] = [:]
    private var preview = CardStack()
    private var pile = CardStack()
    private var columns: [CardStack] = []
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(deck: Deck) {
        
        var deck = deck
        
        let cardStacks = deck.willSetDeck(few: 7)
        let remainingCards = deck.remainingCards()
        
        for suit in Suit.allCases {
            self.goals[suit] = CardStack()
        }
        
        for _ in 0..<7 {
            self.columns.append(CardStack())
        }
    }
    
    func start() {
        
    }
}
