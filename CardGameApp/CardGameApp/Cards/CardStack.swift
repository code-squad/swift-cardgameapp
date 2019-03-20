//
//  CardStack.swift
//  CardGameApp
//
//  Created by 윤동민 on 19/02/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

class CardStack {
    private var stack: [Card]
    
    init() {
        stack = []
    }
    
    func add(_ card: Card) {
        stack.append(card)
    }
    
    func removeOne() -> Card? {
        guard stack.count != 0 else { return nil }
        return stack.remove(at: stack.count-1)
    }
    
    func getLast() -> Card {
        return stack[stack.count-1]
    }
    
    func accessCard(form: ([Card]) -> Void) {
        form(stack)
    }
    
    func accessLastCard(form: (Card) -> Bool) -> Bool {
        return form(stack[stack.count-1])
    }

    func removeAll() {
        stack.removeAll()
    }
    
    func isEmpty() -> Bool {
        return stack.isEmpty
    }
    
    func isLastCardOne() -> Bool {
        return stack[stack.count-1].number == .one
    }
    
    func isLastCardK() -> Bool {
        return stack[stack.count-1].number == .thirteen
    }
    
    func count() -> Int {
        return stack.count
    }
}
