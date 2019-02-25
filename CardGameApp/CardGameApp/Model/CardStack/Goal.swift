//
//  Goal.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Goal: CardStackOfStack {
    
    private let position: Suit
    
    init(suit: Suit) {
        self.position = suit
    }
    
    override func postInfo() {
        let userInfo = self.userInfo(position: position.rawValue)
        NotificationCenter.default.post(name: .cardStackDidChange,
                                        object: self,
                                        userInfo: userInfo)
    }
}
