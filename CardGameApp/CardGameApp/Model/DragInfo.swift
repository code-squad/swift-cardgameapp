//
//  DragInfo.swift
//  CardGameApp
//
//  Created by yangpc on 2018. 1. 24..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

struct DragInfo {
    var baseView: UIView!
    var changes = [UIView]()
    var originals = [CGPoint]()
    var startView: MovableView?
    var startPos: Position?
    var targetPos: Position?

    init(view: UIView) {
        baseView = view
    }

    mutating func setDragInfo(_ gesture: UIPanGestureRecognizer) {
        let tappedLocation = gesture.location(in: self.baseView)
        guard let tappedView = gesture.view as? MovableView,
            let startPos = tappedView.position(tappedLocation) else { return }
        let belowViews = tappedView.belowViews(startPos)
        self.startView = tappedView
        self.startPos = startPos
        self.changes = belowViews
        self.changes.forEach { self.originals.append($0.center) }
    }

    func dragViews(_ gesture: UIPanGestureRecognizer) {
        self.changes.forEach {
            let translation = gesture.translation(in: self.baseView)
            $0.center = CGPoint(
                x: $0.center.x + translation.x,
                y: $0.center.y + translation.y)
        }
        gesture.setTranslation(CGPoint.zero, in: self.baseView)
    }

    func backToStartState() {
        var i = 0
        self.changes.forEach {
            $0.center.x = self.originals[i].x
            $0.center.y = self.originals[i].y
            i += 1
        }
    }

}
