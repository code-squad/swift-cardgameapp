//
//  PileStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class PositionStackView: UIStackView, CardGameStackView {
    
    //MARK: - Methods
    //MARK: Initialization
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.spacing = -self.frame.height
    }
    
    //MARK: Instance
    
    func update(cards: [Card]) {
        
        self.removeAllSubviews()
        add(cards: cards)
    }
    
    func add(cards: [Card]) {
        
        for card in cards {
            let cardView = CardImageView(card: card)
            self.addArrangedSubview(cardView)
        }
    }
}
