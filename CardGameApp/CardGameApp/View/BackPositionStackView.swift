//
//  BackPositionStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 13..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class BackPositionStackView: PositionStackView {
    
    override func add(cards: [Card]) {
        
        for card in cards {
            let cardView = CardImageView(card: card)
            cardView.flip()
            self.addArrangedSubview(cardView)
        }
    }
}
