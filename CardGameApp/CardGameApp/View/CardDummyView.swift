//
//  CardDummyView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 12..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardDummyView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        initCardDummy()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func initCardDummy() {
        self.subviews.forEach {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
        }
    }

    func removeAllCardDummy() {
        self.subviews.forEach { (view: UIView) in
            view.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
    }
}
