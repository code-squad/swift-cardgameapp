//
//  CardView.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 1. 26..
//  Copyright © 2018년 Napster. All rights reserved.
//

import UIKit

class CardView: UIView {
    func makeCardView(screenWidth: CGFloat, index: Int) -> UIImageView {
        let marginRatio: CGFloat = 70
        let cardsNumber: CGFloat = 7
        let cardWidth = (screenWidth / cardsNumber) - (screenWidth / marginRatio)
        let margin = (screenWidth - (cardWidth * cardsNumber)) / (cardsNumber + 1)
        let card = UIImageView(image: UIImage(named: "card_back"))
        let xCoordinate = ((cardWidth + margin) * CGFloat(index)) + margin
        card.frame = CGRect(x: xCoordinate, y: 32, width: cardWidth, height: (screenWidth / cardsNumber) * 1.27)
        return card
    }
}
