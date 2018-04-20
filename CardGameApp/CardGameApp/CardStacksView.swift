//
//  CardStacksView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 19..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardStacksView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func draw(card: ImageSelector, in frame: CGRect) {
        let cardImage = CardImageView(frame: frame)
        cardImage.getImage(of: card)
        addSubview(cardImage)
    }

}

