//
//  Column.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Column: CardStack {

    override func addedCardsNotificationName() -> Notification.Name {
        return .columnDidAdd
    }
    
    override func poppedCountNotificationName() -> Notification.Name {
        return .columnDidPop
    }
}
