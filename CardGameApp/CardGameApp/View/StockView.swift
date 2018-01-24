//
//  StockView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 24..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class StockView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.image = Image.backImage
    }

    func addTapGesture(action: Action) {
        let tapRecognizer = UITapGestureRecognizer(target: action.target, action: action.selector)
        tapRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapRecognizer)
    }
}
