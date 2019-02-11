//
//  CardSpaceView.swift
//  CardGameApp
//
//  Created by 윤지영 on 25/01/2019.
//  Copyright © 2019 윤지영. All rights reserved.
//

import UIKit

class CardSpaceView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    convenience init(origin: CGPoint = .zero, size: CGSize) {
        let frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
    }

    private func setUp() {
        colorBorder()
        roundCorners()
    }

    private func colorBorder() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.5
    }

    private func roundCorners() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

}
