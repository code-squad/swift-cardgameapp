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
            let cards = deck.draw(few: few)
            let position = few - 1
            self.columns[position] = Column(cards: cards)
        }
        
        let stack = deck.remainingCards()
        self.pile.put(stack: stack)
    }
    
    func reset() {
        goals.emptyAll()
        preview.empty()
        pile.empty()
        columns.removeAll()
        
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
    
    func position(of goal: Goal) -> Int? {
        return self.goals.position(of: goal)
    }
    
    func movePreviewTopCard() {
        guard let card = self.preview.peek() else { return }
        
        if card.isA(), let index = goals.indexOfEmptyGoal() {
            guard let card = self.preview.pop() else { return }
            goals.add(card: card, position: index)
        } else if card.isK(), let index = columns.indexOfEmptyColumn() {
            guard let card = self.preview.pop() else { return }
            columns.add(card: card, position: index)
        } else if let moveablePositionOfGoals = goals.positionOfMoveableToGoals(card) {
            guard let card = self.preview.pop() else { return }
            goals.add(card: card, position: moveablePositionOfGoals)
        } else if let moveablePositionOfColumns = columns.positionOfMoveableToColumns(card) {
            guard let card = self.preview.pop() else { return }
            columns.add(card: card, position: moveablePositionOfColumns)
        }
    }
    
    func moveGoalTopCard(position: Int) {
        guard let card = self.goals.topCardPeek(with: position) else { return }
        
        if let moveablePositionOfColumns = columns.positionOfMoveableToColumns(card) {
            guard let card = self.goals.topCardPop(with: position) else { return }
            columns.add(card: card, position: moveablePositionOfColumns)
        }
    }
    
    func moveColumnCardIn(position: (Int, Int)) {
        guard let card = self.columns.peekCardIn(position: position) else { return }
        let column = position.0
        
        if card.isA(), let index = goals.indexOfEmptyGoal(), columns.isTop(card: card, in: column) {
            guard let card = columns.popTopCard(position: column) else { return }
            goals.add(card: card, position: index)
        } else if let moveablePositionOfGoals = goals.positionOfMoveableToGoals(card), columns.isTop(card: card, in: column) {
            guard let card = columns.popTopCard(position: column) else { return }
            goals.add(card: card, position: moveablePositionOfGoals)
        } else if let moveablePositionOfColumns = columns.positionOfMoveableToColumns(card) {
            let stack = columns.popStackIn(position: position)
            columns.add(stack: stack, to: moveablePositionOfColumns)
        } else if card.isK(), let index = columns.indexOfEmptyColumn() {
            let stack = columns.popStackIn(position: position)
            columns.add(stack: stack, to: index)
        }
    }
}
