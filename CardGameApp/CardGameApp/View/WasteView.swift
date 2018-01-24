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
}

extension WasteView: MovableView {

    func targetCoordinate(index: Int) -> CGPoint {
        return CGPoint.zero
    }

    func isLast(_ position: Position) -> Bool {
        return true
    }

    func pop(index: Int = 0, previousCard: Card? = nil) {
        subviews.last?.removeFromSuperview()
    }

    func position(_ point: CGPoint) -> Position? {
        guard subviews.last is CardView else {return nil}
        return Position(stackIndex: 0, cardIndex: 0)
    }

    func selectedView(_ position: Position) -> CardView? {
        return subviews.last as? CardView
    }
    func coordinate(index: Int) -> CGPoint {
        return self.frame.origin
    }

    func push(index: Int = 0, cardViews: [CardView]) {
        cardViews.forEach {
            addSubview($0)
            $0.fitLayout(with: self)
        }
    }

    func belowViews(_ position: Position) -> [UIView] {
        guard let cardView = subviews.last else { return [] }
        return [cardView]
    }

}
