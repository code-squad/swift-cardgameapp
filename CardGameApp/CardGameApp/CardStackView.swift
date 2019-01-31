//
//  CardStackView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 1. 31..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class CardStackView: UIStackView {

    func addCardViews(by cardStack: CardStack) {
        
        let addCardView = { [unowned self] (card: Card) -> Void in
            
            let cardView = CardImageView(card: card)
            self.addArrangedSubview(cardView)
        }
        cardStack.performByCards(addCardView)
    }
    
    func removeCardsViews() {
        
        for subView in arrangedSubviews {
            subView.removeFromSuperview()
        }
    }
}
