//
//  CardView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class CardView: UIImageView {
    private var frontImage: UIImage?
    private var backImage: UIImage?
    private var isFaceUp: Bool = false
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = Constants.CardView.cornerRadius
        self.clipsToBounds = Constants.CardView.clipsToBounds
        self.layer.borderColor = Constants.CardView.borderColor
        self.layer.borderWidth = Constants.CardView.borderWidth
    }
    convenience init(sizeOf cardSize: CGSize) {
        self.init(frame: .zero)
        self.widthAnchor.constraint(equalToConstant: cardSize.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: cardSize.height).isActive = true
    }

}

extension CardView {
    func setImage(cardInfo: Card?) {
        if let cardInfo = cardInfo {
            self.frontImage = UIImage(imageLiteralResourceName: cardInfo.frontImageName)
            self.backImage = UIImage(imageLiteralResourceName: cardInfo.backImageName)
        } else {
            self.frontImage = nil
            self.backImage = nil
        }
        self.image = backImage
    }

    // 카드 앞뒷면 뒤집음
    func turnOver(_ faceToBeUp: Bool) {
        if faceToBeUp {
            image = self.frontImage
            isFaceUp = true
        } else {
            image = self.backImage
            isFaceUp = false
        }
    }

}
