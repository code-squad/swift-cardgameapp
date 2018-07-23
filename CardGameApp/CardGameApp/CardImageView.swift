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
    private let statusBarMargin: CGFloat = 25

    func getCardBackImages(_ index: Int) -> UIImageView {
        let cardImageView = UIImageView(image: UIImage(named: CardName.cardBack.rawValue))
        cardImageView.frame = CGRect(origin: CGPoint(x: width * CGFloat(index) + margin, y: statusBarMargin), size: CGSize(width: width - margin, height: width * ratio))
        cardImageView.layer.cornerRadius = 5.0
        cardImageView.clipsToBounds = true
        return cardImageView
    }

}

enum CardName: String {
    case bgPattern = "bg_pattern"
    case cardBack = "card-back"
}
