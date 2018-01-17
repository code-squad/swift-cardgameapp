//
//  EmptyCardView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 17..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class EmptyCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}
