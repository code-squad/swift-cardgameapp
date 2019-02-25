//
//  Column.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Column: CardStackOfStack {
    
    private let position: Int
    
    init(position: Int) {
        self.position = position
    }
    
    override func postInfo() {
        let userInfo = self.userInfo(position: position)
        NotificationCenter.default.post(name: .cardStackDidChange,
                                        object: self,
                                        userInfo: userInfo)
    }
}
