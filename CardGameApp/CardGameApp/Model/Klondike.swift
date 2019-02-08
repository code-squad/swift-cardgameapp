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
    private var preview = Preview()
    private var pile: Pile
    private var columns: Columns
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(deck: Deck) {
        
        var deck = deck
        deck.shuffle()
        let cardStacks: [CardStack] = deck.willSetDeck(few: 7)
        self.columns = Columns(cardStacks: cardStacks)
        let remainingCardStack = deck.remainingCards()
        self.pile = Pile(cardStack: remainingCardStack)
    }
}
