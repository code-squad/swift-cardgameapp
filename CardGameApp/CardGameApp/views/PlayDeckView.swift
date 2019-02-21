//
//  PlayDeckView.swift
//  CardGameApp
//
//  Created by Yoda Codd on 2019. 2. 21..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class PlayDeckView: UIStackView {

    init(cardSize: CardSize, x: CGFloat, y: CGFloat){
        super.init(frame: CGRect(origin: CGPoint(x: x, y: y), size: cardSize.cardSize))
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
