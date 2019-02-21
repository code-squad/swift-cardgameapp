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
    
    func accessCard(form: ([Card]) -> Void) {
        form(stack)
    }
}
