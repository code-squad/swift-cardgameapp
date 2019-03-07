//
//  Preview.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Preview: CardStack {
    
    override func addedCardsNotificationName() -> Notification.Name {
        return .previewDidAdd
    }
    
    override func poppedCountNotificationName() -> Notification.Name {
        return .previewDidPop
    }
}

extension Notification.Name {
    static let previewDidAdd = Notification.Name("previewDidAdd")
    static let previewDidPop = Notification.Name("previewDidPop")
}
