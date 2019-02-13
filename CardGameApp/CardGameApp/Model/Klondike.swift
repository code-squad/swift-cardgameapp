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
    private var preview = CardStack()
    private var pile : CardStack
    private var columns: Columns
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(deck: Deck) {
        
        var deck = deck

        let cardStacks = deck.willSetDeck(few: 7)
        self.columns = Columns(cardStacks: cardStacks)
        
        let remainingCards = deck.remainingCards()
        self.pile = remainingCards
    }
}
