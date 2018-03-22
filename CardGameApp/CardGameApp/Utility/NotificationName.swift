//
//  NotificationName.swift
//  CardGameApp
//
//  Created by Mrlee on 2018. 3. 8..
//  Copyright © 2018년 Napster. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var playingGameCardStack = Notification.Name("playingGameCardStack")
    static var playingOpenDeck = Notification.Name("playingOpenDeck")
    static var openCard = Notification.Name("openCard")
    static var cardLocation = Notification.Name("cardLocation")
    
    static var pushCardGameStack = Notification.Name("pushCardGameStack")
    
    static var pushFoundation = Notification.Name("pushCardFoundation")
    
    static var popOpenCard = Notification.Name("popCardOpen")
    static var pushOpenCard = Notification.Name("pushOpenCard")
    
    static var flipCard = Notification.Name("flipCard")
    static var cardName = Notification.Name("cardName")
    static var touchedView = Notification.Name("touchedView")
    static var subView = Notification.Name("subView")
    static var fromGlobalPoint = Notification.Name("fromGlobalPoint")
}
