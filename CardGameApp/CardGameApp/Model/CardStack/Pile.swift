//
//  Pile.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Pile: CardStack {
    
    override func addedCardsNotificationName() -> Notification.Name {
        return .pileDidAdd
    }
    
    override func poppedCountNotificationName() -> Notification.Name {
        return .pileDidPop
    }
}

extension Notification.Name {
    static let pileDidAdd = Notification.Name("pileDidAdd")
    static let pileDidPop = Notification.Name("pileDidPop")
}
