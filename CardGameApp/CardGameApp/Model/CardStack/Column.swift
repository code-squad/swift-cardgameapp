//
//  Column.swift
//  CardGameApp
//
//  Created by 조재흥 on 19. 2. 21..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class Column: CardStack {

    override func postPoppedCountInfo(countOfPoppedCards: Int) {
        NotificationCenter.default.post(name: type(of: self).didPopNotiName(),
                                        object: self,
                                        userInfo: [UserInfoKey.countOfPoppedCards: countOfPoppedCards,
                                                   UserInfoKey.topCardOfStack: self.peek()])
    }
}
