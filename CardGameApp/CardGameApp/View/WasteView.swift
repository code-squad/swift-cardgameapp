//
//  WasteView.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 22..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class WasteView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func addDoubleTapGesture(action: Action) {
        let tapRecognizer = UITapGestureRecognizer(
            target: action.target, action: action.selector)
        tapRecognizer.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true
    }

    func addPangesture(action: Action) {
        let panRecognizer = UIPanGestureRecognizer(
            target: action.target, action: action.selector)
        self.addGestureRecognizer(panRecognizer)
        self.isUserInteractionEnabled = true
    }

    func removeAll() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func push(cardView: CardView) {
        addSubview(cardView)
        cardView.fitLayout(with: self)

    }
}

extension WasteView: MovableStartView {
    func position(_ point: CGPoint) -> Position? {
        guard subviews.last is CardView else {return nil}
        return Position(stackIndex: 0, cardIndex: 0)
    }

    func isLast(_ position: Position) -> Bool {
        return true
    }

    func selectedView(_ position: Position) -> CardView? {
        return subviews.last as? CardView
    }

    func belowViews(_ position: Position) -> [UIView] {
        guard let cardView = subviews.last else { return [] }
        return [cardView]
    }

    func coordinate(index: Int) -> CGPoint {
        return self.frame.origin
    }
}
