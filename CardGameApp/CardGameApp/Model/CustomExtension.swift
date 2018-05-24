//
//  CustomExtension.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 5..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static let foundationUpdated = Notification.Name("foundationUpdated")
    static let deckUpdated = Notification.Name("deckUpdated")
    static let stackUpdated = Notification.Name("stackUpdated")
    static let singleTappedClosedDeck = Notification.Name("singleTappedClosedDeck")
    static let openDeckUpdated = Notification.Name("openDeckUpdated")
    static let doubleTappedStack = Notification.Name("doubleTappedStack")
    static let doubleTappedOpenedDeck = Notification.Name("doubleTappedOpenedDeck")
    static let cardDragged = Notification.Name("cardDragged")
}

extension UIView {
    func contains(point: CGPoint) -> Bool {
        return self.frame.contains(point)
    }
}

extension CGFloat {

    // origin.y를 검사하여 oneStack내에서의 cardIndex를 알아낸다.
    func indexInStack() -> Int {
        return Int(self / 15.0)
    }

}
