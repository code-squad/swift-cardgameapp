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
    
    static var flipCard = Notification.Name("flipCard")
    static var cardLocation = Notification.Name("cardLocation")
    static var cardName = Notification.Name("cardName")
    static var cardAndIndex = Notification.Name("cardAndIndex")
    static var pushCardFoundationFromOpenDeck = Notification.Name("pushCardFoundationOpenCard")
    static var pushFoundationViewFromStackDeck = Notification.Name("pushFoundationViewFromStackDeck")
    static var popGameCardStack = Notification.Name("popGameCardStack")
}
