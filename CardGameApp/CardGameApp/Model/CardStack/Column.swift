//
//  Column.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Column: CardStack {

    override func postInfo() {
        NotificationCenter.default.post(name: .columnDidChange,
                                        object: self,
                                        userInfo: self.userInfo())
    }
}
