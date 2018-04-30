//
//  FoundationView.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 23..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

class FoundationView: UIView {
    var foundationManager: FoundationManageable?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 414, height: 100))
    }

    func drawDefault() {
        let numberOfFoundation = 4
        for i in 0..<numberOfFoundation {
            let newOrigin = CGPoint(x: PositionX.allValues[i].value, y: PositionY.upper.value)
            let frameForDraw = CGRect(origin: newOrigin, size: ViewController.cardSize)
            let foundation = UIView(frame: frameForDraw)
            foundation.clipsToBounds = true
            foundation.layer.cornerRadius = 5.0
            foundation.layer.borderColor = UIColor.white.cgColor
            foundation.layer.borderWidth = 1.0
            addSubview(foundation)
        }

    }

}
