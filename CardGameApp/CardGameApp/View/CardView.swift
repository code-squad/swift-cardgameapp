//
//  CardView.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 3. 2..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class CardView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCardFigure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setCardFigure()
    }

    func setCardFigure() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }

    func setImage(name: String) {
        image = UIImage(named: name)
    }

}
