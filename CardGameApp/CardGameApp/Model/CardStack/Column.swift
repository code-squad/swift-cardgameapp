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
    
    func isMoveable(_ card: Card) -> Bool {
        guard let peekCard = self.peek() else { return false }
        return peekCard.isDifferentColor(card: card) && peekCard.isOneStepDownRank(card: card)
    }
}
