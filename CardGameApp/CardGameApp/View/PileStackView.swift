//
//  PileStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class PileStackView: UIStackView {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.spacing = -self.frame.height
    }
}

extension UIStackView {
    
    func add(cardStack: CardStack) {
        
        let addSubview: (Card) -> Void = { (card: Card) -> Void in
            
            let cardView = CardImageView(card: card)
            self.addArrangedSubview(cardView)
        }
        
        cardStack.performWithCards(addSubview)
    }
}
