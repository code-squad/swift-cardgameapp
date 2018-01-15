//
//  CardDummyView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 12..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class CardDummyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

    func position(index: Int) -> CGPoint {
        return subviews[index].frame.origin
    }

    func push(index: Int, cardView: UIView) {
        subviews[index].addSubview(cardView)
        cardView.setAutolayout()
        cardView.top(equal: subviews[index])
        cardView.leading(equal: subviews[index].leadingAnchor)
        cardView.trailing(equal: subviews[index].trailingAnchor)
        cardView.bottomAnchor.constraint(equalTo: subviews[index].bottomAnchor).isActive = true
        cardView.isUserInteractionEnabled = false
    }

    func removeAllCardDummy() {
        self.subviews.forEach { (view: UIView) in
            view.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
    }
}
