//
//  NotificationUtility.swift
//  CardGameApp
//
//  Created by TaeHyeonLee on 2018. 2. 23..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let openedCardDeck = Notification.Name("openedCardDeck")
    static let foundation = Notification.Name("foundation")
    static let sevenPiles = Notification.Name("sevenPiles")
    static let doubleTapped = Notification.Name("doubleTapped")
    static let tappedCardDeck = Notification.Name("tappedCardDeck")
    static let drag = Notification.Name("drag")
    static let success = Notification.Name("success")
}
