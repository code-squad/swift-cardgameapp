//
//  Goal.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goal: CardStack {

    override func addedCardsNotificationName() -> Notification.Name {
        return .goalDidAdd
    }
    
    override func poppedCountNotificationName() -> Notification.Name {
        return .goalDidPop
    }
}
