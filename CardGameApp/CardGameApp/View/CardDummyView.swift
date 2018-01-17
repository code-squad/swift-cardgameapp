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
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func position(index: Int) -> CGPoint {
        return subviews[index].frame.origin
    }

    func removeAllCardDummy() {
        self.subviews.forEach { (view: UIView) in
            view.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
    }
}

extension CardDummyView: CardStackMovableView {
    func pop(index: Int, previousCard: Card?) {
        // Not yet
    }

    func push(index: Int, cardView: CardView) {
        subviews[index].addSubview(cardView)
        cardView.fitLayout(with: subviews[index])
        cardView.isUserInteractionEnabled = false
    }
}
