//
//  CardView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class CardView: UIView {
    private let cardInfo: Card

    func layCards() {
        guard let superview = superview else { return }
        var cardPosition = CGPoint(x: superview.layoutMargins.left, y: superview.layoutMargins.top)
        while cardPosition.x+cardSize.width <= superview.frame.maxX-superview.layoutMargins.right {
            let cardView = generateCard(cardPosition)
            superview.addSubview(cardView)
            cardPosition = CGPoint(x: cardView.frame.maxX+cardMargins,
                                   y: superview.layoutMargins.top)
        }
    }

    private var numberOfCards: CGFloat = 7

    private var cardMargins: CGFloat {
        guard let superview = superview else { return 0 }
        let widthWithoutSafeArea = superview.frame.size.width-superview.layoutMargins.left-superview.layoutMargins.right
        return (widthWithoutSafeArea-cardSize.width*numberOfCards)/numberOfCards
    }

    private var cardSize: CGSize {
        guard let superview = superview else { return CGSize() }
        let width = superview.frame.size.width/numberOfCards-7
        let height = width*1.27
        return CGSize(width: width, height: height)
    }

    private func generateCard(_ origin: CGPoint) -> UIImageView {
        let cardImage = UIImage(imageLiteralResourceName: "card-back")
        let cardImageView = UIImageView(image: cardImage)
        cardImageView.frame.origin = origin
        cardImageView.frame.size = cardSize
        return cardImageView
    }

}
