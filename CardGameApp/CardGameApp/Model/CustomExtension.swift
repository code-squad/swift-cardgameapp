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

extension CGPoint {
    func isContained(in view: UIView) -> (owner: ViewKey, index: Int)? {
        var owner: ViewKey = .deck
        var index = 0

        guard view.contains(point: self) else { return nil }
        switch view {
            case is CardDeckView: owner = .deck
            case is FoundationView: owner = .foundation
            case is OneStack:
                guard let activeView = view as? OneStack else { break }
                owner = .stack
                index = activeView.getColumn()
            default: owner = .deck
        }
        return (owner: owner, index: index)
    }
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
