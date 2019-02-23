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
    private var pile = Pile()
    private var columns = Columns()
    
    //MARK: - Methods
    
    func setUp() {
        var deck = Deck()
        deck.shuffle()
        
        let rangeOfStack = 1...7
        for few in rangeOfStack {
            let stack = deck.draw(few: few)
            let position = few - 1
            self.columns.add(stack: stack, to: position)
        }
        
        let stack = deck.remainingCards()
        self.pile.put(stack: stack)
    }
    
    func reset() {
        goals.emptyAll()
        preview.empty()
        pile.empty()
        columns.emptyAll()
        
        setUp()
    }
    
    func flipCardsFromPileToPreview() {
        guard let card = self.pile.pop() else { return }
        self.preview.push(card: card)
    }
}
