//
//  Location.swift
//  CardGameApp
//
//  Created by 심 승민 on 2018. 2. 12..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

enum Location {
    case spare
    case waste
    case foundation(Int)
    case tableau(Int)
}

extension Location {
    func origin(inside view: UIView) -> CGPoint {
        guard let gameView = view as? GameView else { return CGPoint() }
        var origin = CGPoint()
        switch self {
        case .foundation(let spaceNumber):
            let stackX = gameView.foundationView.arrangedSubviews[spaceNumber].frame.origin.x
            let stackY = gameView.foundationView.arrangedSubviews[spaceNumber].convertOrigin(relativeTo: gameView).y
            origin = CGPoint(x: stackX, y: stackY)
        case .tableau(let stackNumber):
            let stackX = gameView.tableauViews[stackNumber].frame.origin.x
            let stackY = gameView.tableauViews[stackNumber].convertOrigin(relativeTo: gameView).y
            origin = CGPoint(x: stackX, y: stackY)
        case .spare:
            origin = gameView.spareView.convertOrigin(relativeTo: gameView)
        case .waste:
            origin = gameView.wasteView.convertOrigin(relativeTo: gameView)
        }
        return origin
    }
}

extension UIView {
    func convertOrigin(relativeTo view: UIView) -> CGPoint {
        return self.convert(self.frame.origin, to: view)
    }
}
