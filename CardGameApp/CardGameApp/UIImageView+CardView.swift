//
//  UIImageView+CardView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 29..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeCardView(screenWidth: CGFloat, index: Int) {
        let marginRatio: CGFloat = 70
        let cardsNumber: CGFloat = 7
        let cardWidth = (screenWidth / cardsNumber) - (screenWidth / marginRatio)
        let margin = (screenWidth - (cardWidth * cardsNumber)) / (cardsNumber + 1)
        let xCoordinate = ((cardWidth + margin) * CGFloat(index)) + margin        
        self.frame = CGRect(x: xCoordinate, y: 32, width: cardWidth, height: (screenWidth / cardsNumber) * 1.27)
    }
}
