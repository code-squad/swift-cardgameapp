//
//  CardBackImageView.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 3. 7..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class CardBackImageView: CardImageView {

    init() {
        let cardBackImage = UIImage(named: "card_back")
        super.init(image: cardBackImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
