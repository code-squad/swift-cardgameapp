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

extension CardDummyView: MovableView {
    func position(pos: CGPoint) -> Position? {
        return nil
    }

    func selectedView(pos: Position) -> CardView? {
        return nil
    }

    func coordinate(index: Int) -> CGPoint? {
        return CGPoint(x: 3*(index.cgfloat+1) + Size.cardWidth*index.cgfloat, y: Size.statusBarHeight)
    }
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
