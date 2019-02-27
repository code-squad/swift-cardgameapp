//
//  PreviewStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 27..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class PreviewStackView: PositionStackView {
    
    override func add(cards: [Card]) {
        for card in cards {
            let cardView = PreviewView(card: card)
            self.addArrangedSubview(cardView)
        }
    }
}
