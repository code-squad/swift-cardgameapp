//
//  FrameCalculator.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 17..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import UIKit

class FrameCalculator {

    let rootViewFrame = CGRect(x: 0,
                               y: 0,
                               width: ViewController.widthOfRootView,
                               height: ViewController.heightOfRootView)

    func originalLocation(view: UIView, position: CGPoint) -> (view: Movable, column: Int?, index: Int?) {
        if let from = view as? OneStack {
            //guard let fromView = from as? Movable else { return (from, nil, nil) }
            guard let column = stackColumn(originX: from.frame.origin.x) else {
                return (from, nil, nil)
            }
            return (from, column, cardIndexInStack(originY: position.y))
        } else if let from = view as? CardDeckView {
            return (from, nil, nil)
        }
        return (view as! Movable, nil, nil)
    }

    // origin.x로 검사하여 oneStackView의 column을 알아낸다.
    func stackColumn(originX: CGFloat) -> Int? {
        for x in PositionX.allValues {
            guard x.value == originX else { continue }
            return x.hashValue
        }
        return nil
    }

    // origin.y를 검사하여 oneStack내에서의 cardIndex를 알아낸다.
    func cardIndexInStack(originY: CGFloat) -> Int {
        return Int(originY / 15.0)
    }

    func originalLocation2(view: UIView, position: CGPoint) -> MoveInfo {
        if let from = view as? OneStack {
            //guard let fromView = from as? Movable else { return (from, nil, nil) }
            guard let column = stackColumn(originX: from.frame.origin.x) else {
                return MoveInfo(view: from, column: nil, index: nil)
            }
            return MoveInfo(view: from, column: column, index: cardIndexInStack(originY: position.y))
        } else if let from = view as? CardDeckView {
            return MoveInfo(view: from, column: nil, index: nil)
        }
        return MoveInfo(view: view as! Movable, column: nil, index: nil)
    }


}

class MoveInfo {
    var view: Movable
    var column: Int?
    var index: Int?

    init(view: Movable, column: Int?, index: Int?) {
        self.view = view
        self.column = column
        self.index = index
    }

    func getView() -> Movable {
        return self.view
    }

    func getColumn() -> Int? {
        guard self.column != nil else { return nil }
        return self.column!
    }

    func getIndex() -> Int? {
        guard self.index != nil else { return nil }
        return nil
    }

}
