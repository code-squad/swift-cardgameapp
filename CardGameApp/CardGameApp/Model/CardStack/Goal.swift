//
//  Goal.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goal: CardStack {
    func isMoveable(_ card: Card) -> Bool {
        guard let peekCard = self.peek() else { return false }
        return peekCard.isSameSuit(card) && peekCard.isOneStepUpRank(card: card)
    }
}
