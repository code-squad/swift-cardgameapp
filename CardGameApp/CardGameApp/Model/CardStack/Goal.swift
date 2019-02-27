//
//  Goal.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goal: CardStack {

    override func postInfo() {
        NotificationCenter.default.post(name: .goalDidChange,
                                        object: self,
                                        userInfo: self.userInfo())
    }
}
