//
//  GoalsStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 27..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class GoalsStackView: PositionStackView {
    
    override func add(cards: [Card]) {
        for card in cards {
            let cardView = GoalView(card: card)
            self.addArrangedSubview(cardView)
        }
    }
}
