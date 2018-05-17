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

    func originalLocation(view: UIView, position: CGPoint) -> (UIView, Int?, Int?) {
        if let from = view as? OneStack {
            guard let column = stackColumn(originX: from.frame.origin.x) else {
                return (from, nil, nil)
            }
            return (from, column, cardIndexInStack(originY: position.y))
        } else if let from = view as? CardDeckView {
            return (from, nil, nil)
        }
        return (view, nil, nil)
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

}
