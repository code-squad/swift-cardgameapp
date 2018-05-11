//
//  CustomExtension.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 5. 5..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let foundationUpdated = Notification.Name("foundationUpdated")
    static let deckUpdated = Notification.Name("deckUpdated")
    static let stackUpdated = Notification.Name("stackUpdated")
    static let singleTappedClosedDeck = Notification.Name("singleTappedClosedDeck")
    static let openDeckUpdated = Notification.Name("openDeckUpdated")
    static let doubleTappedStack = Notification.Name("doubleTappedStack")
    static let doubleTappedOpenedDeck = Notification.Name("doubleTappedOpenedDeck")
}
