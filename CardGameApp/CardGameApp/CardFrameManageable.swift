//
//  CardFrameManageable.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 23..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import UIKit

protocol CardFrameManageable {
    func cardFrame(x: Int, y: CGFloat) -> CGRect
    func cardOrigin() -> CGPoint
}

class CardMaker: CardFrameManageable {
    var sizeOfRootView: CGSize?

    var spaceX: CGFloat {
        return ((self.sizeOfRootView?.width)! / ViewController.widthDivider) / ViewController.widthDivider
    }

    init(size: CGSize) {
        self.sizeOfRootView = size
    }

    func cardFrame(x: Int, y: CGFloat) -> CGRect {
        let cardWidth = (sizeOfRootView?.width)! / ViewController.widthDivider
        let cardheight = cardWidth * ViewController.cardHeightRatio
        let newX: CGFloat = (CGFloat(x+1)*spaceX) + (CGFloat(x) * cardWidth)
        let newY: CGFloat = y

        return CGRect(x: newX,
                      y: newY,
                      width: cardWidth,
                      height: cardheight)
    }

    func cardOrigin() -> CGPoint {
        return CGPoint(x: 0.0, y: 0.0)
    }
}


