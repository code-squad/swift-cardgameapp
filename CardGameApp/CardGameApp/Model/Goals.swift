//
//  Goals.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goals {
    
    //MARK: - Properties
    //MARK: Private
    
    private var goals: [Goal]
    
    //MARK: - Methods
    //MARK: Initialization
    
    init() {
        var goals = [Goal]()
        
        for _ in Suit.allCases {
            goals.append(Goal())
        }
        
        self.goals = goals
    }
    
    func emptyAll() {
        for stack in goals {
            stack.empty()
        }
    }
    
    func indexOfEmptyGoal() -> Int? {
        return goals.firstIndex(where: {$0.isEmpty()})
    }
    
    func position(of cardStack: CardStack) -> Int? {
        return self.goals.firstIndex(where: {$0===cardStack})
    }
    
    func positionOfMoveableToGoals(_ card: Card) -> Int? {
        return self.goals.firstIndex(where: {card.isMoveableToGoal($0.peek())})
    }
    
    func addToGoal(card: Card, position: Int) {
        goals[position].push(card: card)
    }
    
    func topCardPeek(with position: Int) -> Card? {
        return self.goals[position].peek()
    }
    
    func topCardPop(with position: Int) -> Card? {
        return self.goals[position].pop()
    }
}
