//
//  CardImageMaker.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func getBackImage() -> CardImageView {
        let cardBackImage = CardImageView(image: UIImage(named: "card-back"))
        cardBackImage.layer.cornerRadius = 5.0
        cardBackImage.clipsToBounds = true
        return cardBackImage
    }

}
