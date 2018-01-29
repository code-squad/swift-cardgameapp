//
//  UIImageView+CardView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 29..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeCardView(screenWidth: CGFloat, index: Int, yCoordinate: CGFloat) {
        let marginRatio: CGFloat = 70
        let cardsNumber: CGFloat = 7
        let cardWidth = (screenWidth / cardsNumber) - (screenWidth / marginRatio)
        let margin = (screenWidth - (cardWidth * cardsNumber)) / (cardsNumber + 1)
        let xCoordinate = ((cardWidth + margin) * CGFloat(index)) + margin        
        self.frame = CGRect(x: xCoordinate, y: yCoordinate, width: cardWidth, height: (screenWidth / cardsNumber) * 1.27)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
    }
}
