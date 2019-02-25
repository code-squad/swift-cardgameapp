//
//  CardStackOfStack.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 25..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class CardStackOfStack: CardStack {
    
    func userInfo(position: Int) -> [AnyHashable : Any] {
        var userInfo = super.userInfo()
        userInfo[UserInfoKey.position] = position
        return userInfo
    }
}
