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
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }

    convenience init(frame: CGRect, frontImage: UIImage?, backImage: UIImage?) {
        self.init(frame: frame)
        self.frontImage = frontImage
        self.backImage = backImage
        self.image = backImage
    }

}

extension CardView {
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

    func setSizeConstraint(to size: CGSize) {
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width,
                                                 relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,
                                                 multiplier: 1.0, constant: size.width)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height,
                                                  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,
                                                  multiplier: 1.0, constant: size.height)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
    }

}
