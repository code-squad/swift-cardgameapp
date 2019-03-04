//
//  Columns.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Columns {
    
    //MARK: - Properties
    //MARK: Pirvate
    
    private var columns: [Column]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init(countOfColumns: Int = 7) {
        var columns = [Column]()
        
        for _ in 0..<countOfColumns {
            columns.append(Column())
        }
        
        self.columns = columns
    }
    
    //MARK: Instance
    
    func add(stack: CardStack, to position: Int) {
        self.columns[position].put(stack: stack)
    }
    
    func emptyAll() {
        for stack in columns {
            stack.empty()
        }
    }
    
    func position(of cardStack: CardStack) -> Int? {
        return self.columns.firstIndex(where: {$0===cardStack})
    }
    
    func indexOfEmptyColumn() -> Int? {
        return columns.firstIndex(where: {$0.isEmpty()})
    }
    
    func positionOfMoveableToColumns(_ card: Card) -> Int? {
        return self.columns.firstIndex(where: {card.isMoveableToColumn($0.peek())})
    }
    
    func add(card: Card, position: Int) {
        columns[position].push(card: card)
    }
    
    func peekCardIn(position: (Int, Int)) -> Card? {
        let column = position.0
        let row = position.1
        guard let card = columns[column].cardIn(position: row) else { return nil }
        return card
    }
    
    func isTop(card: Card, in position: Int) -> Bool {
        guard let cardInColumn = self.columns[position].peek() else { return false }
        return cardInColumn == card
    }
    
    func popTopCard(position: Int) -> Card? {
        return columns[position].pop()
    }
    
    func popStackIn(position: (Int, Int)) -> CardStack {
        let column = position.0
        let row = position.1
        let cards = columns[column].cardsIn(position: row)
        return CardStack(cards: cards)
    }
}
