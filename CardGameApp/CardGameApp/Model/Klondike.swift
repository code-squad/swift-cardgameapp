//
//  Klondike.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 27..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Klondike {

    //MARK: - Properties
    
    private var pile = Pile()
    private var preview = Preview()
    private var goals = Goals()
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
    
    func flipCardsFromThePileToPreview() {
        guard let card = self.pile.pop() else {
            pile.putWithReverse(stack: preview)
            return
        }
        self.preview.push(card: card)
    }
    
    func position(of column: Column) -> Int? {
        return self.columns.position(of: column)
    }
    
    func movePreviewTopCard() {
        guard let topCardOfPreview = self.preview.peek() else { return }
        if topCardOfPreview.isA() {
            guard let card = self.preview.pop() else { return }
            goals.add(card: card)
        }
    }

}
