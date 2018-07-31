//
//  CardImageView.swift
//  CardGameApp
//
//  Created by 김수현 on 2018. 7. 23..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation
import UIKit

class CardImageView {

    private let width: CGFloat = UIScreen.main.bounds.width / 7
    private lazy var margin: CGFloat = self.width / 30
    private let ratio: CGFloat = 1.27
    private var statusBarMargin: CGFloat = 0

    func getCardImages(_ index: Int,_ image: String,_ statusBarMargin: CGFloat,_ cardSide: CardSide) -> UIImageView {
        var cardImageView = UIImageView()
        if cardSide == .back {
            cardImageView = UIImageView(image: UIImage(named: CardName.cardBack.rawValue))
        } else {
            cardImageView = UIImageView(image: UIImage(named: image))
        }
        cardImageView.frame = CGRect(origin: CGPoint(x: width * CGFloat(index) + margin, y: statusBarMargin), size: CGSize(width: width - margin, height: width * ratio))
        cardImageView.layer.cornerRadius = 5.0
        cardImageView.clipsToBounds = true
        return cardImageView
    }
    
    func getEmptyCardStack(_ index: Int) -> UIImageView {
        let imageView = UIImageView(image: UIImage())
        statusBarMargin = 20
        imageView.frame = CGRect(origin: CGPoint(x: width * CGFloat(index) + margin, y: statusBarMargin), size: CGSize(width: width - margin, height: width * ratio))
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }

}

enum CardName: String {
    case bgPattern = "bg_pattern"
    case cardBack = "card-back"
    case refresh = "refresh"
}

enum CardSide {
    case front
    case back
}

enum RemoveIdentifier: String  {
    case pickCardDeck = "pickCardDeck"
    case openCardDeck = "openCardDeck"
    case refreshCardDeck = "refreshCardDeck"
}

