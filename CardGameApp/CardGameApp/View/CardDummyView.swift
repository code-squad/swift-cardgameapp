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

    func push(index: Int, cardViews: [CardView]) {
        cardViews.forEach {
            subviews[index].addSubview($0)
            $0.fitLayout(with: subviews[index])
            $0.isUserInteractionEnabled = false
        }
    }
}
