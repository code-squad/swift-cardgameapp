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
    
    func index(of column: Column) -> Int? {
        return self.columns.position(of: column)
    }
    
    func index(of goal: Goal) -> Int? {
        return self.goals.position(of: goal)
    }
    
    func movePreviewTopCard() {
        guard let card = self.preview.peek() else { return }
        
        if card.isA(), let index = goals.indexOfEmptyGoal() {
            self.preview.removeTopCard()
            goals[index]?.push(card: card)
        } else if card.isK(), let index = columns.indexOfEmptyColumn() {
            self.preview.removeTopCard()
            columns[index]?.push(card: card)
        } else if let moveableIndexOfGoals = goals.indexOfMoveableToGoals(card) {
            self.preview.removeTopCard()
            goals[moveableIndexOfGoals]?.push(card: card)
        } else if let moveableIndexOfColumns = columns.indexOfMoveableToColumns(card) {
            self.preview.removeTopCard()
            columns[moveableIndexOfColumns]?.push(card: card)
        }
    }
    
    func moveGoalTopCard(index: Int) {
        guard let card = self.goals[index]?.peek() else { return }
        
        if let moveableIndexOfColumns = columns.indexOfMoveableToColumns(card) {
            self.goals[index]?.removeTopCard()
            columns[moveableIndexOfColumns]?.push(card: card)
        }
    }
    
    func moveColumnCardIn(position: Position) {
        let column = position.column
        let row = position.row
        guard let card = columns[column]?.cardIn(position: row) else { return }
        
        if card.isA(), let index = goals.indexOfEmptyGoal(), card == columns[column]?.peek() {
            columns[column]?.removeTopCard()
            goals[index]?.push(card: card)
        } else if let moveableIndexOfGoals = goals.indexOfMoveableToGoals(card), card == columns[column]?.peek() {
            columns[column]?.removeTopCard()
            goals[moveableIndexOfGoals]?.push(card: card)
        } else if let moveableIndexOfColumns = columns.indexOfMoveableToColumns(card), let cards = columns[column]?.cardsIn(position: row) {
            columns[moveableIndexOfColumns]?.put(stack: CardStack(cards: cards))
        } else if card.isK(), let index = columns.indexOfEmptyColumn(), let cards = columns[column]?.cardsIn(position: row) {
            columns[index]?.put(stack: CardStack(cards: cards))
        }
    }
    
    func move(_ dragPoint: DraggingPosition, to dropPoint: DraggingPosition) {
        var cards: [Card]?
        switch dragPoint {
        case let .columns(column: column, row: row):
            cards = columns[column]?.cardsIn(position: row)
        case let .goals(column: column):
            guard let card = goals[column]?.peek() else { return }
            cards = [card]
        case .preview:
            guard let card = preview.peek() else { return }
            cards = [card]
        }
        guard let draggingCards = cards else { return }
        switch dropPoint {
        case let .columns(column: column, row: _):
            if columns[column]?.isEmpty() ?? false, draggingCards.first?.isK() ?? false {
                columns[column]?.put(stack: CardStack(cards: draggingCards))
                removeCards(with: dragPoint, number: draggingCards.count)
            } else if let card = draggingCards.first, columns[column]?.isMoveable(card) ?? false {
                columns[column]?.put(stack: CardStack(cards: draggingCards))
                removeCards(with: dragPoint, number: draggingCards.count)
            }
        case let .goals(column: column):
            if draggingCards.count == 1, goals[column]?.isEmpty() ?? false, draggingCards.first?.isA() ?? false {
                goals[column]?.put(stack: CardStack(cards: draggingCards))
                removeCards(with: dragPoint, number: draggingCards.count)
            } else if draggingCards.count == 1, let card = draggingCards.first, goals[column]?.isMoveable(card) ?? false {
                goals[column]?.push(card: card)
                removeCards(with: dragPoint, number: draggingCards.count)
            }
        default:
            return
        }
    }
    
    private func removeCards(with position: DraggingPosition, number: Int) {
        switch position {
        case let .columns(column: column, row: _):
            columns[column]?.remove(number)
        case let .goals(column: column):
            goals[column]?.remove(number)
        case .preview:
            preview.remove(number)
        }
    }
}
