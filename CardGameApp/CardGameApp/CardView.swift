//
//  CardView.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 1. 31..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class CardView: UIImageView {
    var frontImage: UIImage?
    private var backImage: UIImage = UIImage(imageLiteralResourceName: "card-back")
    private var sidePadding: CGFloat = 4
    private var isFaceUp: Bool = false
    var isVacant: Bool = false {
        didSet {
            if isVacant {
                self.image = frontImage
                self.isOpaque = true
            }
        }
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.origin = CGPoint(x: frame.origin.x+sidePadding, y: frame.origin.y)
        self.frame.size = CGSize(width: frame.size.width-sidePadding, height: frame.size.height)
        self.image = backImage
    }

    override var frame: CGRect {
        didSet {
            self.layer.cornerRadius = 5
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.borderWidth = 2
            self.clipsToBounds = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
