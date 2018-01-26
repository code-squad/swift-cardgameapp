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
        let cardWidth = (screenWidth / 7) - (screenWidth / 65)
        let margin = (screenWidth - (cardWidth * 7)) / 7
        let card = UIImageView(image: UIImage(named: "card_back"))
        let xCoordinate = ((cardWidth + cardWidth / 10) * CGFloat(index)) + margin
        card.frame = CGRect(x: xCoordinate, y: 32, width: cardWidth, height: (screenWidth / 7) * 1.27)
        return card
    }
}
